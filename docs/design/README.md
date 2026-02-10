# Design System Overview

> Your design system is the single source of truth for visual and interaction design.
> This directory contains templates to build your own system. Customize every section.

---

## Design Principles

Define 4-6 principles that guide every design decision. Examples to adapt:

### 1. Clarity Over Cleverness

Every interface element should be immediately understandable. Avoid decorative
complexity. If a user has to think about how to use something, simplify it.

### 2. Consistency Builds Trust

Use the same patterns for the same actions throughout the application. Buttons
look the same everywhere. Errors are communicated the same way. Spacing follows
the same system.

### 3. Progressive Disclosure

Show only what is needed at each step. Advanced options are available but not
prominent. Reduce cognitive load by surfacing information at the right time.

### 4. Accessible by Default

Design for the widest possible range of users. Meet WCAG 2.1 AA as a minimum.
Color is never the sole indicator of state. All interactive elements are
keyboard accessible.

### 5. Performance Is a Feature

Fast interfaces feel better. Optimize assets, minimize layout shifts, and
provide immediate feedback for every user action. Skeleton states over spinners.

### 6. [Your Principle]

[Describe a principle specific to your product and audience.]

---

## Component Library

This system is built on **shadcn/ui** with custom extensions.

### Base Layer (shadcn/ui)

Pre-built, accessible components that follow Radix UI primitives:
- See `docs/design/05-components.md` for the full inventory
- Components are copied into your project (not imported from node_modules)
- Customize via Tailwind classes and CSS variables

### Custom Layer

Project-specific components built on top of the base layer:
- Domain-specific widgets
- Composite components (combinations of base components)
- Layout templates

### Page Templates

Full-page layouts for common SaaS patterns:
- Dashboard layouts
- Settings pages
- Onboarding flows
- Marketing/landing pages

---

## Token System

Design tokens are the atomic values of the design system. They ensure consistency
across components, themes, and platforms.

### Token Hierarchy

```
Global Tokens          (raw values: colors, sizes, fonts)
    |
Semantic Tokens        (purpose-driven: --color-primary, --text-body)
    |
Component Tokens       (scoped: --button-bg, --card-border)
```

### Token Files

| File | Format | Purpose |
|------|--------|---------|
| `docs/design/02-design-tokens.md` | Documentation | Human-readable token reference |
| `docs/design/tokens/tokens.json` | JSON | Machine-readable, tool-compatible |
| `tailwind.config.ts` | TypeScript | Tailwind integration |
| `src/styles/globals.css` | CSS | CSS custom property definitions |

### Customizing Tokens

1. Update values in `tokens.json`
2. Run your token build script (if using Style Dictionary or similar)
3. Update `tailwind.config.ts` and `globals.css` accordingly
4. Verify all components render correctly with new values

---

## Cross-Platform Guidelines

See `docs/design/06-cross-platform.md` for detailed guidance.

- **Web:** Desktop-first for admin dashboards, mobile-first for consumer pages
- **iOS:** Follow Human Interface Guidelines where applicable
- **Android:** Follow Material Design 3 where applicable
- **Shared:** Maintain brand consistency while respecting platform conventions

---

## Accessibility Standards

### Minimum Requirements (WCAG 2.1 AA)

- **Color contrast:** 4.5:1 for normal text, 3:1 for large text
- **Focus indicators:** Visible focus ring on all interactive elements
- **Keyboard navigation:** All functionality available via keyboard
- **Screen readers:** Semantic HTML, ARIA labels where needed
- **Motion:** Respect `prefers-reduced-motion`
- **Text sizing:** Support up to 200% zoom without horizontal scrolling

### Testing Checklist

- [ ] Run axe-core or Lighthouse accessibility audit
- [ ] Test with keyboard only (no mouse)
- [ ] Test with screen reader (VoiceOver / NVDA)
- [ ] Verify color contrast ratios
- [ ] Check focus order matches visual order
- [ ] Verify all images have alt text
- [ ] Test with system font size increased

---

## Directory Structure

```
docs/design/
  README.md                    -- This file (overview)
  02-design-tokens.md          -- Token definitions
  03-figma-structure.md        -- Figma organization guide
  04-consumer-pages.md         -- Consumer-facing page templates
  05-components.md             -- Component inventory
  06-cross-platform.md         -- Cross-platform guidelines
  tokens/
    tokens.json                -- Machine-readable tokens
```

---

## Getting Started

1. Read this overview to understand the system structure
2. Customize `tokens.json` with your brand values
3. Set up your Figma file following `03-figma-structure.md`
4. Build out components per `05-components.md`
5. Design consumer pages using `04-consumer-pages.md` as a template
