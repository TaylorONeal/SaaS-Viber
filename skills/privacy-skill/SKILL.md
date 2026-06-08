---
name: data-privacy
description: Enforces data minimization and privacy-by-default whenever the task touches user data -- collecting, storing, querying, logging, analytics events, error reports, or LLM prompts. Load for any auth, database, tracking, or AI-feature work that could carry personal or sensitive information.
---

# Data Privacy Skill

Privacy is an architecture decision, not a launch-day checkbox. These rules are
non-negotiable defaults; relax one only with an explicit, written reason.

## 1. Collect the Minimum

- If a feature does not require a field, do not collect it. Every stored field is
  a liability you must secure, justify, and one day delete.
- Prefer deriving over storing (compute age from a coarse birth year; do not store
  exact birthdates unless the feature needs them).
- Never request a permission (camera, location, contacts) you do not actively use.
  Unused permissions are both a privacy risk and an App Store rejection reason.

## 2. Treat Sensitive Data as Radioactive

Sensitive = health, biometric, precise location, financial, government IDs, or
anything that re-identifies a person.

- Encrypt at rest; scope every row with default-deny Row Level Security.
- Keep it OUT of: application logs, analytics events, error/crash reports,
  URLs/query strings, and LLM prompts. Assume every copy is a potential leak.
- When you must send data to a third party (including an LLM provider),
  redact or tokenize identifiers first. Log the *event*, never the *payload*.

## 3. Never Ship Secrets or PII to the Client

- API secrets and service-role keys live server-side only. Client keys must be
  publishable-only and useless without RLS.
- Do not embed other users' data, internal IDs, or admin endpoints in the bundle.
  Anything shipped to the browser/app is public.
- Audit analytics calls and LLM prompts on the client path -- PII leaks through
  both far more often than through the database.

## 4. Consent Is Explicit, Revocable, and Reversible

- Opt-in over opt-out for any non-essential data use or tracking.
- Ship account export and account deletion from day one. Both must purge
  downstream copies (backups schedule, analytics, third parties), not just the
  primary row. Retrofitting deletion later is painful and often non-compliant.
- Make consent state queryable and honor it everywhere the data is used.

## 5. Local-First Where You Can

- Data that never leaves the device cannot be breached, subpoenaed, or lost.
- Sync only what genuinely must be shared across devices or users, and be
  explicit in code and docs about exactly what crosses that boundary.

## Pre-Flight Check

- [ ] Every new field is justified by a specific feature.
- [ ] No sensitive data appears in logs, analytics, error reports, or LLM prompts.
- [ ] No secret or other-user data is reachable from the client bundle.
- [ ] RLS is default-deny and tested per table.
- [ ] Export and delete paths exist and purge downstream copies.

See `docs/architecture/AUDIT_COMPLIANCE.md` and `docs/data/DATA_TAXONOMY.md` for
the project-level treatment, and `docs/ai-agents/LESSONS_LEARNED.md` (Privacy &
Sensitive Data) for the underlying principles.
