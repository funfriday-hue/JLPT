import {observeAuth} from "./firebase.js";

const japaneseRunPattern = /[\u3000-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff01-\uff65]+/gu;
const typographyExclusions = "script, style, textarea, option, .jp-text";

function styleJapaneseTextNode(node) {
  const parent = node.parentElement;
  if (!parent || parent.closest(typographyExclusions) || !japaneseRunPattern.test(node.data)) return;
  japaneseRunPattern.lastIndex = 0;
  const fragment = document.createDocumentFragment();
  let cursor = 0;
  for (const match of node.data.matchAll(japaneseRunPattern)) {
    if (match.index > cursor) fragment.append(node.data.slice(cursor, match.index));
    const japanese = document.createElement("span");
    japanese.className = "jp-text";
    japanese.lang = "ja";
    japanese.textContent = match[0];
    fragment.append(japanese);
    cursor = match.index + match[0].length;
  }
  if (cursor < node.data.length) fragment.append(node.data.slice(cursor));
  node.replaceWith(fragment);
}

export function applyJapaneseTypography(root = document.body) {
  if (!root) return;
  if (root.nodeType === Node.TEXT_NODE) {
    styleJapaneseTextNode(root);
    return;
  }
  if (root.nodeType !== Node.ELEMENT_NODE || root.matches(typographyExclusions)) return;
  const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
  const nodes = [];
  while (walker.nextNode()) nodes.push(walker.currentNode);
  nodes.forEach(styleJapaneseTextNode);
}

applyJapaneseTypography();
new MutationObserver((records) => {
  for (const record of records) {
    for (const node of record.addedNodes) applyJapaneseTypography(node);
  }
}).observe(document.body, {childList: true, subtree: true});

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
