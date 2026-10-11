import "dotenv/config";
import {createHash} from "node:crypto";
import {readdir, readFile} from "node:fs/promises";
import {dirname, join} from "node:path";
import {fileURLToPath, pathToFileURL} from "node:url";
import {closePool, getPool} from "./db.js";

const currentDirectory = dirname(fileURLToPath(import.meta.url));

export async function migrate() {
  const client = await getPool().getConnection();
  const lockName = "jlptquiz_mysql_migrations";
  try {
    const [lockRows] = await client.execute("SELECT GET_LOCK(?, 30) AS acquired", [lockName]);
    if (lockRows[0]?.acquired !== 1) throw new Error("Could not acquire the MySQL migration lock.");
    await client.query(`CREATE TABLE IF NOT EXISTS schema_migrations (
      name VARCHAR(255) PRIMARY KEY,
      checksum CHAR(64) NOT NULL,
      applied_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci`);
    const directory = join(currentDirectory, "migrations");
    const files = (await readdir(directory)).filter((file) => file.endsWith(".sql")).sort();
    for (const name of files) {
      const sql = await readFile(join(directory, name), "utf8");
      const checksum = createHash("sha256").update(sql).digest("hex");
      const [existing] = await client.execute("SELECT checksum FROM schema_migrations WHERE name = ?", [name]);
      if (existing.length) {
        if (existing[0].checksum !== checksum) throw new Error(`Migration ${name} changed after it was applied.`);
        continue;
      }
      await client.query(sql);
      await client.execute("INSERT INTO schema_migrations (name, checksum) VALUES (?, ?)", [name, checksum]);
    }
  } finally {
    await client.execute("SELECT RELEASE_LOCK(?)", [lockName]).catch(() => {});
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
