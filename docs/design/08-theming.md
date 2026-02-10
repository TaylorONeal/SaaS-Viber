# Theme System

> Your theme is defined by CSS custom properties. Change the variables, change the
> entire look. No component code changes needed.

---

## Where to Edit Themes

| What You Want to Change | Where to Edit |
|---|---|
| **Light mode colors** | `src/styles/globals.css` → `:root { }` block |
| **Dark mode colors** | `src/styles/globals.css` → `.dark { }` block |
| **Color token definitions** | `docs/design/tokens/tokens.json` → color section |
| **Tailwind color mapping** | `tailwind.config.ts` → colors section |
| **shadcn/ui theme** | `src/styles/globals.css` → HSL color variables |
| **Font families** | `docs/design/tokens/tokens.json` → typography.fontFamily |
| **Border radius** | `src/styles/globals.css` → `--radius` variable |
| **This reference** | `docs/design/08-theming.md` |

---

## How the Theme System Works

```
tokens.json (source of truth)
    ↓
globals.css (CSS custom properties -- :root and .dark)
    ↓
tailwind.config.ts (maps CSS vars to Tailwind classes)
    ↓
Components (use Tailwind classes like bg-primary, text-foreground)
    ↓
Theme toggle (adds/removes .dark class on <html>)
```

**The key insight:** Components never reference specific colors. They use semantic names like `bg-primary` or `text-muted-foreground`. When you change the CSS variables, every component updates automatically.

---

## Light Theme (Default)

These CSS custom properties define the light theme. Edit these in `src/styles/globals.css` under `:root`.

```css
:root {
  /* -- Page -- */
  --background: 0 0% 100%;            /* White page background */
  --foreground: 222 47% 11%;          /* Near-black text */

  /* -- Cards and raised surfaces -- */
  --card: 0 0% 100%;
  --card-foreground: 222 47% 11%;

  /* -- Popover/dropdown surfaces -- */
  --popover: 0 0% 100%;
  --popover-foreground: 222 47% 11%;

  /* -- Primary action color (buttons, links, focus rings) -- */
  --primary: 222 47% 31%;             /* ← YOUR BRAND COLOR (HSL) */
  --primary-foreground: 210 40% 98%;  /* Text on primary buttons */

  /* -- Secondary (less prominent actions) -- */
  --secondary: 210 40% 96%;
  --secondary-foreground: 222 47% 11%;

  /* -- Muted (disabled, placeholder, subtle backgrounds) -- */
  --muted: 210 40% 96%;
  --muted-foreground: 215 16% 47%;

  /* -- Accent (hover backgrounds, active states) -- */
  --accent: 210 40% 96%;
  --accent-foreground: 222 47% 11%;

  /* -- Destructive (delete, danger, errors) -- */
  --destructive: 0 84% 60%;
  --destructive-foreground: 210 40% 98%;

  /* -- Borders and inputs -- */
  --border: 214 32% 91%;
  --input: 214 32% 91%;
  --ring: 222 47% 31%;                /* Focus ring color */

  /* -- Border radius -- */
  --radius: 0.5rem;                    /* Base radius for all components */

  /* -- Sidebar (if using sidebar layout) -- */
  --sidebar-background: 0 0% 98%;
  --sidebar-foreground: 240 5% 26%;
  --sidebar-primary: 240 6% 10%;
  --sidebar-primary-foreground: 0 0% 98%;
  --sidebar-accent: 240 5% 96%;
  --sidebar-accent-foreground: 240 6% 10%;
  --sidebar-border: 220 13% 91%;
  --sidebar-ring: 217 91% 60%;
}
```

### How to pick your primary color

1. Start with your brand's hex color (e.g., `#2563EB`)
2. Convert to HSL (e.g., `217 91% 53%`)
3. Set `--primary` to the HSL values without the `hsl()` wrapper
4. Set `--ring` to match (focus rings should match primary)
5. Verify contrast: primary foreground text on primary background must be 4.5:1+

**Tools:**
- HSL converter: Search "hex to hsl" in any browser
- Contrast checker: https://webaim.org/resources/contrastchecker/

---

## Dark Theme

Edit these in `src/styles/globals.css` under `.dark`.

```css
.dark {
  --background: 222 47% 5%;           /* Near-black page */
  --foreground: 210 40% 98%;          /* Near-white text */

  --card: 222 47% 8%;
  --card-foreground: 210 40% 98%;

  --popover: 222 47% 8%;
  --popover-foreground: 210 40% 98%;

  --primary: 217 91% 60%;             /* ← Lighter version of brand color */
  --primary-foreground: 222 47% 5%;

  --secondary: 217 33% 17%;
  --secondary-foreground: 210 40% 98%;

  --muted: 217 33% 17%;
  --muted-foreground: 215 20% 65%;

  --accent: 217 33% 17%;
  --accent-foreground: 210 40% 98%;

  --destructive: 0 62% 50%;
  --destructive-foreground: 210 40% 98%;

  --border: 217 33% 17%;
  --input: 217 33% 17%;
  --ring: 224 76% 48%;

  --sidebar-background: 240 6% 10%;
  --sidebar-foreground: 240 5% 65%;
  --sidebar-primary: 224 76% 48%;
  --sidebar-primary-foreground: 0 0% 100%;
  --sidebar-accent: 240 4% 16%;
  --sidebar-accent-foreground: 240 5% 65%;
  --sidebar-border: 240 4% 16%;
  --sidebar-ring: 217 91% 60%;
}
```

