import {auth, authReady} from "./firebase.js";

async function request(path, options = {}, authenticated = true) {
  const headers = new Headers(options.headers || {});
  headers.set("Accept", "application/json");
  if (options.body) headers.set("Content-Type", "application/json");
  if (authenticated) {
    const user = auth.currentUser || await authReady;
    if (!user) throw new Error("Sign in with Google to continue.");
    headers.set("Authorization", `Bearer ${await user.getIdToken()}`);
  }
  const response = await fetch(`/api${path}`, {...options, headers});
  const payload = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(payload.error || "Something went wrong. Please try again.");
  return payload;
}

export const api = {
  sets: () => request("/sets", {}, false),
  scores: () => request("/scores"),
  practiceQuestion: (section, exclude = "") => request(`/practice/random?section=${encodeURIComponent(section)}&exclude=${encodeURIComponent(exclude)}`),
  checkPractice: (questionId, choice) => request("/practice/check", {method: "POST", body: JSON.stringify({questionId, choice})}),
  test: (setId, section) => request(`/tests/${encodeURIComponent(setId)}/start`, {method: "POST", body: JSON.stringify({section})}),
  submitTest: (attemptId, answers) => request(`/tests/attempts/${encodeURIComponent(attemptId)}/submit`, {method: "POST", body: JSON.stringify({answers})}),
};
