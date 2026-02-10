# Product Roadmap — [YOUR_APP_NAME]

> **Purpose:** Define the product vision across phases, linking features to PRDs,
> dependencies, and measurable success criteria.
>
> **Last Updated:** [DATE]
> **Owner:** [PRODUCT_OWNER_NAME]

---

## Roadmap Overview

```mermaid
gantt
    title [YOUR_APP_NAME] Product Roadmap
    dateFormat  YYYY-MM-DD
    axisFormat  %b %Y

    section Phase 1 — MVP
    [Feature 1]           :a1, [START_DATE], [DURATION]
    [Feature 2]           :a2, after a1, [DURATION]
    [Feature 3]           :a3, after a1, [DURATION]

    section Phase 2 — Growth
    [Feature 4]           :b1, after a3, [DURATION]
    [Feature 5]           :b2, after b1, [DURATION]

    section Phase 3 — Scale
    [Feature 6]           :c1, after b2, [DURATION]
    [Feature 7]           :c2, after c1, [DURATION]

    section Phase 4 — Expand
    [Feature 8]           :d1, after c2, [DURATION]
    [Feature 9]           :d2, after d1, [DURATION]
```

---

## Roadmap Principles

Before filling in the phases below, establish your roadmap principles:

1. **[Principle 1]:** e.g., "Ship something usable every 2 weeks"
2. **[Principle 2]:** e.g., "Revenue features before vanity features"
3. **[Principle 3]:** e.g., "Never ship without tests"
4. **[Principle 4]:** e.g., "Mobile parity within one sprint of web"

---

## Phase 1: MVP

> **Timeline:** [START_DATE] — [END_DATE]
> **Theme:** Get the core value proposition working end-to-end.

### Goals
- [ ] [Goal 1: e.g., "Users can sign up, complete core workflow, and see value"]
- [ ] [Goal 2: e.g., "Basic payment flow works for one pricing tier"]
- [ ] [Goal 3: e.g., "Admin can manage core entities"]

### Features

| Feature | Priority | Status | PRD | Owner |
|---|---|---|---|---|
| [User Authentication] | P0 | [Status] | [Link] | [Person] |
| [Core Entity CRUD] | P0 | [Status] | [Link] | [Person] |
| [Primary User Workflow] | P0 | [Status] | [Link] | [Person] |
| [Basic Dashboard] | P1 | [Status] | [Link] | [Person] |
| [Payment Integration] | P1 | [Status] | [Link] | [Person] |
| [Admin Panel — Basic] | P1 | [Status] | [Link] | [Person] |

### Dependencies
- [ ] [Dependency 1: e.g., "Stripe account approved"]
- [ ] [Dependency 2: e.g., "Domain model finalized"]
- [ ] [Dependency 3: e.g., "Design system v1 complete"]

### Success Metrics
| Metric | Target | How to Measure |
|---|---|---|
| [User Signup Rate] | [X users/week] | [Analytics tool] |
| [Core Workflow Completion] | [X]% | [Funnel tracking] |
| [First Payment] | [X transactions] | [Stripe dashboard] |
| [Time to Value] | < [X] minutes | [User session tracking] |

### Exit Criteria
- [ ] All P0 features are in Production status
- [ ] Core workflow tested end-to-end by [X] beta users
- [ ] No critical or major bugs open
- [ ] Payment flow tested with real transactions

---

## Phase 2: Growth

> **Timeline:** [START_DATE] — [END_DATE]
> **Theme:** Expand features that drive user acquisition, retention, and revenue.

### Goals
- [ ] [Goal 1: e.g., "Support multiple pricing tiers"]
- [ ] [Goal 2: e.g., "Users can invite team members"]
- [ ] [Goal 3: e.g., "Notification system drives engagement"]

### Features

| Feature | Priority | Status | PRD | Owner |
|---|---|---|---|---|
| [Multi-tier Pricing] | P0 | [Status] | [Link] | [Person] |
| [Team/Org Management] | P0 | [Status] | [Link] | [Person] |
| [Email Notifications] | P1 | [Status] | [Link] | [Person] |
| [User Profile & Settings] | P1 | [Status] | [Link] | [Person] |
| [Search & Filtering] | P1 | [Status] | [Link] | [Person] |
| [Reporting — Basic] | P2 | [Status] | [Link] | [Person] |

### Dependencies
- [ ] Phase 1 exit criteria met
- [ ] [Dependency: e.g., "Email service provider selected"]
- [ ] [Dependency: e.g., "User feedback from Phase 1 analyzed"]

### Success Metrics
| Metric | Target | How to Measure |
|---|---|---|
| [Monthly Active Users] | [X] | [Analytics] |
| [Revenue (MRR)] | $[X] | [Billing dashboard] |
| [Team Adoption] | [X] orgs with 3+ members | [Database query] |
| [Retention (30-day)] | [X]% | [Cohort analysis] |

### Exit Criteria
- [ ] MRR target reached
- [ ] Team features used by [X]% of organizations
- [ ] NPS score above [X]

---

## Phase 3: Scale

> **Timeline:** [START_DATE] — [END_DATE]
> **Theme:** Harden the platform for reliability, performance, and operational efficiency.

