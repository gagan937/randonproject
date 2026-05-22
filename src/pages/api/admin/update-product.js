import { getSession } from "next-auth/client";
import { getPool, isAdminEmail } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    if (req.method !== "POST") return res.status(400).json({ message: "Bad Request" });
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    const { _id, title, category, description, image } = req.body;
    const price = parseInt(req.body.price, 10) || 0;
    await getPool().query(
      "UPDATE products SET title=?, price=?, description=?, category=?, image=? WHERE id=?",
      [String(title).trim(), price, String(description).trim(), String(category).trim(), String(image).trim(), _id]
    );
    return res.status(200).json({ message: "Product updated successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
