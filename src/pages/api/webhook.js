import { buffer } from "micro";
import { getPool } from "../../util/mysql";

const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const endpointSecret = process.env.STRIPE_SIGNING_SECRET;

const fulfillOrder = async (session) => {
  const tempId = Number(session.metadata.id);
  const [rows] = await getPool().query("SELECT * FROM temp_orders WHERE id=? LIMIT 1", [tempId]);
  if (!rows.length) throw new Error("Temp order not found");
  const ordStatus = { status: "shipping soon", timestamp: new Date() };
  const orderStatus = { current: ordStatus, info: [ordStatus] };
  await getPool().query(
    "INSERT INTO orders (user_email, items, stripe_session_id, payment_status, amount_total, currency, status, order_status, customer_details, shipping) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    [rows[0].user_email, rows[0].items, session.id, session.payment_status || "paid", session.amount_total || 0, session.currency || "inr", "shipping soon", JSON.stringify(orderStatus), JSON.stringify(session.customer_details || {}), JSON.stringify(session.shipping || {})]
  );
};

export default async function handler(req, res) {
  if (req.method !== "POST") return res.status(405).end();
  const requestBuffer = await buffer(req);
  const payload = requestBuffer.toString();
  const sig = req.headers["stripe-signature"];
  let event;
  try { event = stripe.webhooks.constructEvent(payload, sig, endpointSecret); }
  catch (err) { return res.status(400).json({ message: err.message }); }
  if (event.type === "checkout.session.completed") await fulfillOrder(event.data.object);
  return res.status(200).json({ message: "success" });
}

export const config = { api: { bodyParser: false, externalResolver: true } };
