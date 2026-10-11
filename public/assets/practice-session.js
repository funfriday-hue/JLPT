import "./common.js";
import {api} from "./api.js";
import {requireUser} from "./firebase.js";
import {escapeHtml, sectionLabel, toast} from "./common.js";

const params = new URLSearchParams(window.location.search);
const section = ["vocabulary", "grammar-reading", "listening", "random"].includes(params.get("section")) ? params.get("section") : "random";
const panel = document.querySelector("#practice-panel");
let question = null;
let answered = false;

async function loadQuestion() {
  answered = false;
  panel.innerHTML = '<div class="loading-card">Loading a random N5 question…</div>';
  try {
    const payload = await api.practiceQuestion(section, question?.id || "");
    question = payload.question;
    render();
  } catch (error) {
    panel.innerHTML = `<div class="status error">${escapeHtml(error.message)}</div>`;
  }
}

function render() {
  const listening = question.section === "listening";
  panel.innerHTML = `
    <div class="question-progress"><span>N5 QUICK PRACTICE</span><span>${escapeHtml(sectionLabel(question.section))}</span></div>
    <h1>${escapeHtml(sectionLabel(section))}</h1>
    <div class="question-meta">Question from an active N5 paper</div>
    ${listening ? '<button class="secondary audio-button" id="play-audio">▶ Play audio</button>' : ""}
    <div class="prompt-pair" id="prompt-pair"><div class="question-copy">${escapeHtml(question.prompt)}</div>
    <div class="translation hidden" id="translation">${escapeHtml(question.promptEn)}</div></div>
    <button class="secondary reveal-button" id="reveal">Reveal in English</button>
    <div class="options" id="options">
      ${question.options.map((option, index) => `<button class="option" data-choice="${index}"><b>${index + 1}.</b> ${escapeHtml(option)}</button>`).join("")}
    </div>
    <div id="feedback"></div>
    <div class="question-footer"><span>Take your time. Practice mode has no timer.</span><button class="primary" id="next">Skip / Next question →</button></div>`;

  document.querySelector("#reveal").addEventListener("click", (event) => {
    const translation = document.querySelector("#translation");
    const hidden = translation.classList.toggle("hidden");
    document.querySelector("#prompt-pair").classList.toggle("revealed", !hidden);
    event.currentTarget.textContent = hidden ? "Reveal in English" : "Hide English";
  });
  document.querySelector("#next").addEventListener("click", loadQuestion);
  document.querySelector("#play-audio")?.addEventListener("click", () => {
    if (!("speechSynthesis" in window)) return toast("Audio playback is not supported in this browser.");
    speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(question.audioText || question.prompt.replace(/（.*?）/g, ""));
    utterance.lang = "ja-JP";
    speechSynthesis.speak(utterance);
  });
  for (const option of document.querySelectorAll("[data-choice]")) {
    option.addEventListener("click", () => submitAnswer(Number(option.dataset.choice)));
  }
}

async function submitAnswer(choice) {
  if (answered) return;
  answered = true;
  for (const option of document.querySelectorAll("[data-choice]")) option.disabled = true;
  try {
    const result = await api.checkPractice(question.id, choice);
    const options = document.querySelectorAll("[data-choice]");
    options[result.correctChoice]?.classList.add("correct");
    if (!result.correct) options[choice]?.classList.add("wrong");
    const feedback = document.querySelector("#feedback");
    feedback.className = `feedback${result.correct ? "" : " wrong"}`;
    feedback.innerHTML = `<strong>${result.correct ? "正解（せいかい）！ Correct." : "もう一度（いちど）。 Not quite."}</strong><br>${escapeHtml(result.explanation)}`;
  } catch (error) {
    answered = false;
    for (const option of document.querySelectorAll("[data-choice]")) option.disabled = false;
    toast(error.message);
  }
}

if (await requireUser()) loadQuestion();
