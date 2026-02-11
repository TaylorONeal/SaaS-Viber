# Start Here

> You cloned the repo. Now what? Pick your path.

---

## Choose Your Path

### Path A: New to Agentic Coding

You're building a SaaS and want AI tools (Claude Code, Cursor, Copilot) to do most of the heavy lifting. You may be new to coding, or experienced but new to AI-assisted development.

**Your first 30 minutes:**

1. **Read the decisions** (15 min) -- Open the `decisions/` folder and read through:
   - `BACKEND_CHOICES.md` -- Pick your backend (Supabase recommended for solo builders)
   - `AUTH_CHOICES.md` -- Pick your auth provider
   - `PAYMENT_CHOICES.md` -- Pick your payment processor
   - `PLATFORM_CHOICES.md` -- Pick where to host

2. **Fill in your identity** (10 min) -- Open `docs/guides/BRANDING_GUIDE.md` and complete the Quick Setup section. At minimum, decide:
   - Product name
   - Primary brand color
   - One font (Inter is a safe default)

3. **Start your first AI session** (5 min) -- Copy the prompt below into Claude Code, Cursor, or your AI tool of choice:

```
I'm building a SaaS app called [YOUR_APP_NAME].
It's for [WHO] to [DO WHAT].

I've chosen:
- Backend: [Supabase / Firebase / other]
- Auth: [Supabase Auth / Clerk / other]
- Payments: [Stripe / Lemon Squeezy / other]
- Hosting: [Vercel / Netlify / other]

My brand color is [COLOR]. I'm using React + TypeScript + Tailwind + shadcn/ui.

Please scaffold the initial app:
1. Install all required dependencies in package.json
2. Create src/main.tsx with React entry point
3. Create src/App.tsx with a router (React Router)
4. Create src/styles/globals.css with my brand colors as CSS variables
5. Create a landing page at src/pages/Landing.tsx
6. Create a login page at src/pages/Login.tsx
7. Create a dashboard page at src/pages/Dashboard.tsx
8. Create a shared layout with header and sidebar at src/components/layout/

Use the design tokens from docs/design/tokens/tokens.json as a reference.
Follow the component patterns in docs/design/05-components.md.
```

4. **Follow the training path** -- After your first scaffolding session, open `docs/guides/TRAINING_PATH.md` and work through Phase 1 systematically.

---

### Path B: Experienced Builder

You know your stack, you've built SaaS before, and you want to move fast. Here's what SaaS-Viber gives you that you'd otherwise build from scratch.

**Your first 10 minutes:**

1. **Grab what you need:**

| What You Need | Where It Is |
|---|---|
| Architecture patterns (RBAC, billing, domain model) | `docs/architecture/` |
| Design system + tokens | `docs/design/` + `tokens/tokens.json` |
| Component inventory | `docs/design/05-components.md` |
| Animation system | `docs/design/07-animations.md` |
| Theming (light/dark/custom) | `docs/design/08-theming.md` |
| Visual patterns catalog | `docs/design/09-visual-inventory.md` |
| Roadmap + feature reference | `docs/roadmap/` (ROADMAP.md + FEATURE_REFERENCE.md) |
| Analytics platform choices | `decisions/ANALYTICS_CHOICES.md` |
| Analytics setup (PostHog + GA4) | `docs/developer/analytics-setup.md` |
| Admin dashboard + growth KPIs | `docs/architecture/ANALYTICS_ARCHITECTURE.md` |
| Event tracking plan (50+ events) | `docs/developer/tracking-plan.md` |
| PRD templates + tracker | `docs/prd/` (PRD-TEMPLATE.md + prd-tracker.json) |
| Prompt templates for AI coding | `docs/ai-agents/PromptGuide-AI-Development.md` |
| GDPR/compliance checklist | `docs/architecture/AUDIT_COMPLIANCE.md` |
| Launch checklist | `docs/guides/LAUNCH_CHECKLIST.md` |

2. **Set up your agent:**
   - Claude Code users: `CLAUDE.md` is in the repo root -- it auto-loads context
   - Cursor users: `.cursorrules` is in the repo root -- it auto-loads rules
   - Other tools: copy the context from `docs/ai-agents/AGENTS.md` into your first prompt

3. **Scaffold and go:**

```
Read the following files for context:
- CLAUDE.md (or .cursorrules)
- docs/design/tokens/tokens.json
- docs/architecture/DOMAIN_MODEL.md
- docs/architecture/ROLE_ACCESS_CONTROL.md

Then scaffold my app with:
- Full dependency installation
- React + TypeScript + Vite + Tailwind + shadcn/ui
- Auth flow (sign up, sign in, forgot password, email verification)
- Protected route wrapper
- Dashboard layout with sidebar navigation
- Settings page with profile and billing sections
- Proper error boundaries and loading states
```

