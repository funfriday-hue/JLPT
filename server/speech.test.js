import assert from "node:assert/strict";
import test from "node:test";
import {cleanJapaneseSpeechText, selectJapaneseVoice} from "../public/assets/speech.js";

test("speech text removes displayed furigana and normalizes whitespace", () => {
  assert.equal(
    cleanJapaneseSpeechText("田中（たなか）さんは\n毎朝（まいあさ） 八時（はちじ）に行（い）きます。"),
    "田中さんは 毎朝 八時に行きます。",
  );
});

test("voice selection prefers an enhanced Japanese voice", () => {
  const voices = [
    {lang: "en-US", name: "English Natural"},
    {lang: "ja-JP", name: "Japanese Standard"},
    {lang: "ja-JP", name: "Microsoft Nanami Online (Natural)"},
  ];
  assert.equal(selectJapaneseVoice(voices).name, "Microsoft Nanami Online (Natural)");
});

