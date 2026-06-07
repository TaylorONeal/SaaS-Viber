# Changelog

> Version history for the **SaaS-Viber template itself** -- not for the app you
> build from it. When you pull updated concepts from upstream into an existing
> app, this is how you tell what is new since you last synced.

This project follows [Keep a Changelog](https://keepachangelog.com/) conventions
and uses date-based template versions (`Template vMAJOR.MINOR`).

---

## [Unreleased]

### Added
- `skills/README.md` -- catalog of reusable Claude Code skills, how to use and
  add them, surfaced from README, START_HERE, CLAUDE.md, AGENTS.md, and INDEX.
- `docs/architecture/PromptGuide-Architecture.md` -- completes the prompt-guide
  set (was referenced from INDEX but missing).
- `docs/ai-agents/LESSONS_LEARNED.md`: 24 new generalizable principles across
  Working With AI Agents, Mobile & Cross-Platform, Privacy & Sensitive Data,
  Product & Scope, and Performance & Operations, plus a "Harvesting Lessons
  Across Apps" workflow for promoting a per-app lesson into the shared template.
- `opensource/CODE_OF_CONDUCT.md`, `opensource/SECURITY.md`,
  `opensource/GOVERNANCE.md`, `opensource/CONTRIBUTORS.md` -- the governance
  templates the opensource README and CONTRIBUTING advertised but were missing.
- This `CHANGELOG.md`.

### Changed
- Designated `skills/taste-skill/SKILL.md` as the single authority on frontend
  visual standards. Reconciled the prior contradictions: `START_HERE.md` and
  `DESIGN_SYSTEM.md` no longer present Inter as the default brand font, and the
  no-emoji rule is now stated in `CLAUDE.md` and `.cursorrules`.

### Fixed
- `docs/INDEX.md`: removed dead links to `architecture/DEMO_SEPARATION.md` and
  the missing architecture prompt guide; corrected `prds/` -> `prd/`; clarified
  that `decisions/` lives at the repo root, not under `docs/`.
- Corrected `docs/prds/` -> `docs/prd/` in `SETUP_GUIDE.md` and `docs/FAQ.md`.
- Fixed broken `../ARCHITECTURE.md` -> `../../ARCHITECTURE.md` links in
  `docs/prd/platform-overview.md` and `docs/prd/PRD-001-example.md`.
- De-linked the dangling example PRD reference in `PRD-IMPLEMENTATION-AUDIT.md`.
- Full internal-link audit: every local markdown link now resolves except the
  intentional `[PRD-XXX]` fill-in placeholders.

---

## [Template v1.0]

Initial public template: decision frameworks, architecture/design/PRD/workflow
docs, AI-agent onboarding (CLAUDE.md, AGENTS.md, .cursorrules), mobile-readiness
checklists, testing setup (XCTest, Maestro), and the `taste-skill`.

---

## How to Version This Template

- **MAJOR** -- a structural change downstream apps must reconcile (folder moves,
  renamed canonical files, a new required agent-instruction file).
- **MINOR** -- additive: a new guide, skill, decision record, or checklist that
  does not break existing references.
- Move entries out of `[Unreleased]` and stamp a version + date when you cut a
  template release. Keep entries written for the *adopter* -- "what changed and
  what you need to do," not raw commit messages.
