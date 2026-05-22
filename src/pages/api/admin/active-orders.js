import { getSession } from "next-auth/client";
import { getPool, isAdminEmail, mapOrder } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    const [rows] = await getPool().query("SELECT * FROM orders WHERE payment_status='paid' AND status IN ('shipping soon','shipped','out for delivery') ORDER BY created_at DESC");
    return res.status(200).json(rows.map(mapOrder));
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
