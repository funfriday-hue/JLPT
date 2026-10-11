import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import test from "node:test";
import {DataType, newDb} from "pg-mem";
import {seedQuestions, seedSets} from "./data.js";
import {seedWithClient} from "./seed.js";

test("migration creates a seedable PostgreSQL content database", async () => {
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
  const adapter = memory.adapters.createPg();
  const pool = new adapter.Pool();
  const sql = await readFile(new URL("./migrations/001_initial.sql", import.meta.url), "utf8");

  await pool.query(sql);
  await seedWithClient(pool);

  const sets = await pool.query("SELECT COUNT(*)::integer AS count FROM exam_sets");
  const questions = await pool.query("SELECT COUNT(*)::integer AS count FROM questions");
  assert.equal(sets.rows[0].count, seedSets.length);
  assert.equal(questions.rows[0].count, seedQuestions.length);

  const answer = await pool.query(
    "SELECT options, answer_index FROM questions WHERE id = $1",
    [seedQuestions[0].id],
  );
  assert.deepEqual(answer.rows[0].options, seedQuestions[0].options);
  assert.equal(answer.rows[0].answer_index, seedQuestions[0].answer);
  await pool.end();
});
