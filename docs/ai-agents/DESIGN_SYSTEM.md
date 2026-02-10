# Design System Reference

> AI-friendly reference for your project's design system.
> Update this file whenever tokens, components, or patterns change.

---

## Color System

### Brand Colors

```css
--color-primary:       #YOUR_PRIMARY;      /* Main brand color */
--color-primary-light: #YOUR_PRIMARY_L;    /* Hover states, backgrounds */
--color-primary-dark:  #YOUR_PRIMARY_D;    /* Active states, text on light */

--color-secondary:       #YOUR_SECONDARY;
--color-secondary-light: #YOUR_SECONDARY_L;
--color-secondary-dark:  #YOUR_SECONDARY_D;

--color-accent:       #YOUR_ACCENT;        /* CTAs, highlights */
--color-accent-light: #YOUR_ACCENT_L;
--color-accent-dark:  #YOUR_ACCENT_D;
```

### Neutral Colors

```css
--color-white:    #FFFFFF;
--color-gray-50:  #F9FAFB;
--color-gray-100: #F3F4F6;
--color-gray-200: #E5E7EB;
--color-gray-300: #D1D5DB;
--color-gray-400: #9CA3AF;
--color-gray-500: #6B7280;
--color-gray-600: #4B5563;
--color-gray-700: #374151;
--color-gray-800: #1F2937;
--color-gray-900: #111827;
--color-black:    #000000;
```

### Semantic Colors

```css
--color-success:     #10B981;   /* Confirmations, positive states */
--color-success-bg:  #D1FAE5;
--color-warning:     #F59E0B;   /* Cautions, attention needed */
--color-warning-bg:  #FEF3C7;
--color-error:       #EF4444;   /* Errors, destructive actions */
--color-error-bg:    #FEE2E2;
--color-info:        #3B82F6;   /* Informational, neutral highlights */
--color-info-bg:     #DBEAFE;
```

### Surface Colors

```css
--color-background:      #FFFFFF;
--color-surface:         #F8F9FA;
--color-surface-raised:  #FFFFFF;
--color-surface-overlay: rgba(0, 0, 0, 0.5);
--color-border:          #E5E7EB;
--color-border-focus:    var(--color-primary);
```

---

## Typography

### Font Families

```css
--font-display: 'YOUR_DISPLAY_FONT', serif;         /* Hero headings */
--font-heading: 'YOUR_HEADING_FONT', sans-serif;     /* Section headings */
--font-body:    'Inter', system-ui, sans-serif;       /* Body text */
--font-mono:    'JetBrains Mono', monospace;          /* Code blocks */
```

### Font Sizes (rem scale)

| Token | Size | Line Height | Usage |
|-------|------|-------------|-------|
| `text-xs` | 0.75rem (12px) | 1rem | Captions, labels |
| `text-sm` | 0.875rem (14px) | 1.25rem | Secondary text, metadata |
| `text-base` | 1rem (16px) | 1.5rem | Body text |
| `text-lg` | 1.125rem (18px) | 1.75rem | Large body, intro text |
| `text-xl` | 1.25rem (20px) | 1.75rem | H4, card titles |
| `text-2xl` | 1.5rem (24px) | 2rem | H3, section titles |
| `text-3xl` | 1.875rem (30px) | 2.25rem | H2, page subtitles |
| `text-4xl` | 2.25rem (36px) | 2.5rem | H1, page titles |
| `text-5xl` | 3rem (48px) | 1.15 | Hero headings |
| `text-6xl` | 3.75rem (60px) | 1.1 | Display headings |

### Font Weights

| Token | Weight | Usage |
|-------|--------|-------|
| `font-light` | 300 | Decorative, large display text |
| `font-normal` | 400 | Body text |
| `font-medium` | 500 | Emphasis, labels, navigation |
| `font-semibold` | 600 | Subheadings, buttons |
| `font-bold` | 700 | Headings, strong emphasis |

---

## Spacing System

