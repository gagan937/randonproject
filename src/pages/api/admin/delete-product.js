import { getSession } from "next-auth/client";
import { getPool, isAdminEmail } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    if (req.method !== "POST") return res.status(400).json({ message: "Bad Request" });
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    await getPool().query("DELETE FROM products WHERE id = ?", [req.body._id]);
    return res.status(200).json({ message: "Product deleted successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
