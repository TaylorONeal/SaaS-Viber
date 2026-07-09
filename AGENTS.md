# AGENTS.md -- Project Context for Codex and Other CLI Agents

> This file is intended for coding agents that read repository-level guidance
> files (for example, Codex-style CLI agents).

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
5. `CLAUDE.md` -- coding conventions and architecture references
6. `skills/README.md` -- reusable skills; the `taste-skill` is the authority on frontend visual standards

## Modern Agentic Workflow

For substantial feature, refactor, migration, or release work, use `docs/ai-agents/MODERN_AGENTIC_DEVELOPMENT.md` as the operating model. It defines task packets, capability-aware routing, verification requirements, and anti-patterns for latest-generation coding agents.

## Working Norms for Agents

- Prefer small, focused documentation edits over broad rewrites.
- Keep links relative and verify target files exist. Run `npm run docs:check`
  (or `python3 scripts/check-docs.py`) before committing doc changes; CI enforces
  it via `.github/workflows/docs-check.yml`.
- Preserve template placeholders unless a task explicitly asks to fill them.
- When adding a new guide/template, register it in `docs/INDEX.md`.
- Keep AI-assistant docs synchronized (`CLAUDE.md`, this file, and `docs/ai-agents/*`).
- For visual/frontend decisions, defer to `skills/taste-skill/SKILL.md` (no
  emojis, no default Inter, no serif on dashboards). Record any new repo-wide
  standard in `CHANGELOG.md`.

## Documentation Priorities

When updating docs, keep these sections aligned:
- **Agent onboarding**: `CLAUDE.md`, `AGENTS.md`, `docs/ai-agents/AGENTS.md`
- **Navigation hubs**: `README.md`, `START_HERE.md`, `docs/INDEX.md`
- **Mobile readiness**: `docs/guides/IOS_READINESS_CHECKLIST.md`,
  `docs/templates/IOS_READINESS_TEMPLATE.md`,
  `docs/guides/ANDROID_READINESS_CHECKLIST.md`

## Output Style

- Use concise headings and actionable bullets.
- Prefer checklists and tables for operational guides.
- Add clear “when to use this file” context where useful.
