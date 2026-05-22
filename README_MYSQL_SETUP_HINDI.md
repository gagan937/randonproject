# Radon MySQL Version - Run Guide

Is version me MongoDB remove karke MySQL use kiya gaya hai. Backend Next.js API routes me Node.js par chal raha hai.

## 1) MySQL database import karo

MySQL Workbench / phpMyAdmin / terminal me `database/schema.sql` import karo.

Terminal example:

```powershell
mysql -u root -p < database/schema.sql
```

## 2) .env.local update karo

`.env.local` me apna MySQL password aur Google/Stripe keys bharna:

```env
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your_mysql_password
MYSQL_DATABASE=radon
```

Admin panel ke liye `database/schema.sql` ke end me ye line apne Gmail se change karo:

```sql
INSERT IGNORE INTO admins (user) VALUES ('your-email@gmail.com');
```

## 3) Install aur run

```powershell
npm install --legacy-peer-deps
npm run dev
```

Open:

```text
http://localhost:3000
```

## Notes

- MongoDB dependency remove kar di gayi hai.
- MySQL dependency `mysql2` add ki gayi hai.
- Products, categories, users, admins, orders tables added.
- Agar Node 24 use kar rahe ho to scripts me OpenSSL legacy flag already added hai.
