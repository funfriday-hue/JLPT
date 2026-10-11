import "dotenv/config";
import {pathToFileURL} from "node:url";
import {seedQuestions, seedSets} from "./data.js";
import {closePool, withTransaction} from "./db.js";

export async function seedWithClient(client) {
    for (const set of seedSets) {
      await client.query(
        `INSERT INTO exam_sets (id, level, order_no, title, description, active, duration_minutes)
         VALUES ($1, $2, $3, $4, $5, $6, $7)
         ON CONFLICT (id) DO UPDATE SET
           level = EXCLUDED.level,
           order_no = EXCLUDED.order_no,
           title = EXCLUDED.title,
           description = EXCLUDED.description,
           active = EXCLUDED.active,
           duration_minutes = EXCLUDED.duration_minutes,
           updated_at = NOW()`,
        [set.id, set.level, set.order, set.title, set.description, set.active, set.durationMinutes],
      );
    }
    for (const question of seedQuestions) {
      await client.query(
        `INSERT INTO questions
           (id, set_id, level, section, active, order_no, prompt, prompt_en, options, answer_index, explanation, audio_text)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9::jsonb, $10, $11, $12)
         ON CONFLICT (id) DO UPDATE SET
           set_id = EXCLUDED.set_id,
           level = EXCLUDED.level,
           section = EXCLUDED.section,
           active = EXCLUDED.active,
           order_no = EXCLUDED.order_no,
           prompt = EXCLUDED.prompt,
           prompt_en = EXCLUDED.prompt_en,
           options = EXCLUDED.options,
           answer_index = EXCLUDED.answer_index,
           explanation = EXCLUDED.explanation,
           audio_text = EXCLUDED.audio_text,
           updated_at = NOW()`,
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
