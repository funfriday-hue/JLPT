import {initializeApp} from "https://www.gstatic.com/firebasejs/11.10.0/firebase-app.js";
import {
  GoogleAuthProvider,
  getAuth,
  getRedirectResult,
  onAuthStateChanged,
  signInWithPopup,
  signInWithRedirect,
  signOut,
} from "https://www.gstatic.com/firebasejs/11.10.0/firebase-auth.js";

const config = {
  projectId: "japanesenx-aman",
  appId: "1:4449369028:web:61cb2e46cc2259bacbc291",
  storageBucket: "japanesenx-aman.firebasestorage.app",
  apiKey: "AIzaSyBe3xh3W6iFMU-l4e53ScZeJyX7NjPXuI0",
  authDomain: "japanesenx-aman.firebaseapp.com",
  messagingSenderId: "4449369028",
  measurementId: "G-8JHKXWL5QY",
};

const firebaseApp = initializeApp(config);
export const auth = getAuth(firebaseApp);
const provider = new GoogleAuthProvider();
provider.setCustomParameters({prompt: "select_account"});

export const authReady = new Promise((resolve) => {
  const unsubscribe = onAuthStateChanged(auth, (user) => {
    unsubscribe();
    resolve(user);
  });
});

export async function continueWithGoogle() {
  try {
    return await signInWithPopup(auth, provider);
  } catch (error) {
    if (["auth/popup-blocked", "auth/cancelled-popup-request", "auth/operation-not-supported-in-this-environment"].includes(error.code)) {
      await signInWithRedirect(auth, provider);
      return null;
    }
    throw error;
  }
}

export async function finishGoogleRedirect() {
  return getRedirectResult(auth);
}

export async function logOut() {
  await signOut(auth);
}

export async function requireUser(returnTo = window.location.pathname + window.location.search) {
  const user = await authReady;
  if (user) return user;
  const safeReturn = returnTo.startsWith("/") && !returnTo.startsWith("//") ? returnTo : "/";
  window.location.replace(`/login?returnTo=${encodeURIComponent(safeReturn)}`);
  return null;
}

export function observeAuth(callback) {
  return onAuthStateChanged(auth, callback);
}