Base unit: **4px**

| Token | Value | Usage |
|-------|-------|-------|
| `space-0` | 0px | Reset |
| `space-1` | 4px | Tight inner padding, icon gaps |
| `space-2` | 8px | Default inner padding, form gaps |
| `space-3` | 12px | Compact section padding |
| `space-4` | 16px | Default section padding, card padding |
| `space-5` | 20px | Medium spacing |
| `space-6` | 24px | Large inner spacing |
| `space-8` | 32px | Section separation |
| `space-10` | 40px | Large section separation |
| `space-12` | 48px | Page section gaps |
| `space-16` | 64px | Major section separation |
| `space-20` | 80px | Page-level vertical spacing |

---

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `rounded-none` | 0px | Sharp corners |
| `rounded-sm` | 2px | Subtle rounding |
| `rounded` | 4px | Default buttons, inputs |
| `rounded-md` | 6px | Cards, containers |
| `rounded-lg` | 8px | Modals, larger cards |
| `rounded-xl` | 12px | Feature cards |
| `rounded-2xl` | 16px | Hero sections |
| `rounded-full` | 9999px | Pills, avatars, circular buttons |

---

## Shadows

```css
--shadow-xs:  0 1px 2px rgba(0, 0, 0, 0.05);
--shadow-sm:  0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
--shadow-md:  0 4px 6px rgba(0, 0, 0, 0.07), 0 2px 4px rgba(0, 0, 0, 0.06);
--shadow-lg:  0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05);
--shadow-xl:  0 20px 25px rgba(0, 0, 0, 0.1), 0 10px 10px rgba(0, 0, 0, 0.04);
--shadow-2xl: 0 25px 50px rgba(0, 0, 0, 0.25);
--shadow-inner: inset 0 2px 4px rgba(0, 0, 0, 0.06);
```

---

## Component Inventory

### Available Base Components (shadcn/ui)

Button, Input, Textarea, Select, Checkbox, Radio, Switch, Slider,
Dialog, Sheet, Popover, Tooltip, Dropdown Menu, Context Menu,
Card, Badge, Avatar, Separator, Tabs, Accordion,
Table, Pagination, Command, Calendar, Date Picker,
Toast, Alert, Progress, Skeleton, Scroll Area

### Custom Components

| Component | Location | Description |
|-----------|----------|-------------|
| `[Name]` | `[path]` | `[description]` |

---

## Icon System

- **Library:** [Lucide React / Heroicons / etc.]
- **Default size:** 20px (w-5 h-5)
- **Stroke width:** 1.5px
- **Usage:** Always use semantic color, not hardcoded

```tsx
import { IconName } from '[icon-library]';
<IconName className="h-5 w-5 text-gray-500" />
```

---

## Animation Guidelines

| Property | Duration | Easing | Usage |
|----------|----------|--------|-------|
| Color/opacity | 150ms | ease-in-out | Hover states, focus |
| Transform | 200ms | ease-out | Buttons, scale effects |
| Layout | 300ms | ease-in-out | Expanding/collapsing |
| Page transition | 200ms | ease-out | Route changes |
| Modal/overlay | 200ms | ease-out | Open/close |

```css
--transition-fast:   150ms ease-in-out;
--transition-base:   200ms ease-out;
--transition-slow:   300ms ease-in-out;
--transition-spring: 400ms cubic-bezier(0.34, 1.56, 0.64, 1);
```

---

## Dark Mode Variables

```css
[data-theme="dark"] {
  --color-background:     #0F172A;
  --color-surface:        #1E293B;
  --color-surface-raised: #334155;
  --color-text:           #F1F5F9;
  --color-text-muted:     #94A3B8;
  --color-border:         #334155;

  /* Adjust brand colors for dark backgrounds if needed */
  --color-primary:        #YOUR_PRIMARY_DARK_MODE;
  --color-secondary:      #YOUR_SECONDARY_DARK_MODE;
}
```
