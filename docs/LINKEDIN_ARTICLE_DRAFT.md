# LinkedIn Article: SaaS-Viber
## Draft Outline + Content

---

## TITLE OPTIONS (pick one)

1. "Everything Your App Needs (That You Forgot to Plan For)"
2. "I Mapped Out Everything a SaaS App Needs. Here's the Repo."
3. "The 96-File Head Start: What Every SaaS Needs Before You Write a Line of Code"
4. "Stop Vibe Coding Without a Map"

---

## HOOK (first 3 lines — what shows before "see more")

> Most people start building their app with a blank repo and a prompt.
>
> Then 3 weeks later they realize they forgot: role-based access, dunning flows, dark mode, GDPR, onboarding emails, error states, loading skeletons, and 50 other things they'll now have to retrofit.
>
> I built a free template that maps ALL of it out before you write a line of code.

---

## SECTION 1: The Problem
**~150 words. No visual.**

The gap isn't coding ability — AI tools have largely solved that. The gap is *knowing what to build*.

A first-time builder doesn't know they need:
- A dunning flow when payments fail
- Row-level security on their database
- A subscription state machine (free → trialing → active → past_due → canceled → expired)
- Empty states, error states, and loading skeletons for every page
- An onboarding email sequence that nudges users back if they don't complete setup
- WCAG 2.1 AA contrast ratios on every text element
- A theme system that doesn't break when you add dark mode later

An experienced builder *does* know — but still spends days setting up the same scaffolding every time.

SaaS-Viber is neither code nor boilerplate. It's the **thinking layer** — 96 files of decision frameworks, architecture patterns, design systems, and prompt guides that sit beneath your code and make sure nothing falls through the cracks.

---

## SECTION 2: What's Actually In It
**~200 words. VISUAL: File map screenshot.**

**[VISUAL 1 — Screenshot of this file tree]**

```
SaaS-Viber/
│
├── START_HERE.md              ← Two paths: beginner or expert
├── CLAUDE.md                  ← Auto-loads in Claude Code
├── .cursorrules               ← Auto-loads in Cursor
│
├── decisions/                 ← Choose your stack
│   ├── BACKEND_CHOICES.md
│   ├── AUTH_CHOICES.md
│   ├── PAYMENT_CHOICES.md
│   └── PLATFORM_CHOICES.md
│
├── docs/
│   ├── design/                ← For designers
│   ├── architecture/          ← For developers
│   ├── developer/             ← Setup + patterns
│   ├── guides/                ← Checklists + training path
│   ├── ai-agents/             ← Prompt templates
│   ├── prd/                   ← Product requirements
│   └── workflows/             ← User flow templates
│
└── src/                       ← Empty — YOUR code goes here
```

This isn't a framework. There's no `App.tsx` in the box. You generate the code with your AI tool of choice. SaaS-Viber gives you the knowledge, structure, and prompts to generate it *well*.

It covers four roles:
- **Designer**: tokens, animations, theming, visual patterns
- **Developer**: architecture, domain model, RBAC, billing
- **Product Manager**: PRD templates, workflow maps, checklists
- **End User**: onboarding, empty states, error recovery, accessibility

---

## SECTION 3: Decisions First, Code Second
**~200 words. VISUAL: Backend choices matrix.**

Most people pick their backend based on a tweet. SaaS-Viber gives you a decision matrix.

**[VISUAL 2 — Screenshot of this table from decisions/BACKEND_CHOICES.md]**

```
| Factor             | Supabase    | Firebase     | AWS Amplify  | PocketBase   |
|--------------------|-------------|--------------|--------------|--------------|
| Database type      | PostgreSQL  | Firestore    | DynamoDB     | SQLite       |
| Auth built-in      | Yes         | Yes          | Yes (Cognito)| Yes          |
| Real-time          | Yes         | Yes          | Yes (AppSync)| Yes (SSE)    |
| Row-level security | Native      | Rules        | IAM + VTL    | No           |
| Self-host option   | Yes         | No           | No           | Yes          |
| Vendor lock-in     | Low         | High         | High         | None         |
| Free tier          | Generous    | Generous     | Generous     | Free         |
| Learning curve     | Low         | Medium       | High         | Very Low     |
```

There are five decision docs — backend, auth, payments, hosting, and deployment. Each one:
- Compares 5-7 real options
- Lists honest pros AND cons
- Shows cost progression from free tier to scale
- Says "choose this if..." with specific scenarios

