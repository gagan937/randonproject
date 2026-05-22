import { getSession } from "next-auth/client";
import { getPool, isAdminEmail, mapOrder } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    const session = await getSession({ req });
    if (!session) return res.status(401).json({ message: "Unauthorized" });
    const admin = await isAdminEmail(session.user.email);
    const sql = admin ? "SELECT * FROM orders WHERE id=? LIMIT 1" : "SELECT * FROM orders WHERE id=? AND user_email=? LIMIT 1";
    const params = admin ? [req.query.id] : [req.query.id, session.user.email];
    const [rows] = await getPool().query(sql, params);
    if (!rows.length) return res.status(404).json({ message: "Not Found" });
    return res.status(200).json(mapOrder(rows[0]));
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
