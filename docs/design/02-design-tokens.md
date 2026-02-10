# Design Token Definitions

> Tokens are the atomic design decisions that ensure consistency. Define them
> here, then propagate to CSS, Tailwind, Figma, and any other platform.

---

## Color Tokens

### Brand Colors (CSS Custom Properties)

```css
:root {
  /* Primary -- your main brand color */
  --color-primary-50:  #F0F4FF;  /* Lightest tint */
  --color-primary-100: #DDE6FF;
  --color-primary-200: #B3C7FF;
  --color-primary-300: #809FFF;
  --color-primary-400: #4D77FF;
  --color-primary-500: #YOUR_PRIMARY;  /* Base */
  --color-primary-600: #YOUR_PRIMARY_600;
  --color-primary-700: #YOUR_PRIMARY_700;
  --color-primary-800: #YOUR_PRIMARY_800;
  --color-primary-900: #YOUR_PRIMARY_900;

  /* Secondary */
  --color-secondary-50:  #F5F3FF;
  --color-secondary-100: #EDE9FE;
  --color-secondary-500: #YOUR_SECONDARY;
  --color-secondary-700: #YOUR_SECONDARY_700;
  --color-secondary-900: #YOUR_SECONDARY_900;

  /* Accent */
  --color-accent-50:  #FFFBEB;
  --color-accent-100: #FEF3C7;
  --color-accent-500: #YOUR_ACCENT;
  --color-accent-700: #YOUR_ACCENT_700;
  --color-accent-900: #YOUR_ACCENT_900;
}
```

### Semantic Colors

```css
:root {
  /* Surface & Background */
  --color-background:      #FFFFFF;
  --color-surface:         #F8F9FA;
  --color-surface-raised:  #FFFFFF;
  --color-surface-sunken:  #F1F3F5;

  /* Text */
  --color-text-primary:    #1A1A2E;
  --color-text-secondary:  #4B5563;
  --color-text-muted:      #6B7280;
  --color-text-inverse:    #FFFFFF;
  --color-text-link:       var(--color-primary-500);

  /* Border */
  --color-border-default:  #E5E7EB;
  --color-border-strong:   #D1D5DB;
  --color-border-focus:    var(--color-primary-500);

  /* Status */
  --color-success-500:     #10B981;
  --color-success-50:      #ECFDF5;
  --color-warning-500:     #F59E0B;
  --color-warning-50:      #FFFBEB;
  --color-error-500:       #EF4444;
  --color-error-50:        #FEF2F2;
  --color-info-500:        #3B82F6;
  --color-info-50:         #EFF6FF;
}
```

---

## Typography Tokens

```css
:root {
  /* Font Families */
  --font-display:  'YOUR_DISPLAY_FONT', Georgia, serif;
  --font-heading:  'YOUR_HEADING_FONT', system-ui, sans-serif;
  --font-body:     'Inter', system-ui, -apple-system, sans-serif;
  --font-mono:     'JetBrains Mono', 'Fira Code', monospace;

  /* Font Sizes */
  --text-xs:    0.75rem;    /* 12px */
  --text-sm:    0.875rem;   /* 14px */
  --text-base:  1rem;       /* 16px */
  --text-lg:    1.125rem;   /* 18px */
  --text-xl:    1.25rem;    /* 20px */
  --text-2xl:   1.5rem;     /* 24px */
  --text-3xl:   1.875rem;   /* 30px */
  --text-4xl:   2.25rem;    /* 36px */
  --text-5xl:   3rem;       /* 48px */
  --text-6xl:   3.75rem;    /* 60px */

  /* Line Heights */
  --leading-none:    1;
  --leading-tight:   1.25;
  --leading-snug:    1.375;
  --leading-normal:  1.5;
  --leading-relaxed: 1.625;
  --leading-loose:   2;

  /* Font Weights */
  --font-light:     300;
  --font-normal:    400;
  --font-medium:    500;
  --font-semibold:  600;
  --font-bold:      700;

  /* Letter Spacing */
  --tracking-tighter: -0.05em;
  --tracking-tight:   -0.025em;
  --tracking-normal:  0em;
  --tracking-wide:    0.025em;
  --tracking-wider:   0.05em;
}
```

