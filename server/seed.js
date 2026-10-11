import "dotenv/config";
import {pathToFileURL} from "node:url";
import {seedQuestions, seedSets} from "./data.js";
import {closePool, withTransaction} from "./db.js";

export async function seedWithClient(client) {
    for (const set of seedSets) {
      await client.query(
        `INSERT INTO exam_sets (id, level, order_no, title, description, active, duration_minutes)
         VALUES (?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE
           level = VALUES(level),
           order_no = VALUES(order_no),
           title = VALUES(title),
           description = VALUES(description),
           active = VALUES(active),
           duration_minutes = VALUES(duration_minutes),
           updated_at = CURRENT_TIMESTAMP(3)`,
        [set.id, set.level, set.order, set.title, set.description, set.active, set.durationMinutes],
      );
    }
    for (const question of seedQuestions) {
      await client.query(
        `INSERT INTO questions
           (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE
           set_id = VALUES(set_id),
           level = VALUES(level),
           section = VALUES(section),
           active = VALUES(active),
           order_no = VALUES(order_no),
           prompt = VALUES(prompt),
           prompt_en = VALUES(prompt_en),
           options = VALUES(options),
           answer_index = VALUES(answer_index),
           explanation = VALUES(explanation),
           audio_text = VALUES(audio_text),
           updated_at = CURRENT_TIMESTAMP(3)`,
        [
          question.id,
          question.setId,
          question.level,
          question.section,
          question.active,
          question.order,
          question.prompt,
          question.promptEn,
          JSON.stringify(question.options),
          question.answer,
          question.explanation,
          question.audioText,
        ],
      );
    }
}

export async function seed() {
  await withTransaction(seedWithClient);
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    await seed();
    console.log("Starter N5 data seeded.");
  } finally {
    await closePool();
  }
}
