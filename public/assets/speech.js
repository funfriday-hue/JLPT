const preferredJapaneseVoicePattern = /natural|enhanced|premium|google.*(?:日本語|japanese)|kyoko|otoya|nanami|keita|haruka|sayaka/i;
let activeAudio = null;

export function cleanJapaneseSpeechText(value) {
  return String(value || "")
    .replace(/（[^）]*）/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

export function selectJapaneseVoice(voices) {
  return [...voices]
    .filter((voice) => String(voice.lang || "").toLowerCase().startsWith("ja"))
    .sort((left, right) => {
      const score = (voice) =>
        (String(voice.lang).toLowerCase() === "ja-jp" ? 100 : 0) +
        (preferredJapaneseVoicePattern.test(voice.name) ? 20 : 0);
      return score(right) - score(left);
    })[0] || null;
}

export function speakJapanese(value) {
  const synth = globalThis.speechSynthesis;
  const Utterance = globalThis.SpeechSynthesisUtterance;
  const text = cleanJapaneseSpeechText(value);
  if (!synth || !Utterance || !text) return null;

  synth.cancel();
  const utterance = new Utterance(text);
  const voice = selectJapaneseVoice(synth.getVoices());
  if (voice) utterance.voice = voice;
  utterance.lang = "ja-JP";
  utterance.rate = 0.95;
  utterance.pitch = 1;
  utterance.volume = 1;
  synth.speak(utterance);
  return utterance;
}

export function stopJapaneseAudio() {
  if (activeAudio) {
    activeAudio.pause();
    activeAudio.currentTime = 0;
    activeAudio = null;
  }
  globalThis.speechSynthesis?.cancel();
}

export async function playJapaneseAudio(audioUrl, fallbackText) {
  stopJapaneseAudio();

  if (audioUrl && globalThis.Audio) {
    const audio = new globalThis.Audio(audioUrl);
    activeAudio = audio;
    audio.addEventListener("ended", () => {
      if (activeAudio === audio) activeAudio = null;
    }, {once: true});
    try {
      await audio.play();
      return audio;
    } catch {
      if (activeAudio === audio) activeAudio = null;
    }
  }

  return speakJapanese(fallbackText);
}

// Asking for voices early gives browsers time to populate their asynchronous
// voice list before the learner presses Play for the first time.
if (globalThis.speechSynthesis) {
  globalThis.speechSynthesis.getVoices();
}
