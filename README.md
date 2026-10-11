# JLPT Quiz

[jlptquiz.in](https://jlptquiz.in) is a conventional Node.js and PostgreSQL web application for JLPT practice and timed mock tests. N5 is the first available level.

## Stack

- Static multi-page frontend in `public/`
- Express API and web server in `server/`
- PostgreSQL for test papers, questions, practice completions, test attempts, answers, and best scores
- Firebase Authentication for Google-only login
- Docker Compose for a one-command server deployment

Firebase stays on the no-cost Spark plan because the application no longer uses Firebase Cloud Functions or Firestore.

## Repository layout

```text
public/                    Frontend, SEO pages, and browser JavaScript
server/app.js              Express routes and static page serving
server/auth.js             Firebase ID-token verification
server/migrations/         PostgreSQL schema migrations
server/data.js             Starter N5 sets and questions
server/seed.js             Idempotent starter-data import
Dockerfile                 Production Node container
docker-compose.yml         Node application plus PostgreSQL
.env.example               Required environment variables
firebase.json              Google-only Firebase Auth configuration
```

## SQL data model

- `users`: Firebase Google users
- `exam_sets`: dynamic N5/N4/N3/N2/N1 paper metadata
- `questions`: vocabulary, grammar/reading, and listening questions
- `practice_completions`: every checked practice answer
- `test_attempts`: started and completed mock tests
- `test_attempt_questions`: question snapshot for each attempt
- `test_attempt_answers`: per-question mock-test completion data
- `user_best_scores`: highest score for each user, paper, and section

Answers remain server-side. Mock-test responses never include English translations or answer keys.

## Production deployment with Docker

Requirements: Docker Engine, Docker Compose, HTTPS configured for `jlptquiz.in`, and the existing Firebase project.

1. Clone the repository and enter it.
2. Create the runtime environment file:

   ```bash
   cp .env.example .env
   ```

3. In `.env`, set a long random `POSTGRES_PASSWORD`. `PUBLIC_BASE_URL` defaults to `https://jlptquiz.in`.
4. Provide Firebase Admin credentials using one of these approaches:

   - On Google Cloud, attach a service account and leave `FIREBASE_SERVICE_ACCOUNT_BASE64` empty so Application Default Credentials are used.
   - Elsewhere, base64-encode a Firebase service-account JSON file and place the one-line value in `FIREBASE_SERVICE_ACCOUNT_BASE64`. Never commit the key or `.env` file.

5. Start the database and application:

   ```bash
   docker compose up -d --build
   ```

6. Confirm the API is healthy at `https://jlptquiz.in/api/health`. Canonical URLs, Open Graph URLs, `robots.txt`, and the sitemap use `PUBLIC_BASE_URL` automatically.
7. The checked-in Firebase Authentication configuration authorizes `jlptquiz.in` and `www.jlptquiz.in`. If you use another hostname, add it without `https://` or a port under Authentication → Settings → Authorized domains.
8. Put Nginx, Caddy, Traefik, or your hosting provider’s HTTPS proxy in front of port 3000.

The container automatically applies versioned SQL migrations and idempotently seeds three starter N5 papers at startup. Set `AUTO_MIGRATE=false` if your deployment pipeline runs migrations separately.

## Development without Docker

Start a PostgreSQL database and export a connection URL, then run:

```bash
cp .env.example .env
npm install --prefix server
npm run db:setup --prefix server
npm run dev --prefix server
```

Open `http://localhost:3000`. `localhost` is already configured as an authorized Firebase domain.

For local API/UI verification without opening a Google login popup, set `NODE_ENV=development` and `DEV_AUTH_BYPASS=true`. This bypass is ignored when `NODE_ENV=production`.

## Managing papers and questions

The starter data in `server/data.js` is upserted safely. For ongoing editorial management, insert or update rows in `exam_sets` and `questions`. Deactivating a set or question removes it from new practice and test sessions without deleting historical completion records.

## Useful commands

```bash
npm run lint --prefix server
npm test --prefix server
npm audit --omit=dev --prefix server
npm run db:migrate --prefix server
npm run db:seed --prefix server
```

## Firebase Google login

Google is the only enabled provider. To redeploy the Authentication configuration:

```bash
npx -y firebase-tools@latest deploy --only auth --project japanesenx-aman
```

The Firebase project ID remains `japanesenx-aman` because it is the existing backend identity. Users see the public brand and domain, JLPT Quiz at `jlptquiz.in`.
