import "./common.js";
import {api} from "./api.js";
import {authReady} from "./firebase.js";
import {escapeHtml, sectionLabel} from "./common.js";

const grid = document.querySelector("#test-grid");
let sets = [];

function scoreFor(scores, setId, section) {
  const score = scores.find((item) => item.setId === setId && item.section === section);
  return score ? `${score.correct} / ${score.total}` : "—";
}

async function renderSets() {
  try {
    const [setsPayload, user] = await Promise.all([api.sets(), authReady]);
    sets = setsPayload.sets;
    const scores = user ? (await api.scores()).scores : [];
    grid.innerHTML = sets.map((set) => `
      <article class="test-card">
        <div class="test-top"><div><span class="setno">SET ${String(set.order).padStart(2, "0")}</span><h3>${escapeHtml(set.title)}</h3></div><span class="pill">${set.durationMinutes} min</span></div>
        <div class="score-row"><span>Vocabulary · 語彙（ごい）</span><b>${scoreFor(scores, set.id, "vocabulary")}</b></div>
        <div class="score-row"><span>Grammar & Reading</span><b>${scoreFor(scores, set.id, "grammar-reading")}</b></div>
        <div class="score-row"><span>Listening · 聴解（ちょうかい）</span><b>${scoreFor(scores, set.id, "listening")}</b></div>
        <div class="score-row"><span>Full paper best</span><b>${scoreFor(scores, set.id, "all")}</b></div>
        <button class="details-btn" data-open-set="${escapeHtml(set.id)}">View paper →</button>
      </article>`).join("");
    for (const button of document.querySelectorAll("[data-open-set]")) {
      button.addEventListener("click", () => openSet(button.dataset.openSet));
    }
  } catch (error) {
    grid.innerHTML = `<div class="status error">${escapeHtml(error.message)}</div>`;
  }
}

async function start(setId, section) {
  const user = await authReady;
  const destination = `/tests/session?set=${encodeURIComponent(setId)}&section=${encodeURIComponent(section)}`;
  window.location.href = user ? destination : `/login?returnTo=${encodeURIComponent(destination)}`;
}

function openSet(setId) {
  const set = sets.find((item) => item.id === setId);
  if (!set) return;
  const wrap = document.createElement("div");
  wrap.className = "modal-wrap";
  wrap.innerHTML = `<div class="modal" role="dialog" aria-modal="true" aria-labelledby="paper-title">
    <div class="modal-head"><div><div class="eyebrow">Set ${String(set.order).padStart(2, "0")}</div><h2 id="paper-title">${escapeHtml(set.title)}</h2></div><button class="close" aria-label="Close">×</button></div>
    <p>Choose one section, or sit the complete 90-minute paper. Sign in with Google to begin; your best score is saved automatically.</p>
    <div class="modal-options">
      ${["vocabulary", "grammar-reading", "listening"].map((section) => `<button class="modal-option" data-section="${section}"><b>${sectionLabel(section)}</b><br><small>${set.counts?.[section] || 0} questions · ${{vocabulary: 20, "grammar-reading": 40, listening: 30}[section]} minutes</small></button>`).join("")}
    </div>
    <button class="primary" style="width:100%" data-section="all">Start full 90-minute test →</button>
  </div>`;
  document.body.append(wrap);
  wrap.addEventListener("click", (event) => {
    if (event.target === wrap || event.target.closest(".close")) wrap.remove();
    const sectionButton = event.target.closest("[data-section]");
    if (sectionButton) start(setId, sectionButton.dataset.section);
  });
}

renderSets();
