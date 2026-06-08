#!/usr/bin/env node
/**
 * Sitemap generator (runs as `postbuild`).
 *
 * Template-friendly: it writes `public/sitemap.xml` from a SITE_URL and a list
 * of routes. Until you configure it, it warns and exits 0 so it never breaks
 * your build. Fill in SITE_URL (env or below) and your ROUTES, and it starts
 * producing a real sitemap.
 *
 * No dependencies -- Node standard library only.
 */
import { writeFileSync, mkdirSync, existsSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT = resolve(__dirname, "..", "public", "sitemap.xml");

// Configure these for your project (SITE_URL can also come from the environment).
const SITE_URL = process.env.SITE_URL || ""; // e.g. "https://yourapp.com"
const ROUTES = [
  "/",
  // "/pricing",
  // "/login",
  // Add your public, indexable routes here.
];

if (!SITE_URL) {
  console.warn(
    "[generate-sitemap] SITE_URL is not set -- skipping sitemap generation. " +
      "Set SITE_URL and list your routes in scripts/generate-sitemap.js to enable it."
  );
  process.exit(0);
}

const base = SITE_URL.replace(/\/$/, "");
const today = new Date().toISOString().split("T")[0];

const urls = ROUTES.map(
  (route) =>
    `  <url>\n    <loc>${base}${route}</loc>\n    <lastmod>${today}</lastmod>\n  </url>`
).join("\n");

const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`;

const outDir = dirname(OUT);
if (!existsSync(outDir)) mkdirSync(outDir, { recursive: true });
writeFileSync(OUT, xml);
console.log(`[generate-sitemap] Wrote ${ROUTES.length} route(s) to public/sitemap.xml`);
