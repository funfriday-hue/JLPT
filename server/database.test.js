import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import test from "node:test";
import mysql from "mysql2/promise";
import {seedQuestions, seedSets} from "./data.js";
import {seedWithClient} from "./seed.js";

const databaseUrl = process.env.TEST_DATABASE_URL;

test("schema creates a seedable MySQL content database", {skip: !databaseUrl}, async () => {
  const url = new URL(databaseUrl);
  const connection = await mysql.createConnection({
    host: url.hostname,
    port: Number(url.port || 3306),
    user: decodeURIComponent(url.username),
    password: decodeURIComponent(url.password),
    database: decodeURIComponent(url.pathname.replace(/^\//, "")),
    multipleStatements: true,
  });
  try {
    const sql = await readFile(new URL("./migrations/001_initial.sql", import.meta.url), "utf8");
    await connection.query(sql);
    const client = {query: (text, values = []) => connection.execute(text, values)};
    await seedWithClient(client);

    const [[sets]] = await connection.query("SELECT COUNT(*) AS count FROM exam_sets");
    const [[questions]] = await connection.query("SELECT COUNT(*) AS count FROM questions");
    assert.equal(sets.count, seedSets.length);
    assert.equal(questions.count, seedQuestions.length);

    const [[answer]] = await connection.execute("SELECT options, answer_index FROM questions WHERE id = ?", [seedQuestions[0].id]);
    const options = typeof answer.options === "string" ? JSON.parse(answer.options) : answer.options;
    assert.deepEqual(options, seedQuestions[0].options);
    assert.equal(answer.answer_index, seedQuestions[0].answer);
  } finally {
    await connection.end();
  }
});
