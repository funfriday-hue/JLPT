import "dotenv/config";
import {applicationDefault, cert, getApps, initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";
import {query} from "./db.js";

function firebaseCredential() {
  if (process.env.FIREBASE_SERVICE_ACCOUNT_BASE64) {
    const json = Buffer.from(process.env.FIREBASE_SERVICE_ACCOUNT_BASE64, "base64").toString("utf8");
    return cert(JSON.parse(json));
  }
  return applicationDefault();
}

if (!getApps().length) {
  initializeApp({
    credential: firebaseCredential(),
    projectId: process.env.FIREBASE_PROJECT_ID || "japanesenx-aman",
  });
}

async function persistUser(user) {
  await query(
    `INSERT INTO users (firebase_uid, email, display_name, photo_url, last_login_at)
     VALUES ($1, $2, $3, $4, NOW())
     ON CONFLICT (firebase_uid) DO UPDATE SET
       email = EXCLUDED.email,
       display_name = EXCLUDED.display_name,
       photo_url = EXCLUDED.photo_url,
       last_login_at = NOW(),
       updated_at = NOW()`,
    [user.uid, user.email || null, user.name || null, user.picture || null],
  );
}

export async function requireUser(req, res, next) {
  if (process.env.NODE_ENV !== "production" && process.env.DEV_AUTH_BYPASS === "true") {
    req.user = {uid: "local-development-user", email: "developer@localhost", name: "Local developer"};
    try {
      await persistUser(req.user);
      return next();
    } catch (error) {
      return next(error);
    }
  }

  const header = req.get("authorization") || "";
  const match = header.match(/^Bearer (.+)$/i);
  if (!match) return res.status(401).json({error: "Sign in with Google to continue."});

  try {
    req.user = await getAuth().verifyIdToken(match[1]);
    await persistUser(req.user);
    return next();
  } catch (error) {
    if (error.code?.startsWith("auth/")) {
      return res.status(401).json({error: "Your session has expired. Please sign in again."});
    }
    return next(error);
  }
}
