import "./common.js";
import {api} from "./api.js";
import {requireUser} from "./firebase.js";
import {escapeHtml, sectionLabel, toast} from "./common.js";
import {playJapaneseAudio, stopJapaneseAudio} from "./speech.js";

const params = new URLSearchParams(window.location.search);
const setId = params.get("set") || "";
const section = ["all", "vocabulary", "grammar-reading", "listening"].includes(params.get("section")) ? params.get("section") : "all";
const panel = document.querySelector("#test-panel");
const timerElement = document.querySelector("#timer");
const navigatorElement = document.querySelector("#question-navigator");
const navigatorCount = document.querySelector("#navigator-count");
const questionJumpGrid = document.querySelector("#question-jump-grid");
let payload;
let index = 0;
let answers = {};
let timerHandle;
let deadline;
let submitting = false;

function formatTime(seconds) {
  const minutes = Math.floor(seconds / 60);
  const remainder = seconds % 60;
  return `${String(minutes).padStart(2, "0")}:${String(remainder).padStart(2, "0")}`;
}

function tick() {
  const remaining = Math.max(0, Math.ceil((deadline - Date.now()) / 1000));
  timerElement.textContent = formatTime(remaining);
  timerElement.classList.toggle("warning", remaining < 300);
  if (!remaining) submit();
}

function startTimer(minutes) {
  const storageKey = `jlptquiz-deadline:${setId}:${section}`;
  const stored = Number(sessionStorage.getItem(storageKey));
  deadline = stored > Date.now() ? stored : Date.now() + minutes * 60 * 1000;
  sessionStorage.setItem(storageKey, String(deadline));
  tick();
  timerHandle = window.setInterval(tick, 1000);
}

function renderNavigator() {
  if (!payload?.questions.length) return;
  const attempted = payload.questions.reduce((total, question) => total + (answers[question.id] !== undefined ? 1 : 0), 0);
  navigatorCount.textContent = `${attempted} / ${payload.questions.length}`;
  navigatorCount.setAttribute("aria-label", `${attempted} of ${payload.questions.length} questions attempted`);
  questionJumpGrid.innerHTML = payload.questions.map((question, questionIndex) => {
    const isAttempted = answers[question.id] !== undefined;
    const isCurrent = questionIndex === index;
    const status = isAttempted ? "attempted" : "pending";
    return `<button class="question-jump ${status}${isCurrent ? " current" : ""}" type="button" data-question-index="${questionIndex}" aria-label="Question ${questionIndex + 1}, ${status}${isCurrent ? ", current question" : ""}"${isCurrent ? ' aria-current="step"' : ""}>${questionIndex + 1}</button>`;
  }).join("");
  for (const button of questionJumpGrid.querySelectorAll("[data-question-index]")) {
    button.addEventListener("click", () => {
      index = Number(button.dataset.questionIndex);
      renderQuestion();
      window.scrollTo({top: 0, behavior: "smooth"});
    });
  }
}

function renderQuestion() {
  stopJapaneseAudio();
  const question = payload.questions[index];
  panel.innerHTML = `
    <div class="question-progress"><span>N5 MOCK TEST · SET ${payload.test.order}</span><span>Question ${String(index + 1).padStart(2, "0")} / ${String(payload.questions.length).padStart(2, "0")}</span></div>
    <h1>${escapeHtml(sectionLabel(question.section))}</h1>
    <div class="question-meta">Choose the best answer</div>
    ${question.section === "listening" ? '<button class="secondary audio-button" id="play-audio">▶ Play audio</button>' : ""}
    <div class="question-copy">${escapeHtml(question.prompt)}</div>
    <div class="options">
      ${question.options.map((option, choice) => `<button class="option${answers[question.id] === choice ? " selected" : ""}" data-choice="${choice}"><b>${choice + 1}.</b> ${escapeHtml(option)}</button>`).join("")}
    </div>
    <div class="question-footer"><span>Your selected answer is recorded automatically.</span><button class="primary" id="next">${index === payload.questions.length - 1 ? "Submit test →" : "Next question →"}</button></div>`;
  renderNavigator();
  for (const option of document.querySelectorAll("[data-choice]")) {
    option.addEventListener("click", () => {
      answers[question.id] = Number(option.dataset.choice);
      document.querySelectorAll("[data-choice]").forEach((item) => item.classList.toggle("selected", item === option));
      renderNavigator();
    });
  }
  document.querySelector("#next").addEventListener("click", () => {
    if (index === payload.questions.length - 1) submit();
    else { index += 1; renderQuestion(); }
  });
  document.querySelector("#play-audio")?.addEventListener("click", async () => {
    if (!await playJapaneseAudio(question.audioUrl, question.audioText || question.prompt)) {
      toast("Audio playback is not supported in this browser.");
    }
  });
}

async function submit() {
  if (submitting) return;
  submitting = true;
  stopJapaneseAudio();
  window.clearInterval(timerHandle);
  navigatorElement.hidden = true;
  panel.innerHTML = '<div class="loading-card">Scoring your paper…</div>';
  try {
    const response = await api.submitTest(payload.attemptId, answers);
    sessionStorage.removeItem(`jlptquiz-deadline:${setId}:${section}`);
    panel.innerHTML = `<div class="result"><div class="eyebrow" style="justify-content:center">Test complete · お疲（つか）れさま</div><div class="result-score">${response.result.percent}%</div><h1>${response.result.correct} / ${response.result.total} correct</h1><p class="lead" style="margin:14px auto 28px">Your best score for this paper is ${response.best.percent}%.</p><div class="actions" style="justify-content:center"><a class="primary" href="/tests">Back to test papers</a><a class="secondary" href="/tests/session?set=${encodeURIComponent(setId)}&section=${encodeURIComponent(section)}">Try again</a></div></div>`;
  } catch (error) {
    submitting = false;
    navigatorElement.hidden = false;
    panel.innerHTML = `<div class="status error">${escapeHtml(error.message)}</div>`;
  }
}

async function begin() {
  if (!setId) {
    panel.innerHTML = '<div class="status error">Choose a test paper first.</div>';
    return;
  }
  try {
    payload = await api.test(setId, section);
    if (!payload.questions.length) throw new Error("This test has no active questions yet.");
    navigatorElement.hidden = false;
    startTimer(payload.durationMinutes);
    renderQuestion();
  } catch (error) {
    panel.innerHTML = `<div class="status error">${escapeHtml(error.message)}</div>`;
  }
}

window.addEventListener("beforeunload", () => {
  stopJapaneseAudio();
  window.clearInterval(timerHandle);
});
if (await requireUser()) begin();