### Goals
- [ ] [Goal 1: e.g., "Handle 10x current load without degradation"]
- [ ] [Goal 2: e.g., "Achieve 99.9% uptime SLA"]
- [ ] [Goal 3: e.g., "Reduce support tickets by 50% through self-service"]

### Features

| Feature | Priority | Status | PRD | Owner |
|---|---|---|---|---|
| [Performance Optimization] | P0 | [Status] | [Link] | [Person] |
| [Advanced Analytics] | P0 | [Status] | [Link] | [Person] |
| [Self-Service Admin] | P1 | [Status] | [Link] | [Person] |
| [Audit Logging] | P1 | [Status] | [Link] | [Person] |
| [API for Integrations] | P1 | [Status] | [Link] | [Person] |
| [Automated Testing Suite] | P2 | [Status] | [Link] | [Person] |

### Dependencies
- [ ] Phase 2 exit criteria met
- [ ] [Dependency: e.g., "Infrastructure scaling plan approved"]
- [ ] [Dependency: e.g., "Compliance audit scheduled"]

### Success Metrics
| Metric | Target | How to Measure |
|---|---|---|
| [Uptime] | 99.9% | [Monitoring tool] |
| [P95 Response Time] | < [X]ms | [APM tool] |
| [Support Ticket Volume] | -50% from Phase 2 | [Support tool] |
| [API Adoption] | [X] integrations | [API analytics] |

### Exit Criteria
- [ ] SLA targets met for 30 consecutive days
- [ ] All compliance requirements satisfied
- [ ] API documentation published and used by partners

---

## Phase 4: Expand

> **Timeline:** [START_DATE] — [END_DATE]
> **Theme:** Expand to new markets, platforms, or revenue streams.

### Goals
- [ ] [Goal 1: e.g., "Launch mobile apps on iOS and Android"]
- [ ] [Goal 2: e.g., "Support internationalization for 3 languages"]
- [ ] [Goal 3: e.g., "Launch marketplace or partner ecosystem"]

### Features

| Feature | Priority | Status | PRD | Owner |
|---|---|---|---|---|
| [Mobile App — iOS] | P0 | [Status] | [Link] | [Person] |
| [Mobile App — Android] | P0 | [Status] | [Link] | [Person] |
| [Internationalization] | P1 | [Status] | [Link] | [Person] |
| [Marketplace / Integrations] | P1 | [Status] | [Link] | [Person] |
| [Enterprise Features] | P2 | [Status] | [Link] | [Person] |
| [White-label / Reseller] | P2 | [Status] | [Link] | [Person] |

### Dependencies
- [ ] Phase 3 exit criteria met
- [ ] [Dependency: e.g., "App store developer accounts approved"]
- [ ] [Dependency: e.g., "Localization vendor selected"]

### Success Metrics
| Metric | Target | How to Measure |
|---|---|---|
| [Mobile MAU] | [X] | [Mobile analytics] |
| [International Revenue] | [X]% of total | [Billing by region] |
| [Partner Integrations] | [X] active | [Marketplace metrics] |
| [Enterprise Contracts] | [X] signed | [CRM] |

### Exit Criteria
- [ ] Mobile apps published and rated 4+ stars
- [ ] Revenue from new markets exceeds [X]% of total
- [ ] Partner ecosystem self-sustaining

---

## Custom Phase Template

> Copy this section to add additional phases.

### Phase [N]: [PHASE_NAME]

> **Timeline:** [START_DATE] — [END_DATE]
> **Theme:** [One sentence describing the focus of this phase]

#### Goals
- [ ] [Goal 1]
- [ ] [Goal 2]
- [ ] [Goal 3]

#### Features
| Feature | Priority | Status | PRD | Owner |
|---|---|---|---|---|
| [Feature] | [P0/P1/P2] | [Status] | [Link] | [Person] |

#### Dependencies
- [ ] Phase [N-1] exit criteria met
- [ ] [Additional dependency]

#### Success Metrics
| Metric | Target | How to Measure |
|---|---|---|
| [Metric] | [Target] | [Measurement method] |

#### Exit Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

---

## Priority Definitions

| Priority | Meaning | Rule |
|---|---|---|
| P0 | Must have | Phase cannot ship without this |
| P1 | Should have | Strongly expected; defer only with justification |
| P2 | Nice to have | Include if time/resources allow; otherwise push to next phase |
| P3 | Future | Tracked for future consideration; not committed |

---

## Prompt Guide Reference

> Use the following prompt to generate a roadmap from your PRDs:

```
I have the following Product Requirements Documents for [YOUR_APP_NAME]:

[List your PRD titles and one-line summaries]

Based on these PRDs, generate a product roadmap following the template
in docs/ROADMAP.md. Organize features into four phases:
- Phase 1 (MVP): Core value proposition, minimum features to launch
- Phase 2 (Growth): Features that drive acquisition and retention
- Phase 3 (Scale): Reliability, performance, compliance
- Phase 4 (Expand): New platforms, markets, revenue streams

For each phase, define:
1. Three measurable goals
2. Features with priorities (P0/P1/P2)
3. Dependencies and exit criteria
4. Success metrics with specific targets

Ensure no feature appears in multiple phases. Link each feature to its PRD.
```

---

*Status: Template*
*Next review: [DATE]*
