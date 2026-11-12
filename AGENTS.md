# AGENTS.md -- Project Context for Coding Agents

> Guidance for any AI coding agent (and human) working in this repo.
> Tool-specific files (`CLAUDE.md`, `.cursorrules`) point here or summarize it.

## Project Summary

SaaS-Viber is a documentation-first SaaS scaffolding repository. It provides:
- Architecture and decision frameworks
- Product and implementation templates
- AI prompt guides and onboarding context
- Launch and readiness checklists

It does **not** ship a full production app by default. Treat this repository as
the operational and documentation backbone for building one.

## First Files to Read

1. `README.md` -- high-level repo purpose and navigation
2. `START_HERE.md` -- onboarding paths for new and advanced builders
3. `docs/INDEX.md` -- master documentation map
4. `docs/ai-agents/KEY_FILES.md` -- assistant-oriented file index
5. `skills/README.md` -- reusable skills; the `taste-skill` is the authority on frontend visual standards

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
docs/testing/       → Testing framework guides (XCTest, Maestro)
decisions/          → Architecture Decision Records
tests/xctest/       → XCTest unit and UI tests (iOS/macOS)
tests/maestro/      → Maestro E2E test flows (cross-platform mobile)
```

## Code Conventions

- **Components**: PascalCase files (`UserProfile.tsx`), one component per file
- **Hooks**: camelCase with `use` prefix (`useAuth.ts`)
- **Utils**: camelCase (`formatCurrency.ts`)
- **Types**: PascalCase interfaces, `type` suffix for type aliases (`UserProfile`, `AuthStateType`)
- **CSS**: Tailwind utility classes; CSS variables for theme values; no inline styles
- **Imports**: Use `@/` path alias for `src/` directory

## Design System Rules

- **Authority on visual polish**: `skills/taste-skill/SKILL.md`. When this file
  and the taste skill disagree on a visual detail, the taste skill wins.
- All colors must use CSS custom properties (not hardcoded hex values)
- Spacing follows a 4px grid: 4, 8, 12, 16, 24, 32, 48, 64
- Border radius uses the `--radius` variable from shadcn/ui
- Animations are defined in `tailwind.config.ts` keyframes section
- Always respect `prefers-reduced-motion` for animations
- Minimum touch target: 44x44px
- Color contrast: WCAG 2.1 AA (4.5:1 for text, 3:1 for UI elements)
- **No emojis** in code, markup, content, or alt text -- use an icon library
  (Radix, Phosphor, Lucide) or clean SVG instead (per the taste skill)
- For a distinctive brand, prefer `Geist`/`Outfit`/`Satoshi` over the
  over-used `Inter`; serif fonts are banned on dashboards/software UIs

## Component Patterns

- Extend shadcn/ui components by wrapping, not modifying the base
- Use Radix UI primitives for accessibility (keyboard nav, ARIA, focus management)
- Loading states use skeleton components, not spinners
- Error states show helpful messages with recovery actions
- All forms use controlled components with validation

## Skills

Reusable, opinionated capabilities live in `skills/` and load automatically when
a task matches. See `skills/README.md` for the catalog. The `taste-skill` is the
canonical source for frontend visual standards -- load it for any UI work.
The `analytics-reports-skill` is the canonical method for GA4 and PostHog
reporting; private ids live in each product's own repo, never here.

## Modern Agentic Workflow

Before substantial feature, refactor, migration, or release work, read `docs/ai-agents/MODERN_AGENTIC_DEVELOPMENT.md`. Use its task packet, capability-aware routing, and verification checklist to keep long-context/tool-using agents focused and reviewable.

## Architecture References

Before making structural decisions, check:
- `docs/architecture/ROLE_ACCESS_CONTROL.md` → User roles and permissions
- `docs/architecture/DOMAIN_MODEL.md` → Data model and relationships
- `docs/architecture/BILLING_MODELS.md` → Subscription and payment patterns
- `docs/design/05-components.md` → Component inventory and variants
- `docs/design/07-animations.md` → Animation system and patterns
- `docs/design/08-theming.md` → Theme system (light/dark/custom)

## Testing References

Before making testing decisions, check:
- `decisions/TESTING_CHOICES.md` → Framework comparison and stack-based recommendations
- `docs/testing/TESTING_FRAMEWORK_GUIDE.md` → Full testing strategy guide
- `docs/testing/XCTEST_SETUP.md` → XCTest integration instructions
- `docs/testing/MAESTRO_SETUP.md` → Maestro installation and flow authoring

## Launch References

Before launch status checks, store submission, release candidates, or billing and
device-testing work, check:
- `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` -> Phase order, gates, red flags
- `docs/guides/DEVICE_TEST_RUNBOOK.md` -> Real-device test matrix and evidence log
- `docs/templates/LAUNCH_TRACKER_TEMPLATE.md` -> One canonical, evidence-based tracker
- `skills/launch-skill/SKILL.md` -> Agent procedure; evidence over documents, human-only gates
- `skills/retention-messaging-skill/SKILL.md` -> Apple cancel-flow retention messages and offers (any app with auto-renewable subscriptions)

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

## Platform independence

No hosted app-builder tooling, hosting, icons, env vars or assets (no builder plugins in `package.json` or lockfiles, no builder config files or asset dumps, no template favicon or placeholder images). CI enforces this with `scripts/check-platform-independence.sh`; run it before pushing. Keep the app portable: standard Vite build, any static or Node host.

## Production hardening reviews

Use `docs/guides/PRODUCTION_HARDENING.md` to classify applicable risks and record evidence in the existing launch tracker. Coordinate active owners; do not infer deployed safety from template checks or change live settings during an audit.

## Working Norms for Agents

- Prefer small, focused documentation edits over broad rewrites.
- Keep links relative and verify target files exist. Run `npm run docs:check`
  (or `python3 scripts/check-docs.py`) before committing doc changes; CI enforces
  it via `.github/workflows/docs-check.yml`.
- Preserve template placeholders unless a task explicitly asks to fill them.
- When adding a new guide/template, register it in `docs/INDEX.md`.
- Keep agent docs synchronized (this file, `docs/ai-agents/*`, and the tool pointers `CLAUDE.md` and `.cursorrules`).
- For visual/frontend decisions, defer to `skills/taste-skill/SKILL.md` (no
  emojis, no default Inter, no serif on dashboards). Record any new repo-wide
  standard in `CHANGELOG.md`.

## Documentation Priorities

When updating docs, keep these sections aligned:
- **Agent onboarding**: `AGENTS.md`, `docs/ai-agents/AGENTS.md`, `CLAUDE.md`, `.cursorrules`
- **Navigation hubs**: `README.md`, `START_HERE.md`, `docs/INDEX.md`
- **Launch playbook**: `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`,
  `docs/guides/DEVICE_TEST_RUNBOOK.md`, `skills/launch-skill/SKILL.md`,
  `skills/retention-messaging-skill/SKILL.md`
- **Mobile readiness**: `docs/guides/IOS_READINESS_CHECKLIST.md`,
  `docs/templates/IOS_READINESS_TEMPLATE.md`,
  `docs/guides/ANDROID_READINESS_CHECKLIST.md`

## Output Style

- Use concise headings and actionable bullets.
- Prefer checklists and tables for operational guides.
- Add clear “when to use this file” context where useful.

## Secrets

Never write a secret into any file: code, config, docs, notes, prompts, submission notes, logs or commit messages. That covers API keys (RevenueCat and Stripe `sk_` keys included), Supabase service role keys and JWT secrets, access tokens (Codemagic, Vercel, GitHub, Expo), deploy keys, and the contents of `.p8` or `.pem` files. Write where the secret lives instead, for example "RevenueCat dashboard > API keys" or "Supabase secrets", and read it from an environment variable. The secret-scan check (`.github/workflows/secret-scan.yml`, rules in `.gitleaks.toml`) fails any pull request that adds one. If a real secret was ever committed, removing it is not enough: say so, so the key gets rotated.
