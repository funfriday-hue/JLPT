import express from "express";
import {randomUUID} from "node:crypto";
import {readFileSync} from "node:fs";
import {dirname, join, resolve} from "node:path";
import {fileURLToPath} from "node:url";
import {requireUser} from "./auth.js";
import {query as defaultQuery, withTransaction as defaultTransaction} from "./db.js";

const allowedPracticeSections = new Set(["random", "vocabulary", "grammar-reading", "listening"]);
const allowedTestSections = new Set(["all", "vocabulary", "grammar-reading", "listening"]);
const currentDirectory = dirname(fileURLToPath(import.meta.url));
const publicDirectory = resolve(currentDirectory, "../public");
const canonicalOrigin = "https://jlptquiz.in";

function sectionDuration(section) {
  return {vocabulary: 20, "grammar-reading": 40, listening: 30, all: 90}[section] || 90;
}

function publicQuestion(row, includeEnglish = false) {
  return {
    id: row.id,
    setId: row.set_id,
    section: row.section,
    prompt: row.prompt,
    ...(includeEnglish ? {promptEn: row.prompt_en} : {}),
    options: row.options,
    audioText: row.audio_text || null,
  };
}

function scoreResponse(row) {
  return {
    setId: row.set_id,
    section: row.section,
    correct: row.correct_count,
    total: row.total_count,
    percent: row.percent,
    updatedAt: row.updated_at,
  };
}

function siteOrigin(req) {
  return (process.env.PUBLIC_BASE_URL || `${req.protocol}://${req.get("host")}`).replace(/\/$/, "");
}

function setSecurityHeaders(_req, res, next) {
  res.set({
    "X-Content-Type-Options": "nosniff",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    "Permissions-Policy": "camera=(), microphone=(), geolocation=()",
    "Content-Security-Policy": [
      "default-src 'self'",
      "script-src 'self' https://www.gstatic.com",
      "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
      "font-src 'self' https://fonts.gstatic.com",
      "img-src 'self' data: https:",
      "connect-src 'self' https://*.googleapis.com https://securetoken.googleapis.com https://identitytoolkit.googleapis.com",
      "frame-src 'self' https://accounts.google.com https://japanesenx-aman.firebaseapp.com",
      "object-src 'none'",
      "base-uri 'self'",
      "form-action 'self'",
    ].join("; "),
  });
  next();
}

