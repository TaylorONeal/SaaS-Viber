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
