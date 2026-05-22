import { getPool, productSelect } from "../../../util/mysql";

export default async function handler(req, res) {
  try {
    const [rows] = await getPool().query(`SELECT ${productSelect} FROM products WHERE id = ? LIMIT 1`, [req.query.id]);
    if (!rows.length) return res.status(404).json({ message: "Not Found" });
    return res.status(200).json(rows[0]);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
}
