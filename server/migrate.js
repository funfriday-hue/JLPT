import "dotenv/config";
import {createHash} from "node:crypto";
import {readdir, readFile} from "node:fs/promises";
import {dirname, join} from "node:path";
import {fileURLToPath, pathToFileURL} from "node:url";
import {closePool, getPool} from "./db.js";

const currentDirectory = dirname(fileURLToPath(import.meta.url));

export async function migrate() {
  const client = await getPool().connect();
  try {
    await client.query("SELECT pg_advisory_lock(hashtext('jlptquiz_sql_migrations'))");
    await client.query(`CREATE TABLE IF NOT EXISTS schema_migrations (
      name TEXT PRIMARY KEY,
      checksum TEXT NOT NULL,
      applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    )`);
    const directory = join(currentDirectory, "migrations");
    const files = (await readdir(directory)).filter((file) => file.endsWith(".sql")).sort();
    for (const name of files) {
      const sql = await readFile(join(directory, name), "utf8");
      const checksum = createHash("sha256").update(sql).digest("hex");
      const existing = await client.query("SELECT checksum FROM schema_migrations WHERE name = $1", [name]);
      if (existing.rowCount) {
        if (existing.rows[0].checksum !== checksum) throw new Error(`Migration ${name} changed after it was applied.`);
        continue;
      }
      await client.query("BEGIN");
      try {
        await client.query(sql);
        await client.query("INSERT INTO schema_migrations (name, checksum) VALUES ($1, $2)", [name, checksum]);
        await client.query("COMMIT");
      } catch (error) {
        await client.query("ROLLBACK");
        throw error;
      }
    }
  } finally {
    await client.query("SELECT pg_advisory_unlock(hashtext('jlptquiz_sql_migrations'))").catch(() => {});
    client.release();
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    await migrate();
    console.log("Database migrations are up to date.");
  } finally {
    await closePool();
  }
}