No opinions disguised as facts. Just structured frameworks so you (or your AI agent) can make an informed choice in 20 minutes instead of 2 weeks.

---

## SECTION 4: Architecture That Covers the Whole Stack
**~250 words. VISUALS: Role hierarchy + Domain model layers + Subscription state machine.**

Here's what most solo builders skip. SaaS-Viber doesn't let you.

**[VISUAL 3 — Role hierarchy diagram]**

```
┌─────────────────────────────────────┐
│         PLATFORM ADMIN              │  ← Internal team only
├─────────────────────────────────────┤
│         ORG ADMIN                   │  ← Full org access
├─────────────────────────────────────┤
│         ORG MANAGER                 │  ← Operations, limited settings
├─────────────────────────────────────┤
│         ORG MEMBER                  │  ← Standard user
├─────────────────────────────────────┤
│         ORG VIEWER                  │  ← Read-only
├─────────────────────────────────────┤
│         PUBLIC                      │  ← Marketing pages only
└─────────────────────────────────────┘
```

This comes with a full feature access matrix — who can create, edit, delete, and view every entity across roles. Including billing permissions, org management, and platform admin tools.

**[VISUAL 4 — Domain model layers]**

```
┌─────────────────────────────────────────────────────────┐
│                     IDENTITY LAYER                      │
│  User, Organization, Membership, Role, Permission       │
├─────────────────────────────────────────────────────────┤
│                     DOMAIN LAYER                        │
│  [Your core entities go here]                           │
├─────────────────────────────────────────────────────────┤
│                     OPERATIONS LAYER                    │
│  Subscription, Payment, Invoice, Notification           │
├─────────────────────────────────────────────────────────┤
│                     OBSERVABILITY LAYER                 │
│  Audit Log, Event, Analytics, Error Log                 │
└─────────────────────────────────────────────────────────┘
```

Four layers. Every SaaS has them. Most people only build the domain layer and bolt on the rest later. This template makes you think about identity, operations, and observability from day one.

**And for billing**, there's a complete subscription state machine:

> Free → Trialing → Active → Past Due → Canceled → Expired

With dunning flows (what happens when a payment fails), retry schedules, and the exact emails to send at each stage.

---

## SECTION 5: Design That Goes Beyond "Make It Pretty"
**~200 words. VISUALS: Dashboard layout + Theme flow + Animation system.**

SaaS-Viber ships a complete design system — not Figma files, but the architecture *behind* them.

**[VISUAL 5 — Dashboard layout ASCII]**

```
┌──────────────────────────────────────────────┐
│  Header (logo, search, user menu, theme)     │
├────────┬─────────────────────────────────────┤
│        │                                     │
│ Side-  │  Main Content Area                  │
│ bar    │  ┌─────────┐ ┌─────────┐            │
│        │  │ Stat    │ │ Stat    │            │
│        │  │ Card    │ │ Card    │            │
│        │  └─────────┘ └─────────┘            │
│        │  ┌───────────────────────┐          │
│        │  │ Data Table / Content  │          │
│        │  └───────────────────────┘          │
└────────┴─────────────────────────────────────┘
```

There are ASCII diagrams for dashboard, settings, marketing/landing, auth pages, header/footer patterns, and onboarding flows. Every layout includes pixel specs (sidebar width, header height, content padding, grid breakpoints).

**[VISUAL 6 — Theme system flow]**

```
tokens.json (source of truth)
    ↓
globals.css (CSS custom properties)
    ↓
tailwind.config.ts (Tailwind mapping)
    ↓
Components (bg-primary, text-foreground)
    ↓
Theme toggle (.dark class on <html>)
```

Plus an animation system with 20+ keyframe definitions, a "which animation for which scenario" decision guide, reduced-motion accessibility, and staggered animation patterns.

**The design docs answer "where do I edit this?" for every visual property** — colors, fonts, spacing, radius, shadows, animations, and themes.

---

## SECTION 6: The Training Path (Beginners Start Here)
**~200 words. VISUAL: Phase timeline with self-assessment checkpoints.**

If you've never built a SaaS before, the training path is your roadmap:

**[VISUAL 7 — Phase summary with checkpoints]**

