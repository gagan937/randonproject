import { getSession } from "next-auth/client";
import { getPool, isAdminEmail } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    if (req.method !== "POST") return res.status(400).json({ message: "Bad Request" });
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    const { title, category, description, image } = req.body;
    const price = parseInt(req.body.price, 10) || 0;
    await getPool().query(
      "INSERT INTO products (title, price, description, category, image) VALUES (?, ?, ?, ?, ?)",
      [String(title).trim(), price, String(description).trim(), String(category).trim(), String(image).trim()]
    );
    return res.status(200).json({ message: "Product added successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
