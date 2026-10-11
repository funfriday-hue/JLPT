import "dotenv/config";
import mysql from "mysql2/promise";

let pool;

function connectionOptions() {
  if (!process.env.DATABASE_URL) {
    throw new Error("DATABASE_URL is required. Use a mysql:// connection URL.");
  }
  const url = new URL(process.env.DATABASE_URL);
  if (url.protocol !== "mysql:") {
    throw new Error("DATABASE_URL must start with mysql://.");
  }
  return {
    host: url.hostname,
    port: Number(url.port || 3306),
    user: decodeURIComponent(url.username),
    password: decodeURIComponent(url.password),
    database: decodeURIComponent(url.pathname.replace(/^\//, "")),
    waitForConnections: true,
    connectionLimit: Number(process.env.DATABASE_POOL_SIZE || 10),
    queueLimit: 0,
    charset: "utf8mb4",
    timezone: "Z",
    decimalNumbers: true,
    multipleStatements: true,
    ssl: process.env.DATABASE_SSL === "true" ? {rejectUnauthorized: false} : undefined,
  };
}

function normalizedExecutor(executor) {
  return {
    async query(text, values = []) {
      const [result] = await executor.execute(text, values);
      return {
        rows: Array.isArray(result) ? result : [],
        rowCount: Array.isArray(result) ? result.length : result.affectedRows,
        insertId: Array.isArray(result) ? undefined : result.insertId,
      };
    },
  };
}

export function getPool() {
  if (!pool) {
    pool = mysql.createPool(connectionOptions());
  }
  return pool;
}

export function query(text, values = []) {
  return normalizedExecutor(getPool()).query(text, values);
}

export async function withTransaction(callback) {
  const connection = await getPool().getConnection();
  try {
    await connection.beginTransaction();
    const result = await callback(normalizedExecutor(connection));
    await connection.commit();
    return result;
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

export async function closePool() {
  if (pool) {
    await pool.end();
    pool = undefined;
  }
}
