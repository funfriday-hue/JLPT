import "dotenv/config";
import {createApp} from "./app.js";
import {closePool} from "./db.js";
import {migrate} from "./migrate.js";
import {seed} from "./seed.js";

const port = Number(process.env.PORT || 3000);

if (process.env.AUTO_MIGRATE !== "false") {
  await migrate();
  await seed();
}

const server = createApp().listen(port, () => {
  console.log(`JLPT Quiz is running on http://localhost:${port}`);
});

async function shutdown(signal) {
  console.log(`${signal} received; shutting down.`);
  server.close(async () => {
    await closePool();
    process.exit(0);
  });
  setTimeout(() => process.exit(1), 10_000).unref();
}

process.on("SIGTERM", () => shutdown("SIGTERM"));
process.on("SIGINT", () => shutdown("SIGINT"));