### Dark theme color rules

- Background: 5-10% lightness (not pure black -- `#000` is harsh)
- Card surfaces: 3-5% lighter than background
- Text: 90-98% lightness (not pure white -- `#FFF` is too bright)
- Primary: Use a lighter/brighter variant of your brand color
- Borders: subtle (15-20% lightness) -- less contrast than light mode
- Status colors (success, warning, error): same hue, adjust lightness for dark backgrounds

---

## Theme Toggle Implementation

### HTML class strategy (recommended)

```tsx
// Theme provider that manages .dark class on <html>
function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setTheme] = useState<"light" | "dark" | "system">(() => {
    if (typeof window === "undefined") return "system";
    return (localStorage.getItem("theme") as "light" | "dark" | "system") || "system";
  });

  useEffect(() => {
    const root = document.documentElement;
    const systemDark = window.matchMedia("(prefers-color-scheme: dark)").matches;

    if (theme === "dark" || (theme === "system" && systemDark)) {
      root.classList.add("dark");
    } else {
      root.classList.remove("dark");
    }

    localStorage.setItem("theme", theme);
  }, [theme]);

  // Listen for system theme changes when in "system" mode
  useEffect(() => {
    if (theme !== "system") return;
    const mq = window.matchMedia("(prefers-color-scheme: dark)");
    const handler = (e: MediaQueryListEvent) => {
      document.documentElement.classList.toggle("dark", e.matches);
    };
    mq.addEventListener("change", handler);
    return () => mq.removeEventListener("change", handler);
  }, [theme]);

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}
```

### Theme toggle button

```tsx
function ThemeToggle() {
  const { theme, setTheme } = useTheme();

  return (
    <button
      onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
      aria-label={`Switch to ${theme === "dark" ? "light" : "dark"} mode`}
      className="rounded-md p-2 hover:bg-accent"
    >
      {theme === "dark" ? <SunIcon /> : <MoonIcon />}
    </button>
  );
}
```

### Prevent flash of wrong theme

Add this script to `index.html` before the app loads:

```html
<script>
  (function() {
    var theme = localStorage.getItem('theme');
    if (theme === 'dark' || (!theme && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      document.documentElement.classList.add('dark');
    }
  })();
</script>
```

---

## Custom / White-Label Themes

If your SaaS supports per-tenant or per-user themes:

### Schema

```typescript
interface ThemeConfig {
  name: string;
  colors: {
    primary: string;        // HSL values: "217 91% 53%"
    primaryForeground: string;
    background: string;
    foreground: string;
    accent: string;
    accentForeground: string;
    // ... extend as needed
  };
  radius: string;           // e.g., "0.5rem"
  fontFamily?: string;      // Optional custom font
}
```

### Runtime application

```typescript
function applyTheme(theme: ThemeConfig) {
  const root = document.documentElement;
  Object.entries(theme.colors).forEach(([key, value]) => {
    // Convert camelCase to CSS var name: primaryForeground → --primary-foreground
    const cssVar = `--${key.replace(/([A-Z])/g, "-$1").toLowerCase()}`;
    root.style.setProperty(cssVar, value);
  });
  if (theme.radius) root.style.setProperty("--radius", theme.radius);
}
```

### Storage

Store custom themes in your database per tenant/organization. Apply on login by fetching the theme config and calling `applyTheme()`.

---

## Color Palette Generator

When building your palette from a single brand color:

### From one hex color to a full theme

1. **Primary**: Your brand color
2. **Primary hover**: 5-10% darker (reduce lightness)
3. **Primary light**: Background tint (same hue, 95% lightness)
4. **Destructive**: `0° 84% 60%` (red -- rarely needs customizing)
5. **Success**: `142° 71% 45%` (green)
6. **Warning**: `38° 92% 50%` (amber)
7. **Info**: `217° 91% 60%` (blue)

### Tools for palette generation

- **Realtime Colors**: https://www.realtimecolors.com/ -- see your colors on a real UI
- **Tailwind CSS Colors**: Use as a reference for neutral/gray scales
- **shadcn/ui Themes**: https://ui.shadcn.com/themes -- generates HSL values you can paste directly

---

## Testing Your Theme

### Checklist for every theme change

- [ ] All text meets WCAG 2.1 AA contrast ratios (4.5:1 normal, 3:1 large)
- [ ] Focus rings are visible on all interactive elements
- [ ] Disabled states are distinguishable but clearly disabled
- [ ] Status colors (success/warning/error) are distinguishable from each other
- [ ] Charts and data visualizations work in both themes
- [ ] Images with transparent backgrounds work in both themes
- [ ] Shadows are visible but not too harsh in dark mode
- [ ] No hardcoded colors anywhere (search codebase for `#` in TSX/CSS files)
- [ ] Theme toggle works and persists across page refresh
- [ ] System preference is respected when no manual choice is set
