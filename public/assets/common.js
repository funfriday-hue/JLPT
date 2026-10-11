import {observeAuth} from "./firebase.js";

const loginLinks = document.querySelectorAll('[data-login-link]');
observeAuth((user) => {
  for (const link of loginLinks) {
    link.title = user ? `Signed in as ${user.email || user.displayName || "learner"}` : "Sign in with Google";
    link.dataset.signedIn = user ? "true" : "false";
  }
});

export function toast(message) {
  document.querySelector(".toast")?.remove();
  const element = document.createElement("div");
  element.className = "toast";
  element.setAttribute("role", "status");
  element.textContent = message;
  document.body.append(element);
  window.setTimeout(() => element.remove(), 2600);
}

export function escapeHtml(value) {
  return String(value).replace(/[&<>'"]/g, (character) => ({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    "'": "&#39;",
    '"': "&quot;",
  })[character]);
}

export function sectionLabel(section) {
  return {
    vocabulary: "Vocabulary · 語彙（ごい）",
    "grammar-reading": "Grammar & Reading · 文法（ぶんぽう）・読解（どっかい）",
    listening: "Listening · 聴解（ちょうかい）",
    random: "Random mix · おまかせ",
    all: "Full paper · 全科目（ぜんかもく）",
  }[section] || section;
}