---

## What NOT to Expect

SaaS-Viber is **not** a starter kit with pre-built components. There is no `src/App.tsx` in the box. Here's why:

- **Pre-built code locks you into one stack.** The decisions/ folder helps you pick YOUR stack.
- **AI tools generate code faster than you can read boilerplate.** The prompt guides help you generate exactly what you need.
- **Documentation ages better than code.** The architecture docs, checklists, and design tokens stay relevant regardless of which React version or framework you use.

**You generate the code. SaaS-Viber gives you the knowledge, structure, and prompts to generate it well.**

---

## File Map for New Users

```
SaaS-Viber/
│
├── START_HERE.md              ← You are here
├── CLAUDE.md                  ← Auto-loaded by Claude Code
├── .cursorrules               ← Auto-loaded by Cursor
│
├── decisions/                 ← Read FIRST: choose your stack
│   ├── BACKEND_CHOICES.md
│   ├── AUTH_CHOICES.md
│   ├── PAYMENT_CHOICES.md
│   ├── PLATFORM_CHOICES.md
│   ├── DEPLOYMENT_CHOICES.md
│   └── ANALYTICS_CHOICES.md   ← PostHog vs GA4 vs Mixpanel vs Amplitude
│
├── docs/
│   ├── design/                ← For designers: tokens, animations, themes
│   │   ├── README.md          ← Design system overview
│   │   ├── 02-design-tokens.md
│   │   ├── 03-figma-structure.md
│   │   ├── 04-consumer-pages.md
│   │   ├── 05-components.md
│   │   ├── 06-cross-platform.md
│   │   ├── 07-animations.md   ← Animation system + where to edit
│   │   ├── 08-theming.md      ← Theme config (light/dark/custom)
│   │   ├── 09-visual-inventory.md  ← Visual patterns catalog
│   │   └── tokens/tokens.json ← Machine-readable design tokens
│   │
│   ├── architecture/          ← For developers: system design
│   ├── developer/             ← For developers: setup + patterns
│   │   ├── analytics-setup.md ← PostHog + GA4 implementation guide
│   │   └── tracking-plan.md   ← Event registry + funnels
│   ├── guides/                ← For everyone: checklists + paths
│   │   └── TRAINING_PATH.md   ← Phase-by-phase build guide
│   ├── ai-agents/             ← For AI tools: prompts + context
│   ├── prd/                   ← For product: requirements templates
│   └── workflows/             ← For product: user flow templates
│
├── src/                       ← Empty -- YOUR code goes here
│   ├── components/
│   ├── contexts/
│   ├── data/
│   ├── hooks/
│   ├── lib/
│   ├── pages/
│   ├── styles/
│   └── types/
│
├── tailwind.config.ts         ← Pre-configured with shadcn/ui + animations
├── vite.config.ts             ← Vite dev server config
├── tsconfig.json              ← TypeScript config
└── package.json               ← Add your dependencies here
```

---

## Designer Quick Reference

If you're primarily working on the visual layer:

| Task | File to Edit |
|---|---|
| Change brand colors | `docs/design/tokens/tokens.json` → then `tailwind.config.ts` |
| Change fonts | `docs/design/02-design-tokens.md` → Typography section |
| Change spacing scale | `docs/design/tokens/tokens.json` → spacing section |
| Change border radius | `docs/design/tokens/tokens.json` → borderRadius section |
| Add/edit animations | `docs/design/07-animations.md` → then `tailwind.config.ts` keyframes |
| Switch light/dark theme | `docs/design/08-theming.md` → CSS variables section |
| Add a new visual pattern | `docs/design/09-visual-inventory.md` |
| Review component list | `docs/design/05-components.md` |
| Set up Figma | `docs/design/03-figma-structure.md` |
| Cross-platform guidelines | `docs/design/06-cross-platform.md` |

---

## After Your First Session

- [ ] Dependencies installed and `npm run dev` shows something in the browser
- [ ] At least one page renders with your brand colors
- [ ] You've committed your initial scaffold to git
- [ ] You've read `docs/guides/TRAINING_PATH.md` Phase 1
- [ ] You know where to find what you need (this file map)

**Next:** Work through the Training Path phases sequentially. Phase 1 is decisions and infrastructure. Phase 2 is your core product. Don't skip ahead.
