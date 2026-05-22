# Radon fixed run guide

This copy includes fixes for Windows + Node 24 and missing MongoDB env errors.

## Run commands

```powershell
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue
npm install
npm run dev
```

Open: http://localhost:3000

## What was fixed

- Added `.npmrc` with `legacy-peer-deps=true` to avoid the React 16 peer dependency conflict from `react-currency-formatter`.
- Updated npm scripts with `NODE_OPTIONS=--openssl-legacy-provider` for old Next.js 10 / webpack 4 on newer Node versions.
- Added `.env.local` local defaults.
- Changed home/products/categories/product-details to use `products.json` sample data when MongoDB is not available.

## MongoDB note

The main website will now run without MongoDB using `products.json`.
For admin, orders, login, checkout and database features, start MongoDB locally or put your MongoDB Atlas URI in `.env.local`:

```env
MONGODB_URI=mongodb+srv://USERNAME:PASSWORD@cluster0.xxxxx.mongodb.net/radon?retryWrites=true&w=majority
MONGODB_DB=radon
```
