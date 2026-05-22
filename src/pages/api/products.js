import { getPool, productSelect } from "../../util/mysql";
import { sampleProducts } from "../../util/sampleData";

export default async function handler(req, res) {
  try {
    const [products] = await getPool().query(`SELECT ${productSelect} FROM products ORDER BY id DESC`);
    return res.status(200).json(products);
  } catch (err) {
    console.warn("MySQL not available. Returning sample products.", err.message);
    return res.status(200).json(sampleProducts);
  }
}
