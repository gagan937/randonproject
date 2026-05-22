import Banner from "../components/Banner/Banner";
import ProductFeed from "../components/Product/ProductFeed";
import getCategories from "../util/getCategories";
import getProducts from "../util/getProducts";
import { getPool, productSelect, categorySelect } from "../util/mysql";
import { sampleCategories, sampleProducts } from "../util/sampleData";

export default function Home(props) {
  const { products, error } = getProducts(props?.products);
  const { categories, error: err } = getCategories(props?.categories);
  if (err) console.error(err);
  if (error) console.error(error);
  return <><Banner /><ProductFeed products={products || sampleProducts} categories={categories || sampleCategories} /></>;
}

export const getStaticProps = async () => {
  try {
    const [products] = await getPool().query(`SELECT ${productSelect} FROM products ORDER BY id DESC`);
    const [categories] = await getPool().query(`SELECT ${categorySelect} FROM categories ORDER BY name ASC`);
    return { props: { products, categories }, revalidate: 1 };
  } catch (error) {
    console.warn("MySQL not available. Using sample data.", error.message);
    return { props: { products: sampleProducts, categories: sampleCategories }, revalidate: 1 };
  }
};
