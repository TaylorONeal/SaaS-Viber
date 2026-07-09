# Public Repo Repurposing Guide

> Use this file when you want to mine an existing project, prototype, course toolkit, or niche app for reusable SaaS starter-kit assets without copying product-specific details blindly.

This guide distills reusable patterns found across Taylor O'Neal's public repositories into starter-kit material that can help future SaaS projects move from idea to launch faster.

---

## What Was Reviewed

| Repo | Useful starter-kit signal | Repurpose as |
|---|---|---|
| `clean-gmail` | Conservative automation, preview-first cleanup, never-touch lists, audit-and-restore loop | Safety-first automation checklist for destructive or semi-destructive workflows |
| `wayfare` | Connector-driven data ingestion, single-file output, themeable renderer, privacy defaults for sensitive local files | Connector and export patterns for SaaS products that ingest email, calendar, or uploaded records |
| `tandava` | Hosted plus self-host positioning, demo mode with realistic sample data, multi-role workflows, data ownership language | Vertical SaaS launch patterns, demo-mode requirements, open-core positioning checklist |
| `ai-education` | Skill ladder from copy-paste prompts to installed skills to computer-control automation, human sign-off rule, platform-specific guides | AI feature maturity model and human-in-the-loop policy for AI-enabled SaaS |
| `data-analysis` | Reusable analysis methods and skill packaging | Analytics and reporting starter prompts |
| `personal-signature` | Identity and voice assets | Brand voice capture prompts |
| `wakestate` and `SleepConverter` | Sensitive health-data workflows and import/export conversion | High-trust data handling and portability prompts |
| `unfollow` and `jetsweep` | Account cleanup and batch operations | Bulk-action safeguards and undo requirements |
| `learntodj` and `ai-yoga` | Learning-path content and domain pack structure | Training paths, curricula, and niche onboarding templates |
| `mirror-palace` | Agent memory, reflection, status domains, daily process templates | Agent onboarding and self-improving assistant patterns |

---

## Highest-Value Patterns to Add to a SaaS Starter Kit

### 1. Safety-first automation

Use this for anything that deletes, archives, bills, emails, grades, imports, merges, or updates records in bulk.

**Starter-kit rule:** every automation needs a reversible default, a preview mode, an allowlist/denylist, and an audit trail.

| Requirement | Template prompt |
|---|---|
| Preview before change | "Show counts, examples, and risky edge cases before applying changes." |
| Never-touch list | "Ask for entities that must never be changed, even if they match a rule." |
| Reversible default | "Prefer archive, draft, queue, or soft delete over permanent action." |
| Confirmation gate | "Pause before broad changes, external sends, charges, or irreversible state transitions." |
| Audit trail | "Record who approved, what changed, when, and how to restore it." |

### 2. Connector-driven architecture

Use this when a product turns user-owned data into useful outputs.

**Starter-kit rule:** keep connectors separate from the core domain model. Connectors produce normalized objects; the app consumes normalized objects.

| Layer | Responsibility |
|---|---|
| Source connector | Reads Gmail, calendar, CSV, API, webhook, or manual upload data |
| Normalizer | Converts source-specific fields into a stable internal object |
| Dedupe layer | Resolves repeated confirmations, reminders, imports, or duplicate records |
| Domain service | Applies product-specific rules to normalized data |
| Export layer | Gives users a portable copy in standard formats |

### 3. Demo mode as a first-class feature

Use this for SaaS products that need buyers, users, or investors to understand value before production setup is complete.

**Starter-kit rule:** a demo should exercise real workflows with realistic sample data and no backend dependency.

Demo mode should include:

- A complete fictional workspace, organization, or account.
- Role switching for every critical user type.
- Sample records that show happy paths, edge cases, and empty states.
- Clear labeling that prevents demo data from being mistaken for production data.
- A reset path so demos remain reliable.

### 4. Human-in-the-loop AI maturity ladder

Use this for any AI-enabled SaaS feature.

| Level | Product behavior | Best for |
|---|---|---|
| 1. Prompt-assisted | User copies context into AI and receives a draft | Early prototypes and internal workflows |
| 2. Skill-assisted | Product or agent uses a repeatable skill with guardrails | Repeatable workflows where consistency matters |
| 3. Agent-assisted | Agent gathers data, drafts work, and pauses for approval | High-value workflows with multiple tools or clicks |
| 4. Governed automation | Approved rules execute within limits and report exceptions | Mature workflows with clear rollback and monitoring |

**Non-negotiable:** AI can draft, classify, summarize, recommend, and queue. A human must approve anything that materially affects money, access, grades, health, legal status, outbound communication, or data deletion unless the user has explicitly configured governed automation.

### 5. Data ownership and portability

Use this when users bring valuable operational data into the product.

**Starter-kit rule:** explain import, export, retention, deletion, and migration before users ask.

Add these product promises when relevant:

- Users can export their records in documented formats.
- Sensitive local files are ignored by git and never committed by default.
- Self-hosted or open-core paths should define what the user owns, what the hosted operator manages, and what happens if they leave.
- Imports should report what was accepted, skipped, deduped, or flagged.

---

## Implementation Checklist for Future Starter-Kit Updates

When repurposing content from another public repo:

- [ ] Identify the reusable pattern, not just the domain-specific feature.
- [ ] Remove private, personal, customer, or niche-only assumptions.
- [ ] Convert product copy into a template, checklist, prompt, or decision framework.
- [ ] Register the new file in `docs/INDEX.md`.
- [ ] Verify links with `npm run docs:check`.
- [ ] Keep placeholders where the downstream SaaS builder must make a decision.

