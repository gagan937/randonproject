import { getSession } from "next-auth/client";
import { getPool, isAdminEmail, mapOrder } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    if (req.method !== "POST") return res.status(400).json({ message: "Bad Request" });
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    const { status, _id } = req.body;
    const [rows] = await getPool().query("SELECT * FROM orders WHERE id=? LIMIT 1", [_id]);
    if (!rows.length) return res.status(400).json({ message: "Bad Request" });
    const order = mapOrder(rows[0]);
    const ordStatus = { status, timestamp: new Date() };
    const orderStatus = { current: ordStatus, info: [...(order.order_status.info || []), ordStatus] };
    await getPool().query("UPDATE orders SET status=?, order_status=? WHERE id=?", [status, JSON.stringify(orderStatus), _id]);
    return res.status(200).json({ message: "Order status updated successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