function corsForConfiguredOrigin(req, res, next) {
  const configured = process.env.CORS_ORIGIN;
  if (!configured || !req.get("origin")) return next();
  const allowed = configured.split(",").map((origin) => origin.trim());
  if (allowed.includes(req.get("origin"))) {
    res.set("Access-Control-Allow-Origin", req.get("origin"));
    res.set("Vary", "Origin");
    res.set("Access-Control-Allow-Headers", "Authorization, Content-Type");
    res.set("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
    if (req.method === "OPTIONS") return res.status(204).end();
  }
  return next();
}

export function createApp({
  runQuery = defaultQuery,
  runTransaction = defaultTransaction,
  authMiddleware = requireUser,
} = {}) {
  const app = express();
  app.disable("x-powered-by");
  if (process.env.TRUST_PROXY === "true") app.set("trust proxy", 1);
  app.use(setSecurityHeaders);
  app.use(corsForConfiguredOrigin);
  app.use(express.json({limit: "32kb"}));

  app.get("/api/health", async (_req, res, next) => {
    try {
      await runQuery("SELECT 1");
      return res.json({ok: true, service: "jlptquiz-api", database: "postgresql"});
    } catch (error) {
      return next(error);
    }
  });

  app.get("/api/sets", async (_req, res, next) => {
    try {
      const result = await runQuery(
        `SELECT
           s.id, s.level, s.order_no, s.title, s.description, s.duration_minutes,
           COALESCE(
             jsonb_object_agg(counts.section, counts.question_count) FILTER (WHERE counts.section IS NOT NULL),
             '{}'::jsonb
           ) AS counts
         FROM exam_sets s
         LEFT JOIN (
           SELECT set_id, section, COUNT(*)::integer AS question_count
           FROM questions
           WHERE active = TRUE
           GROUP BY set_id, section
         ) counts ON counts.set_id = s.id
         WHERE s.active = TRUE AND s.level = 'N5'
         GROUP BY s.id
         ORDER BY s.order_no`,
      );
      const sets = result.rows.map((row) => ({
        id: row.id,
        level: row.level,
        order: row.order_no,
        title: row.title,
        description: row.description,
        durationMinutes: row.duration_minutes,
        counts: row.counts,
      }));
      return res.json({sets});
    } catch (error) {
      return next(error);
    }
  });

  app.get("/api/scores", authMiddleware, async (req, res, next) => {
    try {
      const result = await runQuery(
        `SELECT set_id, section, correct_count, total_count, percent, updated_at
         FROM user_best_scores
         WHERE firebase_uid = $1
         ORDER BY updated_at DESC`,
        [req.user.uid],
      );
      return res.json({scores: result.rows.map(scoreResponse)});
    } catch (error) {
      return next(error);
    }
  });

  app.get("/api/practice/random", authMiddleware, async (req, res, next) => {
    try {
      const section = String(req.query.section || "random");
      const excluded = String(req.query.exclude || "");
      if (!allowedPracticeSections.has(section)) return res.status(400).json({error: "Invalid practice section."});
      const result = await runQuery(
        `SELECT id, set_id, section, prompt, prompt_en, options, audio_text
         FROM questions
         WHERE active = TRUE
           AND level = 'N5'
           AND ($1 = 'random' OR section = $1)
         ORDER BY CASE WHEN id = $2 THEN 1 ELSE 0 END, RANDOM()
         LIMIT 1`,
        [section, excluded],
      );
      if (!result.rowCount) return res.status(404).json({error: "No active questions are available."});
      return res.json({question: publicQuestion(result.rows[0], true)});
    } catch (error) {
      return next(error);
    }
  });

  app.post("/api/practice/check", authMiddleware, async (req, res, next) => {
    const questionId = String(req.body.questionId || "");
    const choice = req.body.choice;
    if (!questionId || !Number.isInteger(choice) || choice < 0) {
      return res.status(400).json({error: "Choose an answer first."});
    }
    try {
      const result = await runTransaction(async (client) => {
        const question = await client.query(
          `SELECT answer_index, explanation, jsonb_array_length(options) AS option_count
           FROM questions WHERE id = $1 AND active = TRUE`,
          [questionId],
        );
        if (!question.rowCount) return null;
        const data = question.rows[0];
        if (choice >= data.option_count) return {invalid: true};
        const correct = choice === data.answer_index;
        await client.query(
          `INSERT INTO practice_completions (firebase_uid, question_id, selected_index, correct)
           VALUES ($1, $2, $3, $4)`,
          [req.user.uid, questionId, choice, correct],
        );
        return {correct, correctChoice: data.answer_index, explanation: data.explanation};
      });
      if (!result) return res.status(404).json({error: "Question not found."});
      if (result.invalid) return res.status(400).json({error: "Invalid answer choice."});
      return res.json(result);
    } catch (error) {
      return next(error);
    }
  });

  app.post("/api/tests/:setId/start", authMiddleware, async (req, res, next) => {
    const section = String(req.body.section || "all");
    if (!allowedTestSections.has(section)) return res.status(400).json({error: "Invalid test section."});
    try {
      const payload = await runTransaction(async (client) => {
        const setResult = await client.query(
          `SELECT id, level, order_no, title, description, duration_minutes
           FROM exam_sets WHERE id = $1 AND active = TRUE`,
          [req.params.setId],
        );
        if (!setResult.rowCount) return null;
        const questionResult = await client.query(
          `SELECT id, set_id, section, prompt, options, audio_text
           FROM questions
           WHERE set_id = $1 AND active = TRUE AND ($2 = 'all' OR section = $2)
           ORDER BY order_no`,
          [req.params.setId, section],
        );
        if (!questionResult.rowCount) return {empty: true};
        const attemptId = randomUUID();
        await client.query(
          `INSERT INTO test_attempts (id, firebase_uid, set_id, section, total_count)
           VALUES ($1, $2, $3, $4, $5)`,
          [attemptId, req.user.uid, req.params.setId, section, questionResult.rowCount],
        );
        for (const [position, question] of questionResult.rows.entries()) {
          await client.query(
            `INSERT INTO test_attempt_questions (attempt_id, question_id, position)
             VALUES ($1, $2, $3)`,
            [attemptId, question.id, position + 1],
          );
        }
        const set = setResult.rows[0];
        return {
          attemptId,
          test: {
            id: set.id,
            level: set.level,
            order: set.order_no,
            title: set.title,
            description: set.description,
          },
          section,
          durationMinutes: sectionDuration(section),
          questions: questionResult.rows.map((question) => publicQuestion(question, false)),
        };
      });
      if (!payload) return res.status(404).json({error: "Test paper not found."});
      if (payload.empty) return res.status(404).json({error: "This test has no active questions yet."});
      return res.status(201).json(payload);
    } catch (error) {
      return next(error);
    }
  });

  app.post("/api/tests/attempts/:attemptId/submit", authMiddleware, async (req, res, next) => {
    const answers = req.body.answers && typeof req.body.answers === "object" ? req.body.answers : {};
    try {
      const payload = await runTransaction(async (client) => {
        const attemptResult = await client.query(
          `SELECT id, set_id, section, status, correct_count, total_count, percent
           FROM test_attempts
           WHERE id = $1 AND firebase_uid = $2
           FOR UPDATE`,
          [req.params.attemptId, req.user.uid],
        );
        if (!attemptResult.rowCount) return null;
        const attempt = attemptResult.rows[0];
        if (attempt.status === "completed") {
          const bestResult = await client.query(
            `SELECT set_id, section, correct_count, total_count, percent, updated_at
             FROM user_best_scores WHERE firebase_uid = $1 AND set_id = $2 AND section = $3`,
            [req.user.uid, attempt.set_id, attempt.section],
          );
          return {
            result: {correct: attempt.correct_count, total: attempt.total_count, percent: attempt.percent},
            best: scoreResponse(bestResult.rows[0]),
          };
        }
        const questions = await client.query(
          `SELECT q.id, q.answer_index, jsonb_array_length(q.options) AS option_count
           FROM test_attempt_questions aq
           JOIN questions q ON q.id = aq.question_id
           WHERE aq.attempt_id = $1
           ORDER BY aq.position`,
          [attempt.id],
        );
        let correct = 0;
        for (const question of questions.rows) {
          const raw = answers[question.id];
          const selected = raw === undefined || raw === null || raw === "" ? null : Number(raw);
          const isValid = selected === null || (Number.isInteger(selected) && selected >= 0 && selected < question.option_count);
          if (!isValid) throw Object.assign(new Error("Invalid answer choice."), {statusCode: 400});
          const isCorrect = selected === question.answer_index;
          if (isCorrect) correct += 1;
          await client.query(
            `INSERT INTO test_attempt_answers (attempt_id, question_id, selected_index, correct)
             VALUES ($1, $2, $3, $4)
             ON CONFLICT (attempt_id, question_id) DO UPDATE SET
               selected_index = EXCLUDED.selected_index,
               correct = EXCLUDED.correct,
               answered_at = NOW()`,
            [attempt.id, question.id, selected, isCorrect],
          );
        }
        const total = questions.rowCount;
        const percent = Math.round((correct / total) * 100);
        await client.query(
          `UPDATE test_attempts SET status = 'completed', correct_count = $2, percent = $3, completed_at = NOW()
           WHERE id = $1`,
          [attempt.id, correct, percent],
        );
        await client.query(
          `INSERT INTO user_best_scores
             (firebase_uid, set_id, section, correct_count, total_count, percent, attempt_id)
           VALUES ($1, $2, $3, $4, $5, $6, $7)
           ON CONFLICT (firebase_uid, set_id, section) DO UPDATE SET
             correct_count = EXCLUDED.correct_count,
             total_count = EXCLUDED.total_count,
             percent = EXCLUDED.percent,
             attempt_id = EXCLUDED.attempt_id,
             updated_at = NOW()
           WHERE EXCLUDED.percent > user_best_scores.percent`,
          [req.user.uid, attempt.set_id, attempt.section, correct, total, percent, attempt.id],
        );
        const bestResult = await client.query(
          `SELECT set_id, section, correct_count, total_count, percent, updated_at
           FROM user_best_scores WHERE firebase_uid = $1 AND set_id = $2 AND section = $3`,
          [req.user.uid, attempt.set_id, attempt.section],
        );
        return {
          result: {correct, total, percent},
          best: scoreResponse(bestResult.rows[0]),
        };
      });
      if (!payload) return res.status(404).json({error: "Test attempt not found."});
      return res.json(payload);
    } catch (error) {
      return next(error);
    }
  });

  app.use("/api", (_req, res) => res.status(404).json({error: "Endpoint not found."}));

  const pages = new Map([
    ["/", "index.html"],
    ["/practice", "practice/index.html"],
    ["/practice/", "practice/index.html"],
    ["/practice/session", "practice/session/index.html"],
    ["/practice/session/", "practice/session/index.html"],
    ["/tests", "tests/index.html"],
    ["/tests/", "tests/index.html"],
    ["/tests/session", "tests/session/index.html"],
    ["/tests/session/", "tests/session/index.html"],
    ["/login", "login/index.html"],
    ["/login/", "login/index.html"],
    ["/about", "about/index.html"],
    ["/about/", "about/index.html"],
  ]);
  for (const [route, file] of pages) {
    const template = readFileSync(join(publicDirectory, file), "utf8");
    app.get(route, (req, res) => {
      const html = template.replaceAll(canonicalOrigin, siteOrigin(req));
      return res.type("html").send(html);
    });
  }
  const robots = readFileSync(join(publicDirectory, "robots.txt"), "utf8");
  const sitemap = readFileSync(join(publicDirectory, "sitemap.xml"), "utf8");
  app.get("/robots.txt", (req, res) => res.type("text").send(robots.replaceAll(canonicalOrigin, siteOrigin(req))));
  app.get("/sitemap.xml", (req, res) => res.type("application/xml").send(sitemap.replaceAll(canonicalOrigin, siteOrigin(req))));
  app.use(express.static(publicDirectory, {index: false, maxAge: process.env.NODE_ENV === "production" ? "1h" : 0}));
  app.use((_req, res) => res.status(404).sendFile(join(publicDirectory, "404.html")));

  app.use((error, _req, res, _next) => {
    console.error(error);
    const status = Number(error.statusCode) || 500;
    return res.status(status).json({error: status === 500 ? "The server could not complete this request." : error.message});
  });

  return app;
}
