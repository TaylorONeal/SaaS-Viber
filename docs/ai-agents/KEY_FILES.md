# Key Files Index

> Maintain this index so AI assistants (and new developers) can quickly find
> the right file for any task. Update it whenever you add or move significant files.

---

## How to Use This Index

1. **Starting a new AI session?** Share this file first for project orientation.
2. **Working on a feature?** Find related files by category below.
3. **Adding a new file?** Add it to the appropriate section with a clear purpose.

---

## Configuration

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `package.json` | Dependencies, scripts, project metadata | Starting any session, adding dependencies |
| `tsconfig.json` | TypeScript compiler options, path aliases | Type errors, import issues |
| `next.config.js` | Next.js configuration, redirects, headers | Routing issues, middleware, env vars |
| `.env.example` | Environment variable template | Setting up environments, adding new env vars |
| `tailwind.config.ts` | Tailwind theme, plugins, content paths | Styling, custom utilities, design tokens |
| `postcss.config.js` | PostCSS plugins | CSS processing issues |
| `eslint.config.js` | Linting rules and overrides | Lint errors, adding rules |
| `prettier.config.js` | Code formatting rules | Formatting issues |
| `vitest.config.ts` | Test runner configuration | Test setup, coverage config |

## Architecture

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `src/app/layout.tsx` | Root layout, providers, global setup | App-wide changes, provider additions |
| `src/middleware.ts` | Auth middleware, route protection | Auth flow, protected routes |
| `src/lib/supabase/client.ts` | Supabase browser client | Client-side data operations |
| `src/lib/supabase/server.ts` | Supabase server client | Server-side data operations |
| `src/lib/supabase/admin.ts` | Supabase admin/service role client | Admin operations, webhooks |
| `[YOUR_PATH]/providers.tsx` | Context providers wrapper | Adding new providers |
| `[YOUR_PATH]/api/` | API route handlers | Creating new endpoints |

## Database

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `supabase/migrations/` | Database migration files | Schema changes, new tables |
| `supabase/seed.sql` | Seed data for development | Setting up dev environment |
| `src/types/database.ts` | Generated database types | After any schema change |
| `supabase/config.toml` | Local Supabase configuration | Database config, auth settings |
| `[YOUR_PATH]/schema.prisma` | Prisma schema (if using Prisma) | Data model reference |

## Authentication

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `[YOUR_PATH]/auth/callback/route.ts` | OAuth callback handler | Auth flow issues |
| `[YOUR_PATH]/auth/login/page.tsx` | Login page | Auth UI changes |
| `[YOUR_PATH]/auth/signup/page.tsx` | Registration page | Signup flow changes |
| `src/lib/auth/helpers.ts` | Auth utility functions | Session checks, role verification |

## Payments / Billing

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `[YOUR_PATH]/stripe/webhook/route.ts` | Stripe webhook handler | Payment event processing |
| `src/lib/stripe/client.ts` | Stripe client configuration | Payment operations |
| `src/lib/stripe/plans.ts` | Plan/price definitions | Pricing changes |
| `[YOUR_PATH]/billing/page.tsx` | Billing management page | Billing UI changes |

## UI Components

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `src/components/ui/` | Base UI components (shadcn/ui) | Building any UI |
| `src/components/shared/` | Shared/reusable components | Cross-feature components |
| `src/components/layouts/` | Layout components | Page structure changes |
| `src/components/forms/` | Form components and patterns | Building forms |
| `src/styles/globals.css` | Global styles, CSS variables | Theme, design tokens |

## Domain / Business Logic

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `src/lib/[domain]/` | Core business logic | Feature-specific work |
| `src/hooks/` | Custom React hooks | Reusable stateful logic |
| `src/utils/` | Pure utility functions | Helper functions |
| `src/types/` | TypeScript type definitions | Type definitions, interfaces |
| `src/constants/` | App-wide constants | Magic values, enums |

## Deployment

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `Dockerfile` | Container definition | Deployment, CI/CD |
| `docker-compose.yml` | Local multi-service setup | Local development |
| `.github/workflows/` | CI/CD pipeline definitions | Build/deploy changes |
| `vercel.json` | Vercel deployment config | Deployment settings |

## Documentation

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `docs/ai-agents/AGENTS.md` | AI assistant onboarding | Starting AI sessions |
| `docs/ai-agents/DESIGN_SYSTEM.md` | Design system reference | UI/styling work |
| `docs/ai-agents/LESSONS_LEARNED.md` | Known pitfalls | Avoiding repeat mistakes |
| `docs/design/02-design-tokens.md` | Design token definitions | Theme customization |
| `docs/workflows/` | Operational workflow docs | Process reference |

## Tests

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `src/__tests__/` | Unit and integration tests | Writing/running tests |
| `e2e/` | End-to-end test specs | E2E test scenarios |
| `src/test/setup.ts` | Test environment setup | Test configuration |
| `src/test/factories/` | Test data factories | Generating test data |
| `src/test/mocks/` | Mock definitions | Mocking services |

---

## Maintenance Checklist

- [ ] Review this index weekly during active development
- [ ] Add new files as they are created
- [ ] Remove references to deleted files
- [ ] Update paths after any directory restructuring
- [ ] Verify all `[YOUR_PATH]` placeholders are filled in
