import { getSession } from "next-auth/client";
import { getPool, isAdminEmail } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    const session = await getSession({ req });
    if (!session || !(await isAdminEmail(session.user.email))) return res.status(401).json({ message: "Unauthorized" });
    const [users] = await getPool().query("SELECT id AS _id, name, email, image, created_at FROM users ORDER BY id DESC");
    return res.status(200).json(users);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
