import assert from "node:assert/strict";
import test from "node:test";
import request from "supertest";
import {createApp} from "./app.js";
import {seedQuestions, seedSets} from "./data.js";

function memoryDatabase() {
  const state = {
    attempts: new Map(),
    attemptQuestions: new Map(),
    bestScores: new Map(),
    practiceCompletions: [],
    testAnswers: [],
  };

  const result = (rows = [], rowCount = rows.length) => ({rows, rowCount});
  const compact = (sql) => sql.replace(/\s+/g, " ").trim();

  async function query(sql, values = []) {
    const text = compact(sql);
    if (text === "SELECT 1") return result([{1: 1}]);
    if (text.startsWith("SELECT id, level, order_no, title, description, duration_minutes FROM exam_sets WHERE active")) {
      return result(seedSets.filter((set) => set.active).map((set) => ({
        id: set.id,
        level: set.level,
        order_no: set.order,
        title: set.title,
        description: set.description,
        duration_minutes: set.durationMinutes,
      })));
    }
    if (text.startsWith("SELECT set_id, section, COUNT(*) AS question_count FROM questions")) {
      const counts = new Map();
      for (const question of seedQuestions.filter((item) => item.active)) {
        const key = `${question.setId}:${question.section}`;
        counts.set(key, (counts.get(key) || 0) + 1);
      }
      return result([...counts].map(([key, question_count]) => {
        const [set_id, section] = key.split(":");
        return {set_id, section, question_count};
      }));
    }
    if (text.includes("FROM user_best_scores") && text.includes("ORDER BY updated_at DESC")) {
      return result([...state.bestScores.values()].filter((score) => score.firebase_uid === values[0]));
    }
    if (text.startsWith("SELECT id, set_id, section, prompt, prompt_en, options, audio_text FROM questions")) {
      const [section, , excluded] = values;
      const question = seedQuestions.find((item) => item.active && item.id !== excluded && (section === "random" || item.section === section));
      return result(question ? [{
        id: question.id,
        set_id: question.setId,
        section: question.section,
        prompt: question.prompt,
        prompt_en: question.promptEn,
        options: question.options,
        audio_text: question.audioText,
      }] : []);
    }
    if (text.startsWith("SELECT answer_index, explanation, JSON_LENGTH(options) AS option_count")) {
      const question = seedQuestions.find((item) => item.id === values[0] && item.active);
      return result(question ? [{answer_index: question.answer, explanation: question.explanation, option_count: question.options.length}] : []);
    }
    if (text.startsWith("INSERT INTO practice_completions")) {
      state.practiceCompletions.push(values);
      return result([], 1);
    }
    if (text.startsWith("SELECT id, level, order_no, title, description, duration_minutes FROM exam_sets WHERE id")) {
      const set = seedSets.find((item) => item.id === values[0] && item.active);
      return result(set ? [{
        id: set.id,
        level: set.level,
        order_no: set.order,
        title: set.title,
        description: set.description,
        duration_minutes: set.durationMinutes,
      }] : []);
    }
    if (text.startsWith("SELECT id, set_id, section, prompt, options, audio_text FROM questions WHERE set_id")) {
      const [setId, section] = values;
      return result(seedQuestions.filter((item) => item.setId === setId && item.active && (section === "all" || item.section === section)).map((question) => ({
        id: question.id,
        set_id: question.setId,
        section: question.section,
        prompt: question.prompt,
        options: question.options,
        audio_text: question.audioText,
      })));
    }
    if (text.startsWith("INSERT INTO test_attempts")) {
      const [id, firebase_uid, set_id, section, total_count] = values;
      state.attempts.set(id, {id, firebase_uid, set_id, section, total_count, status: "in_progress", correct_count: null, percent: null});
      return result([], 1);
    }
    if (text.startsWith("INSERT INTO test_attempt_questions")) {
      const [attemptId, questionId, position] = values;
      const questions = state.attemptQuestions.get(attemptId) || [];
      questions.push({questionId, position});
      state.attemptQuestions.set(attemptId, questions);
      return result([], 1);
    }
    if (text.includes("FROM test_attempts") && text.includes("FOR UPDATE")) {
      const attempt = state.attempts.get(values[0]);
      return result(attempt && attempt.firebase_uid === values[1] ? [attempt] : []);
    }
    if (text.startsWith("SELECT q.id, q.answer_index, JSON_LENGTH(q.options) AS option_count")) {
      const questions = (state.attemptQuestions.get(values[0]) || []).sort((a, b) => a.position - b.position).map(({questionId}) => {
        const question = seedQuestions.find((item) => item.id === questionId);
        return {id: question.id, answer_index: question.answer, option_count: question.options.length};
      });
      return result(questions);
    }
    if (text.startsWith("INSERT INTO test_attempt_answers")) {
      state.testAnswers.push(values);
      return result([], 1);
    }
    if (text.startsWith("UPDATE test_attempts SET status")) {
      const [correct_count, percent, id] = values;
      Object.assign(state.attempts.get(id), {status: "completed", correct_count, percent});
      return result([], 1);
    }
    if (text.startsWith("INSERT INTO user_best_scores")) {
      const [firebase_uid, set_id, section, correct_count, total_count, percent, attempt_id] = values;
      const key = `${firebase_uid}:${set_id}:${section}`;
      const current = state.bestScores.get(key);
      if (!current || percent > current.percent) {
        state.bestScores.set(key, {firebase_uid, set_id, section, correct_count, total_count, percent, attempt_id, updated_at: new Date()});
      }
      return result([], 1);
    }
    if (text.includes("FROM user_best_scores WHERE firebase_uid = ? AND set_id = ? AND section = ?")) {
      const score = state.bestScores.get(`${values[0]}:${values[1]}:${values[2]}`);
      return result(score ? [score] : []);
    }
    throw new Error(`Unhandled test query: ${text}`);
  }

  return {
    query,
    transaction: (callback) => callback({query}),
    state,
  };
}

