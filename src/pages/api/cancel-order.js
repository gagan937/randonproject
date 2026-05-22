import { getSession } from "next-auth/client";
import { getPool, isAdminEmail, mapOrder } from "../../util/mysql";

export default async function handler(req, res) {
  try {
    if (req.method !== "POST") return res.status(400).json({ message: "Bad Request" });
    const session = await getSession({ req });
    if (!session) return res.status(401).json({ message: "Unauthorized" });
    const admin = await isAdminEmail(session.user.email);
    const [rows] = await getPool().query("SELECT * FROM orders WHERE id=? LIMIT 1", [req.body._id]);
    if (!rows.length) return res.status(400).json({ message: "Bad Request" });
    const order = mapOrder(rows[0]);
    if (order.user !== session.user.email && !admin) return res.status(401).json({ message: "Unauthorized" });
    const ordStatus = { status: req.body.status || "cancelled", timestamp: new Date() };
    const orderStatus = { current: ordStatus, info: [...(order.order_status.info || []), ordStatus] };
    await getPool().query("UPDATE orders SET status=?, order_status=? WHERE id=?", [ordStatus.status, JSON.stringify(orderStatus), req.body._id]);
    return res.status(200).json({ message: "Order Cancelled" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
