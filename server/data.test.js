import assert from "node:assert/strict";
import test from "node:test";
import {seedQuestions, seedSets} from "./data.js";

test("starter sets and questions have unique ids", () => {
  assert.equal(new Set(seedSets.map((set) => set.id)).size, seedSets.length);
  assert.equal(new Set(seedQuestions.map((question) => question.id)).size, seedQuestions.length);
});

test("every question belongs to a known N5 set", () => {
  const setIds = new Set(seedSets.map((set) => set.id));
  for (const question of seedQuestions) {
    assert.equal(question.level, "N5");
    assert.ok(setIds.has(question.setId));
    assert.ok(["vocabulary", "grammar-reading", "listening"].includes(question.section));
    assert.ok(question.options.length >= 2);
    assert.ok(Number.isInteger(question.answer));
    assert.ok(question.answer >= 0 && question.answer < question.options.length);
  }
});

test("listening questions include spoken Japanese", () => {
  for (const question of seedQuestions.filter((item) => item.section === "listening")) {
    assert.ok(question.audioText);
  }
});
