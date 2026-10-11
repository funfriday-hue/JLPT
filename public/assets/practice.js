import "./common.js";
import {authReady} from "./firebase.js";

for (const button of document.querySelectorAll("[data-practice-section]")) {
  button.addEventListener("click", async () => {
    const section = button.dataset.practiceSection;
    const user = await authReady;
    const destination = `/practice/session?section=${encodeURIComponent(section)}`;
    window.location.href = user ? destination : `/login?returnTo=${encodeURIComponent(destination)}`;
  });
}
