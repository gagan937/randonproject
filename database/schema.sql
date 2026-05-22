CREATE DATABASE IF NOT EXISTS radon;

USE radon;

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  price INT NOT NULL DEFAULT 0,
  description TEXT,
  category VARCHAR(120),
  image TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user VARCHAR(190) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190),
  email VARCHAR(190) NOT NULL UNIQUE,
  image TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS temp_orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_email VARCHAR(190) NOT NULL,
  items JSON NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_email VARCHAR(190) NOT NULL,
  items JSON NOT NULL,
  stripe_session_id VARCHAR(255),
  payment_status VARCHAR(50) DEFAULT 'paid',
  amount_total INT DEFAULT 0,
  currency VARCHAR(10) DEFAULT 'inr',
  status VARCHAR(80) DEFAULT 'shipping soon',
  order_status JSON,
  customer_details JSON,
  shipping JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO categories (name) VALUES ("electronics");

INSERT IGNORE INTO categories (name) VALUES ("jewelery");

INSERT IGNORE INTO categories (name) VALUES ("men's clothing");

INSERT IGNORE INTO categories (name) VALUES ("women's clothing");

INSERT INTO products (title, price, description, category, image) SELECT "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", 1090, "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", "men's clothing", "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");

INSERT INTO products (title, price, description, category, image) SELECT "Mens Casual Premium Slim Fit T-Shirts ", 225, "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.", "men's clothing", "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Mens Casual Premium Slim Fit T-Shirts ");

INSERT INTO products (title, price, description, category, image) SELECT "Mens Cotton Jacket", 550, "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.", "men's clothing", "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Mens Cotton Jacket");

INSERT INTO products (title, price, description, category, image) SELECT "Mens Casual Slim Fit", 150, "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.", "men's clothing", "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Mens Casual Slim Fit");

INSERT INTO products (title, price, description, category, image) SELECT "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet", 6950, "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.", "jewelery", "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet");

INSERT INTO products (title, price, description, category, image) SELECT "Solid Gold Petite Micropave ", 1685, "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.", "jewelery", "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Solid Gold Petite Micropave ");

INSERT INTO products (title, price, description, category, image) SELECT "White Gold Plated Princess", 990, "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...", "jewelery", "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="White Gold Plated Princess");

INSERT INTO products (title, price, description, category, image) SELECT "Pierced Owl Rose Gold Plated Stainless Steel Double", 1990, "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel", "jewelery", "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Pierced Owl Rose Gold Plated Stainless Steel Double");

INSERT INTO products (title, price, description, category, image) SELECT "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", 640, "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user\u2019s hardware configuration and operating system", "electronics", "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="WD 2TB Elements Portable External Hard Drive - USB 3.0 ");

INSERT INTO products (title, price, description, category, image) SELECT "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s", 1090, "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5\u201d hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)", "electronics", "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s");

INSERT INTO products (title, price, description, category, image) SELECT "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5", 1095, "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.", "electronics", "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5");

INSERT INTO products (title, price, description, category, image) SELECT "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive", 1149, "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty", "electronics", "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive");

INSERT INTO products (title, price, description, category, image) SELECT "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin", 5999, "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz", "electronics", "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin");

INSERT INTO products (title, price, description, category, image) SELECT "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) \u2013 Super Ultrawide Screen QLED ", 9950, "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag", "electronics", "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) \u2013 Super Ultrawide Screen QLED ");

INSERT INTO products (title, price, description, category, image) SELECT "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats", 570, "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates", "women's clothing", "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats");

INSERT INTO products (title, price, description, category, image) SELECT "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket", 630, "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON", "women's clothing", "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket");

INSERT INTO products (title, price, description, category, image) SELECT "Rain Jacket Women Windbreaker Striped Climbing Raincoats", 399, "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.", "women's clothing", "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Rain Jacket Women Windbreaker Striped Climbing Raincoats");

INSERT INTO products (title, price, description, category, image) SELECT "MBJ Women's Solid Short Sleeve Boat Neck V ", 195, "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem", "women's clothing", "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="MBJ Women's Solid Short Sleeve Boat Neck V ");

INSERT INTO products (title, price, description, category, image) SELECT "Opna Women's Short Sleeve Moisture", 365, "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort", "women's clothing", "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="Opna Women's Short Sleeve Moisture");

INSERT INTO products (title, price, description, category, image) SELECT "DANVOUY Womens T Shirt Casual Cotton Short", 220, "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.", "women's clothing", "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg" WHERE NOT EXISTS (SELECT 1 FROM products WHERE title="DANVOUY Womens T Shirt Casual Cotton Short");

-- IMPORTANT: apna Google login email admin banane ke liye niche email change karo

INSERT IGNORE INTO admins (user) VALUES ('your-email@gmail.com');