import "dotenv/config";
import pg from "pg";

const {Pool} = pg;
let pool;

export function getPool() {
  if (!pool) {
    if (!process.env.DATABASE_URL && !process.env.PGHOST) {
      throw new Error("DATABASE_URL or PostgreSQL PG* connection variables are required.");
    }
    pool = new Pool({
      ...(process.env.DATABASE_URL ? {connectionString: process.env.DATABASE_URL} : {
        host: process.env.PGHOST,
        port: Number(process.env.PGPORT || 5432),
        database: process.env.PGDATABASE,
        user: process.env.PGUSER,
        password: process.env.PGPASSWORD,
      }),
      max: Number(process.env.DATABASE_POOL_SIZE || 10),
      idleTimeoutMillis: 30_000,
      connectionTimeoutMillis: 10_000,
      ssl: process.env.DATABASE_SSL === "true" ? {rejectUnauthorized: false} : undefined,
    });
    pool.on("error", (error) => console.error("Unexpected PostgreSQL pool error", error));
  }
  return pool;
}

export function query(text, values = []) {
  return getPool().query(text, values);
}

export async function withTransaction(callback) {
  const client = await getPool().connect();
  try {
    await client.query("BEGIN");
    const result = await callback(client);
    await client.query("COMMIT");
    return result;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}

export async function closePool() {
  if (pool) {
    await pool.end();
    pool = undefined;
  }
}
