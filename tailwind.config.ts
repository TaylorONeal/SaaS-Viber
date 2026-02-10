import type { Config } from "tailwindcss";

// ============================================
// [YOUR_APP_NAME] Tailwind Configuration
// ============================================
//
// TEMPLATE: This config includes shadcn/ui compatibility, CSS custom properties
// for theming, and sensible defaults for a SaaS application.
//
// Customization points are marked with TEMPLATE comments.
// See SETUP_GUIDE.md Phase 2 for guidance on design tokens.

export default {
  // Dark mode via class strategy (for manual toggle support)
  darkMode: ["class"],

  // Content paths -- where Tailwind should scan for class usage
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    // TEMPLATE: Add additional content paths if needed
    // "./node_modules/@your-ui-library/**/*.{js,ts,jsx,tsx}",
  ],

  theme: {
    // --------------------------------------------
    // Container
    // --------------------------------------------
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },

    extend: {
      // --------------------------------------------
      // Colors (CSS Custom Properties for Theming)
      // --------------------------------------------
      // TEMPLATE: These map to CSS variables defined in your global CSS.
      // This approach lets you switch themes (light/dark) by changing
      // CSS variable values instead of Tailwind classes.
      //
      // Define your actual color values in src/index.css:
      //   :root { --primary: 222 47% 11%; }
      //   .dark { --primary: 210 40% 98%; }
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        // TEMPLATE: Add your brand-specific colors here.
        // These are in addition to the shadcn/ui semantic colors above.
        // brand: {
        //   50: "#f0f9ff",
        //   100: "#e0f2fe",
        //   ...
        //   900: "#0c4a6e",
        //   950: "#082f49",
        // },
        sidebar: {
          DEFAULT: "hsl(var(--sidebar-background))",
          foreground: "hsl(var(--sidebar-foreground))",
          primary: "hsl(var(--sidebar-primary))",
          "primary-foreground": "hsl(var(--sidebar-primary-foreground))",
          accent: "hsl(var(--sidebar-accent))",
          "accent-foreground": "hsl(var(--sidebar-accent-foreground))",
          border: "hsl(var(--sidebar-border))",
          ring: "hsl(var(--sidebar-ring))",
        },
      },

      // --------------------------------------------
      // Border Radius
      // --------------------------------------------
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },

      // --------------------------------------------
      // Typography
      // --------------------------------------------
      // TEMPLATE: Customize your font stack.
      // Update index.html to load your chosen fonts.
      fontFamily: {
        // sans: ["Inter", "system-ui", "sans-serif"],
        // mono: ["JetBrains Mono", "monospace"],
      },

      // --------------------------------------------
      // Animations
      // --------------------------------------------
      // TEMPLATE: These are commonly used animations for SaaS UIs.
      // Add or remove based on your needs.
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
        "fade-in": {
          from: { opacity: "0" },
          to: { opacity: "1" },
        },
        "fade-out": {
          from: { opacity: "1" },
          to: { opacity: "0" },
        },
        "slide-in-from-top": {
          from: { transform: "translateY(-100%)" },
          to: { transform: "translateY(0)" },
        },
        "slide-in-from-bottom": {
          from: { transform: "translateY(100%)" },
          to: { transform: "translateY(0)" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
        "fade-in": "fade-in 0.2s ease-out",
        "fade-out": "fade-out 0.2s ease-out",
        "slide-in-from-top": "slide-in-from-top 0.3s ease-out",
        "slide-in-from-bottom": "slide-in-from-bottom 0.3s ease-out",
      },
    },
  },

  // --------------------------------------------
  // Plugins
  // --------------------------------------------
  // TEMPLATE: Add Tailwind plugins as needed.
  plugins: [
    require("tailwindcss-animate"),
    // require("@tailwindcss/typography"),  // For prose/markdown content
    // require("@tailwindcss/forms"),        // For form element defaults
    // require("@tailwindcss/container-queries"), // For container queries
  ],
} satisfies Config;
