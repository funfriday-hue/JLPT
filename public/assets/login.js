import "./common.js";
import {authReady, continueWithGoogle, finishGoogleRedirect, logOut, observeAuth} from "./firebase.js";
import {escapeHtml} from "./common.js";

const card = document.querySelector("#login-card");
const params = new URLSearchParams(window.location.search);
const requestedReturn = params.get("returnTo") || "/tests";
const returnTo = requestedReturn.startsWith("/") && !requestedReturn.startsWith("//") ? requestedReturn : "/tests";

function render(user) {
  if (user) {
    card.innerHTML = `<div class="account-card"><img class="avatar" src="${escapeHtml(user.photoURL || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'/%3E")}" alt=""><div><strong>${escapeHtml(user.displayName || "JLPT Quiz learner")}</strong><span>${escapeHtml(user.email || "Signed in with Google")}</span></div></div><div class="actions"><a class="primary" href="${escapeHtml(returnTo)}">Continue learning →</a><button class="secondary" id="sign-out">Sign out</button></div>`;
    document.querySelector("#sign-out").addEventListener("click", async () => {
      await logOut();
    });
    return;
  }
  card.innerHTML = `<h2>Continue with Google</h2><p>One secure sign-in unlocks practice, mock tests, and saved personal-best scores. JLPT Quiz does not use password accounts.</p><button class="google-button" id="google-login"><svg class="google-logo" viewBox="0 0 24 24" aria-hidden="true"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.07 5.07 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.27-4.74 3.27-8.1z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.29-2.65l-3.57-2.77c-.98.66-2.24 1.06-3.72 1.06-2.87 0-5.3-1.94-6.17-4.54H2.14v2.84A11 11 0 0 0 12 23z"/><path fill="#FBBC05" d="M5.83 14.1A6.6 6.6 0 0 1 5.48 12c0-.73.13-1.43.35-2.1V7.06H2.14A11 11 0 0 0 1 12c0 1.77.42 3.44 1.14 4.94l3.69-2.84z"/><path fill="#EA4335" d="M12 5.36c1.62 0 3.06.56 4.2 1.64l3.15-3.15A10.6 10.6 0 0 0 12 1 11 11 0 0 0 2.14 7.06L5.83 9.9C6.7 7.3 9.13 5.36 12 5.36z"/></svg>Continue with Google</button><p class="status hidden" id="login-status" role="status"></p>`;
  document.querySelector("#google-login").addEventListener("click", async (event) => {
    const button = event.currentTarget;
    const status = document.querySelector("#login-status");
    button.disabled = true;
    button.textContent = "Opening Google…";
    try {
      const result = await continueWithGoogle();
      if (result) window.location.replace(returnTo);
    } catch (error) {
      status.className = "status error";
      status.textContent = error.message;
      button.disabled = false;
      button.textContent = "Continue with Google";
    }
  });
}

await finishGoogleRedirect().catch(() => null);
render(await authReady);
observeAuth(render);
