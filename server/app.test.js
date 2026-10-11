import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import test from "node:test";
import {DataType, newDb} from "pg-mem";
import request from "supertest";
import {createApp} from "./app.js";
import {seedQuestions} from "./data.js";
import {seedWithClient} from "./seed.js";

async function testDatabase() {
  const memory = newDb();
  memory.public.registerFunction({
    name: "jsonb_typeof",
    args: [DataType.jsonb],
    returns: DataType.text,
    implementation: (value) => Array.isArray(value) ? "array" : typeof value,
  });
  memory.public.registerFunction({
    name: "jsonb_array_length",
    args: [DataType.jsonb],
    returns: DataType.integer,
    implementation: (value) => value.length,
  });
  memory.public.registerFunction({
    name: "random",
    returns: DataType.float,
    impure: true,
    implementation: () => Math.random(),
  });
  const adapter = memory.adapters.createPg();
  const pool = new adapter.Pool();
  const sql = await readFile(new URL("./migrations/001_initial.sql", import.meta.url), "utf8");
  await pool.query(sql);
  await seedWithClient(pool);
  await pool.query(
    `INSERT INTO users (firebase_uid, email, display_name)
     VALUES ('test-user', 'learner@example.com', 'Test learner')`,
  );
  return pool;
}

test("practice and mock-test flows persist completion data", async () => {
  const pool = await testDatabase();
  const runTransaction = async (callback) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");
      const result = await callback(client);
      await client.query("COMMIT");
      return result;
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  };
  const authMiddleware = (req, _res, next) => {
    req.user = {uid: "test-user", email: "learner@example.com"};
    next();
  };
  const app = createApp({runQuery: pool.query.bind(pool), runTransaction, authMiddleware});

  const practice = await request(app).get("/api/practice/random?section=vocabulary").expect(200);
  assert.ok(practice.body.question.promptEn);
  assert.equal("answer" in practice.body.question, false);
  const practiceSource = seedQuestions.find((question) => question.id === practice.body.question.id);
  await request(app)
    .post("/api/practice/check")
    .send({questionId: practiceSource.id, choice: practiceSource.answer})
    .expect(200)
    .expect(({body}) => assert.equal(body.correct, true));
  const practiceCount = await pool.query("SELECT COUNT(*)::integer AS count FROM practice_completions");
  assert.equal(practiceCount.rows[0].count, 1);

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
  const answers = Object.fromEntries(
    started.body.questions.map((question) => [
      question.id,
      seedQuestions.find((source) => source.id === question.id).answer,
    ]),
  );
  const submitted = await request(app)
    .post(`/api/tests/attempts/${started.body.attemptId}/submit`)
    .send({answers})
    .expect(200);
  assert.equal(submitted.body.result.percent, 100);
  assert.equal(submitted.body.best.percent, 100);

  const answerCount = await pool.query(
    "SELECT COUNT(*)::integer AS count FROM test_attempt_answers WHERE attempt_id = $1",
    [started.body.attemptId],
  );
  assert.equal(answerCount.rows[0].count, started.body.questions.length);

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
  await pool.end();
});