```
PHASE 1: Foundation (1-2 weeks)
  Decisions, infrastructure, brand identity
  ✓ Can you deploy with one command?
  ✓ Is auth working?
  ✓ Could a new dev run locally in <15 min?

PHASE 2: Core Product (2-4 weeks)
  The features someone would pay for
  ✓ Can a user get value in under 5 minutes?
  ✓ Can they pay you money?
  ✓ Have you shown it to someone who isn't you?

PHASE 3: Growth (ongoing)
  Analytics, SEO, email, content
  ✓ Do you know your weekly active users?
  ✓ Can you see where users drop off?
  ✓ Is one channel bringing users without manual effort?

PHASE 4: Scale (ongoing)
  Reliability, performance, team processes
  ✓ What's your uptime percentage?
  ✓ Can someone else ship without you?
  ✓ Have you tested your backup restore?
```

Each phase includes specific tasks, docs to read, prompt templates to use, and a self-assessment checkpoint. You don't move to Phase 2 until Phase 1 checks all pass.

---

## SECTION 7: For the AI-Native Builder
**~150 words. VISUAL: The first prompt from START_HERE.md.**

SaaS-Viber is designed for agentic coding. When you clone the repo:

- **Claude Code** auto-loads `CLAUDE.md` with full project context
- **Cursor** auto-loads `.cursorrules` with conventions and patterns
- There are prompt guides for every major task (PRDs, components, debugging, migrations, security reviews)

**[VISUAL 8 — The scaffolding prompt from START_HERE.md]**

```
I'm building a SaaS app called [YOUR_APP_NAME].
It's for [WHO] to [DO WHAT].

I've chosen:
- Backend: [Supabase / Firebase / other]
- Auth: [Supabase Auth / Clerk / other]
- Payments: [Stripe / Lemon Squeezy / other]
- Hosting: [Vercel / Netlify / other]

Please scaffold the initial app:
1. Install all required dependencies
2. Create src/main.tsx with React entry point
3. Create src/App.tsx with a router
4. Create globals.css with my brand colors
5. Create landing, login, and dashboard pages
6. Create a shared layout with header and sidebar
```

That's your first 5 minutes. Paste this into your AI tool with the repo context and you have a running app.

---

## SECTION 8: How to Use It (Three Options)
**~150 words. No visual — this is the CTA.**

**Option 1 — The Full Clone** (recommended)
```bash
git clone https://github.com/TaylorONeal/SaaS-Viber.git
cd SaaS-Viber
```
Open `START_HERE.md`. Pick your path. Follow the prompts.

**Option 2 — The AI Shortcut**
Paste the repo link into Claude Code, Cursor, or ChatGPT and say:

> "Read this repo. It's a SaaS planning template. I'm building [YOUR APP]. Use the decision frameworks, architecture patterns, and design system as context for everything you generate."

Your AI agent now has 96 files of institutional knowledge.

**Option 3 — The Reference**
Don't clone anything. Just read the `decisions/` folder when you're stuck on a choice. Bookmark the checklists. Steal the subscription state machine diagram. Use what's useful.

---

## SECTION 9: Closing
**~100 words. No visual.**

Every SaaS needs the same boring stuff — auth, roles, payments, dunning, onboarding, error states, dark mode, GDPR compliance, loading skeletons, email sequences, and 40 other things you'll forget until a user complains.

SaaS-Viber doesn't write your code. It makes sure you and your AI tools *know what code to write*.

It's free. It's open source. It's 96 files that took months of SaaS experience to compile.

Link in comments. Star it if it's useful.

---

## POST-ARTICLE NOTES

### Recommended Visual Strategy

For LinkedIn, the best-performing visuals are:
1. **Screenshot of the file tree** (Section 2) — shows scope instantly
2. **Backend decision matrix** (Section 3) — people save these
3. **Role hierarchy + domain layers** (Section 4) — architecture porn
4. **Dashboard ASCII layout** (Section 5) — surprisingly eye-catching
5. **Training path phases** (Section 6) — structured progression
6. **The first prompt** (Section 7) — actionable and copy-pasteable

### Carousel Option

If posting as a LinkedIn carousel (PDF), each slide could be:
1. Title: "Everything Your App Needs (That You Forgot)"
2. The problem (list of things people forget)
3. File tree (the scope)
4. Backend decision matrix
5. Role hierarchy
6. Domain model layers
7. Subscription state machine
8. Dashboard layout
9. Training path phases
10. The first prompt
11. CTA: link to repo

### Hashtags

#SaaS #BuildInPublic #VibeCoding #IndieHackers #AI #ClaudeCode #Cursor #OpenSource #StartupTools #SoftwareArchitecture

### Who to Tag

- Agentic coding tool accounts (Cursor, Anthropic, GitHub Copilot)
- IndieHackers, ProductHunt communities
- SaaS builders with large followings
