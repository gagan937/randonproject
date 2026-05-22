import mysql from "mysql2/promise";

let pool;

export function getPool() {
  if (!pool) {
    pool = mysql.createPool({
      host: process.env.MYSQL_HOST || "127.0.0.1",
      port: Number(process.env.MYSQL_PORT || 3306),
      user: process.env.MYSQL_USER || "root",
      password: process.env.MYSQL_PASSWORD || "",
      database: process.env.MYSQL_DATABASE || "radon",
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
    });
  }
  return pool;
}

const parseJSON = (value, fallback) => {
  if (value == null) return fallback;
  if (typeof value !== "string") return value;
  try { return JSON.parse(value); } catch { return fallback; }
};

export const productSelect = "id AS _id, title, price, description, category, image";
export const categorySelect = "id AS _id, name";

export function mapOrder(row) {
  if (!row) return null;
  return {
    _id: String(row._id || row.id),
    user: row.user_email,
    items: parseJSON(row.items, []),
    order_status: parseJSON(row.order_status, { current: { status: row.status || "shipping soon", timestamp: row.created_at }, info: [] }),
    payment_status: row.payment_status,
    amount_total: row.amount_total,
    currency: row.currency,
    customer_details: parseJSON(row.customer_details, {}),
    shipping: parseJSON(row.shipping, {}),
    timestamp: row.created_at,
    id: row.stripe_session_id || String(row.id),
  };
}

export async function isAdminEmail(email) {
  if (!email) return false;
  const [rows] = await getPool().query("SELECT id FROM admins WHERE user = ? LIMIT 1", [email]);
  return rows.length > 0;
}