---

## Spacing Tokens

Based on a 4px grid system.

```css
:root {
  --space-0:   0;
  --space-px:  1px;
  --space-0.5: 0.125rem;   /* 2px */
  --space-1:   0.25rem;    /* 4px */
  --space-1.5: 0.375rem;   /* 6px */
  --space-2:   0.5rem;     /* 8px */
  --space-3:   0.75rem;    /* 12px */
  --space-4:   1rem;       /* 16px */
  --space-5:   1.25rem;    /* 20px */
  --space-6:   1.5rem;     /* 24px */
  --space-8:   2rem;       /* 32px */
  --space-10:  2.5rem;     /* 40px */
  --space-12:  3rem;       /* 48px */
  --space-16:  4rem;       /* 64px */
  --space-20:  5rem;       /* 80px */
  --space-24:  6rem;       /* 96px */
}
```

---

## Shadow Tokens

```css
:root {
  --shadow-xs:    0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-sm:    0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1);
  --shadow-md:    0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  --shadow-lg:    0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
  --shadow-xl:    0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  --shadow-2xl:   0 25px 50px -12px rgba(0, 0, 0, 0.25);
  --shadow-inner: inset 0 2px 4px 0 rgba(0, 0, 0, 0.05);
}
```

---

## Border Tokens

```css
:root {
  /* Border Width */
  --border-0:   0px;
  --border-1:   1px;
  --border-2:   2px;
  --border-4:   4px;

  /* Border Radius */
  --radius-none: 0px;
  --radius-sm:   0.125rem;   /* 2px */
  --radius-md:   0.375rem;   /* 6px */
  --radius-lg:   0.5rem;     /* 8px */
  --radius-xl:   0.75rem;    /* 12px */
  --radius-2xl:  1rem;       /* 16px */
  --radius-full: 9999px;
}
```

---

## Breakpoint Tokens

```css
/* Used in Tailwind config and media queries */
--breakpoint-sm:  640px;    /* Mobile landscape */
--breakpoint-md:  768px;    /* Tablet */
--breakpoint-lg:  1024px;   /* Desktop */
--breakpoint-xl:  1280px;   /* Wide desktop */
--breakpoint-2xl: 1536px;   /* Ultra-wide */
```

---

## Animation Tokens

```css
:root {
  /* Durations */
  --duration-fast:    100ms;
  --duration-normal:  200ms;
  --duration-slow:    300ms;
  --duration-slower:  500ms;

  /* Easing */
  --ease-in:     cubic-bezier(0.4, 0, 1, 1);
  --ease-out:    cubic-bezier(0, 0, 0.2, 1);
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);

  /* Composed transitions */
  --transition-colors:   color var(--duration-fast) var(--ease-in-out),
                         background-color var(--duration-fast) var(--ease-in-out),
                         border-color var(--duration-fast) var(--ease-in-out);
  --transition-transform: transform var(--duration-normal) var(--ease-out);
  --transition-all:       all var(--duration-normal) var(--ease-in-out);
}
```

---

## How to Customize Tokens

1. **Edit `tokens.json`** -- the machine-readable source of truth
2. **Update CSS variables** in `globals.css` to match
3. **Sync `tailwind.config.ts`** -- extend the theme with your token values
4. **Update Figma** -- apply new token values to your Figma library
5. **Test** -- visually inspect all major pages and components
6. **Document** -- update this file with any new or changed tokens

### Token Naming Convention

```
--{category}-{property}-{variant}-{state}

Examples:
--color-primary-500
--color-text-muted
--space-4
--radius-lg
--shadow-md
```
