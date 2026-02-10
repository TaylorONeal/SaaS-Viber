import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

// ============================================
// [YOUR_APP_NAME] Vite Configuration
// ============================================
// Docs: https://vitejs.dev/config/
//
// TEMPLATE: This is a production-ready Vite config for a SaaS SPA.
// Customize the sections below based on your needs.

export default defineConfig(({ mode }) => ({
  // --------------------------------------------
  // Plugins
  // --------------------------------------------
  // TEMPLATE: Add plugins as needed. Common additions:
  // - @vitejs/plugin-legacy (for older browser support)
  // - vite-plugin-pwa (for PWA support)
  // - vite-plugin-compression (for gzip/brotli pre-compression)
  plugins: [
    react(),
  ],

  // --------------------------------------------
  // Path Resolution
  // --------------------------------------------
  // TEMPLATE: The "@" alias maps to src/ for cleaner imports.
  // Usage: import { Button } from "@/components/ui/button"
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },

  // --------------------------------------------
  // Development Server
  // --------------------------------------------
  server: {
    port: 8080,
    host: "::",
    // TEMPLATE: Configure proxy for API calls during development
    // proxy: {
    //   "/api": {
    //     target: "http://localhost:3001",
    //     changeOrigin: true,
    //   },
    // },
  },

  // --------------------------------------------
  // Build Configuration
  // --------------------------------------------
  build: {
    // Target modern browsers for smaller bundles
    target: "esnext",
    // Generate source maps for error tracking (Sentry, etc.)
    sourcemap: mode === "production",
    // Rollup options for code splitting
    rollupOptions: {
      output: {
        // TEMPLATE: Customize chunk splitting strategy for your app.
        // This splits vendor code from your application code.
        manualChunks: {
          // vendor: ["react", "react-dom", "react-router-dom"],
          // ui: ["@radix-ui/react-dialog", "@radix-ui/react-dropdown-menu"],
        },
      },
    },
    // Warn if chunks exceed 500KB
    chunkSizeWarningLimit: 500,
  },

  // --------------------------------------------
  // Environment Variable Prefix
  // --------------------------------------------
  // Only variables prefixed with VITE_ are exposed to client code.
  // This is the default and is set here explicitly for clarity.
  envPrefix: "VITE_",
}));