test("practice and MySQL-backed mock-test flows persist completion data", async () => {
  const database = memoryDatabase();
  const authMiddleware = (req, _res, next) => {
    req.user = {uid: "test-user", email: "learner@example.com"};
    next();
  };
  const app = createApp({runQuery: database.query, runTransaction: database.transaction, authMiddleware});

  const health = await request(app).get("/api/health").expect(200);
  assert.equal(health.body.database, "mysql");
  assert.match(
    health.headers["content-security-policy"],
    /script-src 'self' https:\/\/www\.gstatic\.com https:\/\/apis\.google\.com/,
  );

  const sets = await request(app).get("/api/sets").expect(200);
  assert.equal(sets.body.sets.length, seedSets.length);
  assert.ok(sets.body.sets[0].counts.vocabulary > 0);

  const practice = await request(app).get("/api/practice/random?section=vocabulary").expect(200);
  assert.ok(practice.body.question.promptEn);
  assert.equal("answer" in practice.body.question, false);
  const practiceSource = seedQuestions.find((question) => question.id === practice.body.question.id);
  await request(app)
    .post("/api/practice/check")
    .send({questionId: practiceSource.id, choice: practiceSource.answer})
    .expect(200)
    .expect(({body}) => assert.equal(body.correct, true));
  assert.equal(database.state.practiceCompletions.length, 1);

  const started = await request(app)
    .post("/api/tests/n5-set-1/start")
    .send({section: "all"})
    .expect(201);
  assert.equal(started.body.durationMinutes, 90);
  assert.ok(started.body.attemptId);
  for (const question of started.body.questions) {
    assert.equal("promptEn" in question, false);
    assert.equal("answer" in question, false);
  }
  const answers = Object.fromEntries(started.body.questions.map((question) => [
    question.id,
    seedQuestions.find((source) => source.id === question.id).answer,
  ]));
  const submitted = await request(app)
    .post(`/api/tests/attempts/${started.body.attemptId}/submit`)
    .send({answers})
    .expect(200);
  assert.equal(submitted.body.result.percent, 100);
  assert.equal(submitted.body.best.percent, 100);
  assert.equal(database.state.testAnswers.length, started.body.questions.length);

  const scores = await request(app).get("/api/scores").expect(200);
  assert.equal(scores.body.scores[0].percent, 100);

  const testPage = await request(app).get("/tests").expect(200);
  assert.doesNotMatch(testPage.text, /English reveal disabled/i);

  const homePage = await request(app).get("/").expect(200);
  assert.match(homePage.text, /<span class="mark">JQ<\/span><span>jlptquiz\.in<\/span>/);
  assert.match(homePage.text, /JLPT Quiz — N5 Practice/);
  assert.doesNotMatch(homePage.text, /Japanesenx/i);

  const robots = await request(app).get("/robots.txt").expect(200);
  assert.match(robots.text, /Disallow: \/api\//);
  assert.match(robots.text, /Sitemap: http:\/\//);

  const sitemap = await request(app).get("/sitemap.xml").expect(200);
  assert.match(sitemap.text, /<loc>http:\/\/.+\/practice<\/loc>/);
  assert.doesNotMatch(sitemap.text, /practice\/session|tests\/session/);
});
