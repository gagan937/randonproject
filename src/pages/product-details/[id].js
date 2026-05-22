import Head from "next/head";
import ProductDetails from "../../components/Product/ProductDetails";
import { getPool, productSelect } from "../../util/mysql";
import { findSampleProductById, sampleProducts } from "../../util/sampleData";

function productDetails({ product }) {
  return <>{product?.title && <Head><title>Radon | {product.title}</title></Head>}<ProductDetails _id={product?._id} title={product?.title} price={product?.price} description={product?.description} category={product?.category} image={product?.image} /></>;
}
export default productDetails;

export const getStaticPaths = async () => {
  try {
    const [products] = await getPool().query("SELECT id AS _id FROM products");
    return { paths: products.map((p) => ({ params: { id: String(p._id) } })), fallback: true };
  } catch { return { paths: sampleProducts.map((p) => ({ params: { id: String(p._id) } })), fallback: true }; }
};

export const getStaticProps = async (context) => {
  let product;
  try {
    const [rows] = await getPool().query(`SELECT ${productSelect} FROM products WHERE id=? LIMIT 1`, [context.params.id]);
    product = rows[0];
  } catch { product = findSampleProductById(context.params.id); }
  if (!product) return { notFound: true };
  return { props: { product }, revalidate: 1 };
};
