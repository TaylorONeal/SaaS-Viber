# Skills

> Reusable [Claude Code skills](https://code.claude.com/docs) that apply across
> every app you build from this template. Drop a skill folder into any repo's
> `skills/` (or your personal `~/.claude/skills/`) and your agent gains a
> repeatable, opinionated capability.

A skill is a self-contained folder with a `SKILL.md` file. The frontmatter
`name` and `description` tell the agent when to load it; the body is the
instruction set. Skills are how you stop re-explaining the same standards in
every new project -- you write the standard once and carry it from app to app.

---

## Available Skills

| Skill | Folder | What It Does | Use When |
|-------|--------|--------------|----------|
| **design-taste-frontend** | `taste-skill/` | Senior UI/UX engineering standards that override default LLM design biases: deterministic typography, color calibration, motion/density dials, performance guardrails, and 100 "AI tell" patterns to avoid. | Building or refining any frontend -- landing pages, dashboards, components. This is the authority on visual polish across all apps. |
| **data-privacy** | `privacy-skill/` | Data minimization and privacy-by-default: collect the minimum, treat sensitive data as radioactive, keep secrets/PII out of the client and out of logs/analytics/LLM prompts, consent and deletion from day one. | Any work touching user data -- auth, storage, queries, tracking, error reporting, or AI features that could carry PII. |
| **mobile-cross-platform** | `mobile-skill/` | Web+native standards: separate marketing site from app, share tokens not components, plan store compliance early, choose web vs in-app billing, and handle mobile viewport/safe-area realities. | Mobile UI, cross-platform, or App Store/Play submission work. |
| **search-indexing** | `search-indexing-skill/` | Get any public site indexed and understood: crawlability pre-flight, Google/Bing/regional consoles, IndexNow, honest sitemaps, robots.txt with AI crawler policy, meta tags, JSON-LD by site type, local profiles, troubleshooting. Agent stops at passwords; logins never stored in repo. | Launch-day SEO, "submit my site", "why isn't it indexed", sitemap/robots/schema work, AI search visibility. |
| **retention-messaging** | `retention-messaging-skill/` | Apple retention messages in the subscription cancel flow: no-code App Store Connect setup, retention offers and eligibility, App Review copy rules, Retention Messaging API (default messages, real-time endpoint, 700 ms budget), entitlement checks, testing and measurement. | Any app with an App Store auto-renewable subscription: launch setup, churn reduction, cancel-flow offers. |
| **analytics-reports** | `analytics-reports-skill/` | The report set a marketer and PLG PM need: GA4 admin baseline, key events, dimensions, custom channel group, five standard Explorations, a Growth library collection, alerts, a Looker Studio portfolio roll-up, and PostHog activation, retention, monetization and issue dashboards. Includes how to brief a browser agent to build it. | Setting up or auditing GA4 or PostHog reporting for one app or a portfolio. |
| **web-to-mobile-launch** | `launch-skill/` | Evidence-based launch workflow: day-one parallel paperwork, billing reconciliation, signing and CI, device testing, submit-day packet, human-only gates, status reporting. | Launch status checks, store submission prep, release candidates, "are we ready to submit". |
| **project-dashboard** | `project-dashboard-skill/` | One live dashboard for a portfolio: a row per product with a stage per platform, a "Waiting on you" list sorted by deadline and split into four buckets (your yes, only you, Cowork runs, agents doing), supporting work, links. Template in `docs/templates/project-dashboard/`. | "Build a dashboard for all my apps", "what's waiting on me", and every status change on a multi-product effort. |

This skill is the **single source of truth for frontend visual standards** in
this template. When other docs (`docs/ai-agents/DESIGN_SYSTEM.md`,
`.cursorrules`, `START_HERE.md`) and the taste skill disagree on a visual
detail -- fonts, emoji usage, card overuse -- the taste skill wins.

---

## How to Use a Skill

**With Claude Code:** Skills in `skills/` (project) or `~/.claude/skills/`
(personal) are discovered automatically. The agent loads a skill when the task
matches its `description`. You can also invoke one directly with `/<skill-name>`.

**With Cursor / other agents:** Paste the contents of the relevant `SKILL.md`
into your context, or reference it in `.cursorrules`.

**Tuning a skill:** The taste skill exposes dials (DESIGN_VARIANCE,
MOTION_INTENSITY, VISUAL_DENSITY). Override them per project in your prompt --
e.g. "use the taste skill, but set VISUAL_DENSITY to 8 for this analytics
dashboard." Do not hardcode per-project values into the shared skill file.

---

## Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md`.
2. Add YAML frontmatter:
   ```yaml
   ---
   name: your-skill-name
   description: One sentence on what it does and exactly when the agent should load it.
   ---
   ```
3. Write the instruction body. Keep rules concrete and testable ("use
   `min-h-[100dvh]`, never `h-screen`") rather than vague ("make it responsive").
4. Register it in the table above.
5. If it changes how agents work repo-wide, cross-link it from `CLAUDE.md`,
   `AGENTS.md`, and `docs/INDEX.md`.

---

## Why Skills Belong in the Template

Every app you ship teaches you something reusable. A lesson that is just prose
in `LESSONS_LEARNED.md` informs you; a lesson encoded as a skill *enforces*
itself on every future generation. When a pattern proves itself across two or
more apps, consider promoting it from a lesson to a skill. See
`docs/ai-agents/LESSONS_LEARNED.md` -> "Harvesting Lessons Across Apps."
