# Architecture Prompt Guide

Ready-to-use prompts for generating customized architecture docs from the
templates in this folder. Copy a prompt, fill in the bracketed placeholders, and
paste it into your AI assistant. Read the referenced template first so you know
what good output looks like.

---

## 1. Generate Your Domain Model

**Template reference**: `DOMAIN_MODEL.md`

```
I'm building a SaaS product and need a domain model.

About my product:
- Product name: [name]
- What it does: [one paragraph]
- Core nouns users talk about: [e.g., "sequence", "client", "session", "workout"]
- Who the users are: [roles -- e.g., owner, member, admin, guest]
- Key actions: [what users create, edit, share, pay for]

Using the structure of a SaaS domain model doc, generate:
1. An entity list with attributes and types for each.
2. A Mermaid ER diagram of relationships (one-to-many, many-to-many).
3. Ownership and tenancy rules (who can see/edit what).
4. Lifecycle states for the 2-3 most important entities.
5. The invariants that must always hold (e.g., "a subscription always belongs
   to exactly one account").

Keep it specific to my nouns, not generic User/Post examples.
```

---

## 2. Generate Role & Access Control

**Template reference**: `ROLE_ACCESS_CONTROL.md`

```
I need an RBAC model for my SaaS product.

About my product:
- Roles I think I need: [list them]
- Sensitive actions: [billing changes, deleting data, inviting users, exports]
- Multi-tenant: [yes -- accounts/teams / no -- single user]
- Backend: [Supabase / Firebase / custom]

Generate:
1. A role matrix: rows = roles, columns = permissions, cells = allow/deny.
2. Row Level Security policy examples (if Supabase) for each protected table.
3. The default-deny baseline and how each policy is added and tested.
4. Edge cases: role changes mid-session, invited-but-not-accepted users,
   service-role/admin bypass.
```

---

## 3. Generate the Billing & Subscription Model

**Template reference**: `BILLING_MODELS.md`

```
I need a billing architecture for my SaaS product.

About my pricing:
- Model: [freemium / free trial / seat-based / usage-based / one-time]
- Plans and prices: [list them]
- Payment provider: [Stripe / Lemon Squeezy / RevenueCat for mobile]
- Mobile in-app purchase required: [yes/no]

Generate:
1. The subscription state machine (trialing, active, past_due, canceled, etc.)
   as a Mermaid diagram, with what each state grants access to.
2. The data model for plans, subscriptions, and entitlements.
3. Webhook events to handle and the idempotency strategy for each.
4. The "source of truth" rule for entitlement checks in app code.
```

---

## 4. Generate Reliability & Maintainability Docs

**Template reference**: `RELIABILITY.md`, `MAINTAINABILITY.md`

```
I need reliability and maintainability standards for my SaaS product.

About my setup:
- Tech stack: [framework, DB, hosting]
- Team size: [solo / small team]
- Current stage: [MVP / launched / scaling]

Generate:
1. An SLO starting point (uptime, latency) appropriate for my stage -- do not
   over-engineer for an MVP.
2. Monitoring and alerting: what to instrument first, what to ignore for now.
3. An incident response runbook skeleton.
4. Code-health standards: testing bar, review process, dependency policy,
   how technical debt is tracked.
```

---

## Tips

1. **Start with the domain model.** Every other architecture doc references it.
2. **Generate, then prune.** AI over-produces; cut anything your stage does not
   need yet and leave a note for later.
3. **Keep diagrams in Mermaid** so they render in GitHub and stay diffable.
4. **Save outputs back into this folder** -- they become the living spec the
   rest of the team and your AI agent read from.

---

## Quick Reference

| Situation | Prompt to Use |
|---|---|
| Starting a new project | #1 Domain Model -> #2 RBAC |
| Adding paid plans | #3 Billing Model |
| Preparing to scale | #4 Reliability & Maintainability |
