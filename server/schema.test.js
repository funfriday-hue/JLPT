import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import test from "node:test";

test("SQL schema stores content and user completion history", async () => {
  const sql = await readFile(new URL("./migrations/001_initial.sql", import.meta.url), "utf8");
  for (const table of [
    "users",
    "exam_sets",
    "questions",
    "practice_completions",
    "test_attempts",
    "test_attempt_questions",
    "test_attempt_answers",
    "user_best_scores",
  ]) {
    assert.match(sql, new RegExp(`CREATE TABLE IF NOT EXISTS ${table}\\b`));
  }
});
