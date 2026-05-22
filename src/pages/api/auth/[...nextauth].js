import NextAuth from "next-auth";
import Providers from "next-auth/providers";
import { getPool, isAdminEmail } from "../../../util/mysql";

export default NextAuth({
  providers: [
    Providers.Google({
      clientId: process.env.GOOGLE_ID,
      clientSecret: process.env.GOOGLE_SECRET,
    }),
  ],
  callbacks: {
    async session(session) {
      session.admin = await isAdminEmail(session?.user?.email);
      try {
        if (session?.user?.email) {
          await getPool().query(
            "INSERT INTO users (name, email, image) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE name=VALUES(name), image=VALUES(image)",
            [session.user.name || "", session.user.email, session.user.image || ""]
          );
        }
      } catch (err) {
        console.error("Unable to sync user in MySQL", err.message);
      }
      return session;
    },
  },
  theme: "dark",
});
