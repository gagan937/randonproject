import rawProducts from "../../products.json";

export const sampleProducts = rawProducts.map((product, index) => ({
  _id: product._id || String(index + 1),
  ...product,
}));

export const sampleCategories = Array.from(
  new Set(sampleProducts.map((product) => product.category).filter(Boolean))
).map((name, index) => ({
  _id: String(index + 1),
  name,
}));

export function findSampleProductById(id) {
  return sampleProducts.find((product) => String(product._id) === String(id));
}
