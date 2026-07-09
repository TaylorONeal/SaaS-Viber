# Modern Agentic Development Playbook

> **When to use this file:** Use this playbook before handing a large feature, refactor, migration, or release task to a modern coding agent. It updates SaaS-Viber for frontier-model workflows where agents can inspect a codebase, edit many files, run tools, verify results, and iterate.

_Last reviewed: 2026-07-09_

---

## What Changed in Modern AI Coding

Current frontier coding models are no longer just autocomplete or chat helpers. Official model and product documentation now emphasizes:

- **Longer working context** for reading more of a repository before acting.
- **Stronger tool use** for shell commands, file edits, browser/computer-use workflows, and external integrations.
- **Agentic planning and execution** for multi-step coding tasks that require codebase navigation, implementation, testing, and repair loops.
- **Reusable skills and rules** so teams can package specialized workflows instead of repasting long prompts.
- **Reasoning controls** so teams can trade latency and cost against deeper planning for complex tasks.

Sources to re-check when refreshing this guide:

| Vendor / tool | Primary reference |
|---|---|
| OpenAI GPT-5.6 / latest model family | <https://openai.com/index/gpt-5-6/> and <https://developers.openai.com/api/docs/guides/latest-model> |
| Claude Code | <https://docs.anthropic.com/en/docs/claude-code/overview> and <https://www.anthropic.com/engineering/claude-code-best-practices> |
| Cursor agent rules and skills | <https://cursor.com/docs/rules> and <https://cursor.com/docs/skills> |

Treat these capabilities as leverage, not magic. The repository still needs clear decision records, acceptance criteria, tests, and small reviewable changes.

---

## The SaaS-Viber Agent Operating Model

Use this operating model for substantial work.

| Phase | Human provides | Agent does | Required output |
|---|---|---|---|
| 1. Frame | Product goal, constraints, target users, stack choices | Reads repo maps and asks only blocking questions | Written implementation plan |
| 2. Ground | Relevant docs, PRD, domain model, screenshots, failing tests | Locates files, identifies missing decisions, confirms assumptions | File list and risk list |
| 3. Build | Approval to edit a focused scope | Implements smallest coherent slice | Patch with citations / summary |
| 4. Verify | Definition of done | Runs docs checks, type checks, tests, lint, manual checks | Pass/fail log with exact commands |
| 5. Review | Human product judgment | Explains tradeoffs, unresolved risks, follow-ups | PR-ready summary and next steps |

### Default Agent Loop

1. **Read first:** `README.md`, `START_HERE.md`, `docs/INDEX.md`, `docs/ai-agents/KEY_FILES.md`, `CLAUDE.md`, and applicable decision records.
2. **State assumptions:** list product, stack, environment, and data assumptions before editing.
3. **Plan in slices:** separate docs, data model, UI, API, tests, and migration work.
4. **Edit surgically:** prefer small changes that keep template placeholders intact unless the task is explicitly product-specific.
5. **Verify locally:** run the most relevant checks before presenting results.
6. **Leave breadcrumbs:** update docs, index entries, changelog notes, or PRD trackers when the change affects future agents.

---

## Capability-Aware Task Routing

| Task type | Recommended agent mode | Reasoning / effort | Required guardrails |
|---|---|---|---|
| Copy edits, link fixes, checklist updates | Fast model or low effort | Low | Run `npm run docs:check` |
| New guide or template | Balanced model | Medium | Register in `docs/INDEX.md`; verify links |
| Feature scaffold from PRD | Frontier coding model | Medium to high | Implement tests with feature; keep scope bounded |
| Auth, billing, permissions, data deletion | Frontier coding model | High or max available | Require threat-model notes and negative tests |
| Large migration or refactor | Frontier coding model with planning | High or max available | Create rollback plan; run full checks |
| Visual/frontend polish | Agent plus `skills/taste-skill/SKILL.md` | Medium | No emojis in UI; validate accessibility and responsive states |
| Mobile readiness | Agent plus mobile skill/checklists | Medium | Sync iOS and Android readiness docs |
| Open-source governance / security | Careful review model | Medium | Update `opensource/` docs and `SECURITY.md` when needed |

Do not use the most expensive or deepest reasoning setting by default. Start balanced, then increase reasoning only when measured quality improves or the task involves architecture, security, billing, migrations, or multi-system debugging.

---

## Context Packaging Standard

Modern agents perform best when the repo gives them structured context instead of a giant undifferentiated prompt.

### Always-On Context

Keep these files concise and synchronized:

