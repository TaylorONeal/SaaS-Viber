# Branding Setup Guide

How to go from "unnamed project" to a polished, consistent brand across every surface your users touch.

---

## Quick Setup (30 minutes)

Get the basics in place before you do anything else.

### 1. Product Name
- [ ] Name chosen and domain purchased
- [ ] Check trademark availability (USPTO TESS, your country's equivalent)
- [ ] Secure matching social handles (@yourproduct on X, LinkedIn, GitHub)
- [ ] Set `NEXT_PUBLIC_APP_NAME` in your environment config

### 2. Primary Colors
- [ ] Pick a primary brand color (the one color people associate with you)
- [ ] Pick a secondary/accent color
- [ ] Define a neutral palette (grays for text, borders, backgrounds)
- [ ] Set CSS custom properties or design token values

### 3. Logo
- [ ] Create or commission a logo (SVG preferred)
- [ ] Place in `/public/logo.svg` and `/public/logo-dark.svg`
- [ ] Ensure it works at 24px height (navbar) and 200px+ (marketing)

### 4. Favicon
- [ ] Generate favicons from your logo (see Favicon section below)
- [ ] Place in `/public/` directory
- [ ] Test in browser tabs at small sizes

---

## Design Tokens

Design tokens are the single source of truth for your visual language. Define them once, use them everywhere.

### Token Categories

```
tokens/
  colors.ts        # Brand, semantic, and neutral colors
  typography.ts     # Font families, sizes, weights, line heights
  spacing.ts        # Consistent spacing scale (4, 8, 12, 16, 24, 32, 48, 64)
  radii.ts          # Border radius values
  shadows.ts        # Elevation/shadow definitions
  breakpoints.ts    # Responsive breakpoints
```

### Color Token Structure

| Token Name | Purpose | Example |
|---|---|---|
| `color-primary` | Main brand actions, links | `#2563EB` |
| `color-primary-hover` | Hover state for primary | `#1D4ED8` |
| `color-secondary` | Secondary actions | `#7C3AED` |
| `color-success` | Positive states | `#059669` |
| `color-warning` | Caution states | `#D97706` |
| `color-error` | Error/destructive states | `#DC2626` |
| `color-surface` | Card/panel backgrounds | `#FFFFFF` |
| `color-background` | Page background | `#F9FAFB` |
| `color-text-primary` | Body text | `#111827` |
| `color-text-secondary` | Muted/supporting text | `#6B7280` |

---

## Theme System

### Light and Dark Mode

Support both from day one. It is much harder to add dark mode retroactively.

- [ ] Define light theme token set
- [ ] Define dark theme token set
- [ ] Implement theme toggle (respect `prefers-color-scheme` as default)
- [ ] Store user preference in localStorage or user profile
- [ ] Test every page in both themes

### Custom Themes (Optional)

If you plan to offer white-labeling or tenant-specific branding:
- [ ] Create a theme configuration schema
- [ ] Build a theme provider that accepts runtime overrides
- [ ] Store tenant themes in database
- [ ] Apply via CSS custom properties for zero-JS theme switching

---

## Typography Selection

### Choosing Fonts

Pick **two fonts maximum**: one for headings, one for body. Using one font for both is also fine.

**Recommended pairings for SaaS:**
- Inter (body) + Inter (headings) -- clean, professional, free
- System font stack (body) + one display font (headings) -- fastest load
- DM Sans (body) + DM Serif Display (headings) -- modern with character

### Font Loading

- [ ] Use `next/font` or `@font-face` with `font-display: swap`
- [ ] Self-host fonts (do not rely on Google Fonts CDN for privacy/GDPR)
- [ ] Subset fonts to only characters you need (latin, latin-ext)
- [ ] Preload critical font files

### Type Scale

Define a consistent scale and stick to it:

| Token | Size | Usage |
|---|---|---|
| `text-xs` | 12px | Labels, captions |
| `text-sm` | 14px | Secondary text, table cells |
| `text-base` | 16px | Body text |
| `text-lg` | 18px | Lead paragraphs |
| `text-xl` | 20px | Card headings |
| `text-2xl` | 24px | Section headings |
| `text-3xl` | 30px | Page headings |
| `text-4xl` | 36px | Hero headings |

---

## Color Palette and Accessibility

### Contrast Requirements (WCAG 2.1 AA)

- **Normal text**: 4.5:1 contrast ratio minimum
- **Large text** (18px+ or 14px bold): 3:1 minimum
- **UI components** (buttons, inputs, icons): 3:1 minimum

### Testing Contrast

Use these tools before finalizing any color:
- WebAIM Contrast Checker: https://webaim.org/resources/contrastchecker/
- Realtime Colors: https://www.realtimecolors.com/
- Coolors contrast checker in palette generator

### Common Mistakes
- Light gray text on white backgrounds (fails contrast)
- Colored text on colored backgrounds without checking
- Placeholder text that is unreadable
- Disabled states that are invisible to low-vision users

---

## Logo Requirements

### Formats Needed

| Format | Use Case | Min Size |
|---|---|---|
| SVG | Web (preferred everywhere) | Vector |
| PNG @1x | Fallback, emails | 200x200 |
| PNG @2x | Retina displays | 400x400 |
| PNG @3x | High-DPI mobile | 600x600 |
| Icon-only | Favicons, app icons | 512x512 |

### Versions Needed

- [ ] Full logo (icon + wordmark) -- horizontal
- [ ] Full logo (icon + wordmark) -- stacked/vertical
- [ ] Icon only (square, works in circles too)
- [ ] Light background version
- [ ] Dark background version
- [ ] Monochrome version (for watermarks, loading states)

---

## Favicon Generation

Start with a **512x512 PNG** of your icon mark, then generate:

- [ ] `favicon.ico` (16x16, 32x32, 48x48 multi-size)
- [ ] `apple-touch-icon.png` (180x180)
- [ ] `icon-192.png` (192x192, for PWA manifest)
- [ ] `icon-512.png` (512x512, for PWA manifest)
- [ ] `og-image.png` (1200x630, default social share image)

**Tool**: Use https://realfavicongenerator.net/ -- upload your 512px icon and it generates everything with the correct HTML tags.

---

## Social Media Assets

- [ ] Profile picture (square, 400x400+ -- usually your icon mark)
- [ ] Cover/banner image for X (1500x500)
- [ ] Cover/banner image for LinkedIn (1128x191)
- [ ] Default Open Graph image (1200x630)
- [ ] Consistent bio/description across all platforms
- [ ] Link to your marketing site from all profiles

---

## Email Template Branding

- [ ] Logo in email header (max 200px wide, link to homepage)
- [ ] Brand colors in buttons (primary color for CTA)
- [ ] Consistent footer (company name, address, unsubscribe link)
- [ ] Plain text fallback for every email
- [ ] Test rendering in Gmail, Outlook, Apple Mail at minimum
- [ ] Transactional emails match marketing site feel
- [ ] Set reply-to address to a monitored inbox

---

## Loading and Splash Screen

- [ ] Display logo mark (icon only) during initial load
- [ ] Use brand primary color or neutral background
- [ ] Keep animation minimal (a subtle pulse or fade, not a circus)
- [ ] Loading state should appear within 100ms
- [ ] Full app should render within 3 seconds on 3G
- [ ] PWA splash screen configured in `manifest.json` (icon + background color)

---

## Branding Consistency Audit

Run this check quarterly or before any major launch:

- [ ] Logo renders correctly on all pages
- [ ] Colors match tokens (no hardcoded hex values scattered around)
- [ ] Typography is consistent (no rogue font sizes)
- [ ] Dark mode works on all pages
- [ ] Email templates match current brand
- [ ] Social media profiles are up to date
- [ ] OG images are current and render correctly when shared
- [ ] Favicon is visible and correct in browser tabs

---

*Keep your brand file (colors, fonts, logo files) in a single directory. When you need to rebrand or adjust, you change it in one place.*
