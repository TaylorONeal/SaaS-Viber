# CLAUDE.md -- Project Context for Claude Code

> This file is automatically loaded by Claude Code at the start of every session.
> It gives the AI assistant the context it needs to work effectively in this repo.

## Project Overview

This is a SaaS application built with React + TypeScript + Vite + Tailwind CSS + shadcn/ui.

- **Stage**: Early development (scaffolding from SaaS-Viber template)
- **UI Framework**: React with TypeScript
- **Styling**: Tailwind CSS with CSS custom properties for theming
- **Component Library**: shadcn/ui (Radix UI primitives)
- **Build Tool**: Vite
- **Design Tokens**: `docs/design/tokens/tokens.json`

## Key Directories

```
src/components/     → UI components (shadcn/ui base in ui/, custom in feature dirs)
src/pages/          → Route-level page components
src/hooks/          → Custom React hooks
src/lib/            → Utilities, helpers, API clients
src/contexts/       → React context providers
src/types/          → Shared TypeScript type definitions
src/styles/         → Global CSS, theme variables
src/data/           → Mock data, fixtures, constants
docs/               → Architecture docs, design system, guides
decisions/          → Architecture Decision Records
```

## Code Conventions

- **Components**: PascalCase files (`UserProfile.tsx`), one component per file
- **Hooks**: camelCase with `use` prefix (`useAuth.ts`)
- **Utils**: camelCase (`formatCurrency.ts`)
- **Types**: PascalCase interfaces, `type` suffix for type aliases (`UserProfile`, `AuthStateType`)
- **CSS**: Tailwind utility classes; CSS variables for theme values; no inline styles
- **Imports**: Use `@/` path alias for `src/` directory

## Design System Rules

- All colors must use CSS custom properties (not hardcoded hex values)
- Spacing follows a 4px grid: 4, 8, 12, 16, 24, 32, 48, 64
- Border radius uses the `--radius` variable from shadcn/ui
- Animations are defined in `tailwind.config.ts` keyframes section
- Always respect `prefers-reduced-motion` for animations
- Minimum touch target: 44x44px
- Color contrast: WCAG 2.1 AA (4.5:1 for text, 3:1 for UI elements)

## Component Patterns

- Extend shadcn/ui components by wrapping, not modifying the base
- Use Radix UI primitives for accessibility (keyboard nav, ARIA, focus management)
- Loading states use skeleton components, not spinners
- Error states show helpful messages with recovery actions
- All forms use controlled components with validation

## Architecture References

Before making structural decisions, check:
- `docs/architecture/ROLE_ACCESS_CONTROL.md` → User roles and permissions
- `docs/architecture/DOMAIN_MODEL.md` → Data model and relationships
- `docs/architecture/BILLING_MODELS.md` → Subscription and payment patterns
- `docs/design/05-components.md` → Component inventory and variants
- `docs/design/07-animations.md` → Animation system and patterns
- `docs/design/08-theming.md` → Theme system (light/dark/custom)

## Common Tasks

### Adding a new page
1. Create component in `src/pages/`
2. Add route in the router configuration
3. Add navigation entry if needed
4. Follow existing page patterns for layout, loading, and error states

### Adding a new component
1. Check `docs/design/05-components.md` for the spec
2. If it's a shadcn/ui component: install via CLI, customize via props/className
3. If it's custom: create in `src/components/[category]/`
4. Include TypeScript props interface, accessibility attributes, responsive behavior

### Changing theme/brand
1. Update `docs/design/tokens/tokens.json` with new values
2. Update CSS variables in `src/styles/globals.css`
3. Verify `tailwind.config.ts` extends match token values
4. Test both light and dark modes

## What NOT to Do

- Don't hardcode colors -- use CSS variables or Tailwind theme classes
- Don't skip TypeScript types -- no `any` unless truly unavoidable
- Don't add dependencies without checking if shadcn/ui or existing utils cover the need
- Don't create files outside the established directory structure
- Don't modify shadcn/ui base components in `src/components/ui/` directly
