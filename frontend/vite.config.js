import { defineConfig } from "vite";
import elmPlugin from "vite-plugin-elm";

export default defineConfig({
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:4000',
        secure: false,
      }
    }
  },
  plugins: [elmPlugin()],
  base: process.env.NODE_ENV === "production" ? "/web/" : "/",
});
