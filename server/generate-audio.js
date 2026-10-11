import "dotenv/config";
import textToSpeech from "@google-cloud/text-to-speech";
import {access, mkdir, rename, unlink, writeFile} from "node:fs/promises";
import {constants} from "node:fs";
import {dirname, join, resolve} from "node:path";
import {fileURLToPath} from "node:url";
import {cleanJapaneseSpeechText} from "../public/assets/speech.js";
import {closePool, query} from "./db.js";

const currentDirectory = dirname(fileURLToPath(import.meta.url));
const outputDirectory = resolve(
  process.env.CHIRP_AUDIO_DIRECTORY || join(currentDirectory, "../public/audio/questions"),
);
const voiceName = process.env.CHIRP_VOICE || "ja-JP-Chirp3-HD-Aoede";
const speakingRate = Number(process.env.CHIRP_SPEAKING_RATE || 0.95);
const force = process.env.CHIRP_FORCE === "true";

if (!Number.isFinite(speakingRate) || speakingRate < 0.25 || speakingRate > 2) {
  throw new Error("CHIRP_SPEAKING_RATE must be between 0.25 and 2.0.");
}

function audioFileName(questionId) {
  if (!/^[a-zA-Z0-9_-]+$/.test(questionId)) {
    throw new Error(`Question id cannot be used as an audio filename: ${questionId}`);
  }
  return `${questionId}.mp3`;
}

async function fileExists(path) {
  try {
    await access(path, constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

async function synthesizeWithRetry(client, request, attempts = 3) {
  let lastError;
  for (let attempt = 1; attempt <= attempts; attempt += 1) {
    try {
      return await client.synthesizeSpeech(request);
    } catch (error) {
      lastError = error;
      if (attempt < attempts) {
        await new Promise((resolveDelay) => setTimeout(resolveDelay, attempt * 1000));
      }
    }
  }
  throw lastError;
}

const client = new textToSpeech.TextToSpeechClient();

try {
  await mkdir(outputDirectory, {recursive: true});
  const result = await query(
    `SELECT id, audio_text
     FROM questions
     WHERE active = TRUE AND section = 'listening' AND audio_text IS NOT NULL
     ORDER BY set_id, order_no`,
  );

  if (!result.rowCount) throw new Error("No active listening questions were found.");

  let generated = 0;
  let skipped = 0;
  let characters = 0;

  for (const [index, question] of result.rows.entries()) {
    const outputPath = join(outputDirectory, audioFileName(question.id));
    if (!force && await fileExists(outputPath)) {
      skipped += 1;
      console.log(`[${index + 1}/${result.rowCount}] Skipped existing ${question.id}`);
      continue;
    }

    const text = cleanJapaneseSpeechText(question.audio_text);
    if (!text) throw new Error(`Listening question ${question.id} has no speakable text.`);

    console.log(`[${index + 1}/${result.rowCount}] Generating ${question.id}`);
    const [response] = await synthesizeWithRetry(client, {
      input: {text},
      voice: {languageCode: "ja-JP", name: voiceName},
      audioConfig: {audioEncoding: "MP3", speakingRate},
    });
    if (!response.audioContent?.length) {
      throw new Error(`Chirp returned no audio for ${question.id}.`);
    }

    const temporaryPath = `${outputPath}.tmp`;
    await writeFile(temporaryPath, response.audioContent, {encoding: "binary", mode: 0o644});
    try {
      await rename(temporaryPath, outputPath);
    } catch (error) {
      await unlink(temporaryPath).catch(() => {});
      throw error;
    }
    generated += 1;
    characters += [...text].length;
  }

  console.log(`Finished: ${generated} generated, ${skipped} skipped, ${characters} billed characters.`);
  console.log(`Voice: ${voiceName}; files: ${outputDirectory}`);
} finally {
  await client.close();
  await closePool();
}