- `AGENTS.md` for CLI/Codex-style agents.
- `CLAUDE.md` for Claude Code.
- `.cursorrules` or Cursor project rules for Cursor.
- `docs/ai-agents/KEY_FILES.md` for file discovery.
- `skills/README.md` and focused `skills/*/SKILL.md` files for reusable workflows.

### Task Packet Template

Use this packet for any non-trivial agent run:

```md
Goal: [What should be true when this is done]
User value: [Who benefits and why]
Scope: [Files/areas the agent may change]
Out of scope: [What not to touch]
Relevant docs:
- [PRD or issue]
- [Domain/RBAC/billing/design docs]
- [Decision records]
Acceptance criteria:
- [Observable result]
- [Required tests/checks]
Constraints:
- Preserve placeholders unless explicitly filling a product template
- Keep links relative
- Follow skills/taste-skill/SKILL.md for frontend work
Verification:
- npm run docs:check
- npm run type-check / lint / test commands that apply
Deliverable:
- Summary, files changed, checks run, risks, follow-ups
```

---

## Repository Improvements for Agentic Coding

Use this checklist when turning SaaS-Viber into a stronger open-source starter shell.

### Documentation Backbone

- [ ] Every new guide is registered in `docs/INDEX.md`.
- [ ] Agent-facing docs (`AGENTS.md`, `CLAUDE.md`, `docs/ai-agents/*`) agree on startup files, coding norms, and verification commands.
- [ ] Decision records explain when to choose each option and what follow-up docs to update.
- [ ] `docs/STATUS.md` and `docs/NEXT_STEPS.md` reflect the current implementation stage.

### Prompt and Skill System

- [ ] Long prompts are converted into reusable prompt guides or skills.
- [ ] Skills stay focused on one repeatable capability.
- [ ] Each skill includes when to use it, inputs needed, workflow, and verification.
- [ ] Static rules are short enough to remain useful in every session.

### Verification and Eval Readiness

- [ ] Docs link checking is mandatory for documentation changes.
- [ ] Type checking, linting, unit tests, and E2E tests are documented even if the app code is not generated yet.
- [ ] High-risk flows have negative test cases: auth failures, billing webhooks, permission denials, data export/delete, mobile offline states.
- [ ] PRDs include acceptance criteria that an agent can verify programmatically where possible.

### Open-Source Maintainer Experience

- [ ] `opensource/CONTRIBUTING.md` explains how AI-generated changes should be reviewed.
- [ ] `opensource/SECURITY.md` covers responsible disclosure and secret handling.
- [ ] Templates preserve placeholders and avoid implying a production app already exists.
- [ ] Changelog entries separate template improvements from product-specific changes.

---

## Prompt Upgrades for Latest Agents

### Repo Audit Prompt

```md
Review this repository as a SaaS starter shell for modern agentic coding.

Read: README.md, START_HERE.md, docs/INDEX.md, docs/ai-agents/KEY_FILES.md, CLAUDE.md, AGENTS.md, decisions/*.md, skills/README.md.

Return:
1. What this repo is optimized for today.
2. Gaps that block a new builder from shipping.
3. Which gaps are documentation, tooling, architecture, design, testing, or open-source governance.
4. A prioritized plan with small PR-sized slices.
5. The exact checks you would run after each slice.

Do not edit files until you present the plan.
```

### Implementation Prompt

```md
Implement the next approved slice from the audit.

Constraints:
- Keep the change small and reviewable.
- Preserve template placeholders unless this slice explicitly fills them.
- Keep links relative and verify targets exist.
- Register new docs in docs/INDEX.md.
- Update AI-agent docs if workflow changes.
- Run the relevant checks and include exact commands in the final summary.
```

### Verification Prompt

```md
Act as a release reviewer for this patch.

Check:
- Internal Markdown links.
- Whether new docs are discoverable from README.md, START_HERE.md, or docs/INDEX.md.
- Whether agent instructions are synchronized.
- Whether tests/checks match the changed files.
- Whether placeholders were preserved where required.

Return blocking issues first, then non-blocking improvements.
```

---

## Anti-Patterns to Avoid

- **One giant agent run:** Break work into PR-sized slices with clear verification.
- **Prompt-only governance:** Put durable standards in docs, decisions, rules, or skills.
- **Unverified generated code:** Require tests, link checks, and manual review notes.
- **Context hoarding:** Give agents the smallest complete packet rather than every file.
- **Silent model drift:** Review vendor model guidance quarterly and update this playbook when capabilities or pricing materially change.
- **Overconfident autonomy:** Humans still own product judgment, data risk, legal review, and release approval.
