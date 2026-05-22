import { getPool } from "../../util/mysql";

const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

export default async function handler(req, res) {
  const { items, email } = req.body;
  try {
    const [result] = await getPool().query("INSERT INTO temp_orders (user_email, items) VALUES (?, ?)", [email, JSON.stringify(items || [])]);
    const transformedItems = (items || []).map((item) => ({
      description: item.description,
      quantity: item.qty,
      price_data: { currency: "INR", unit_amount: item.price * 100, product_data: { name: item.title, images: [item.image] } },
    }));
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      shipping_rates: process.env.STRIPE_SHIPPING_RATE ? [process.env.STRIPE_SHIPPING_RATE] : undefined,
      shipping_address_collection: { allowed_countries: ["GB", "US", "CA", "IN"] },
      line_items: transformedItems,
      mode: "payment",
      success_url: `${process.env.HOST}/success`,
      cancel_url: `${process.env.HOST}/cart`,
      metadata: { id: String(result.insertId) },
    });
    return res.status(200).json({ id: session.id });
  } catch (err) {
    console.error(err);
    return res.status(400).json({ message: "Bad Request" });
  }
}
