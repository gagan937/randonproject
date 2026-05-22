import { categorySelect, getPool } from "../../util/mysql";
import { sampleCategories } from "../../util/sampleData";

export default async function handler(req, res) {
  try {
    const [categories] = await getPool().query(`SELECT ${categorySelect} FROM categories ORDER BY name ASC`);
    return res.status(200).json(categories);
  } catch (err) {
    console.warn("MySQL not available. Returning sample categories.", err.message);
    return res.status(200).json(sampleCategories);
  }
}
