# Documentation Navigation Hub

> **Welcome to the [YOUR_APP_NAME] documentation.**
> This documentation set is structured to serve multiple audiences and use cases.
> Whether you are a founder shaping the product, a developer building features,
> a designer crafting the experience, or an AI assistant generating code — there
> is a clear reading path for you.

---

## How This Documentation Is Organized

```
docs/
├── INDEX.md                  ← You are here
├── STATUS.md                 ← Current project status
├── FEATURE_INDEX.md          ← Registry of all features
├── LOCALIZATION_ANALYSIS.md  ← Internationalization planning
├── FAQ.md                    ← Frequently asked questions
├── NEXT_STEPS.md             ← Prioritized next actions
├── DEMO_MODE.md              ← Demo mode architecture
│
├── architecture/             ← System architecture docs
│   ├── DOMAIN_MODEL.md
│   ├── ROLE_ACCESS_CONTROL.md
│   ├── AUDIT_COMPLIANCE.md
│   ├── APP_STORE_COMPLIANCE.md
│   ├── MOBILE_ARCHITECTURE.md
│   ├── RELIABILITY.md
│   ├── MAINTAINABILITY.md
│   ├── VERSION_MANAGEMENT.md
│   ├── BILLING_MODELS.md
│   ├── ANALYTICS_ARCHITECTURE.md ← Admin dashboard, KPIs, growth metrics
│   ├── DEMO_SEPARATION.md
│   └── PromptGuide-Architecture.md
│
├── decisions/                ← Architecture Decision Records (ADRs)
│   ├── ANALYTICS_CHOICES.md  ← Compare PostHog, GA4, Mixpanel, etc.
│   └── [YOUR_DECISION_FILES].md
│
├── developer/                ← Developer guides and setup
│   ├── analytics-setup.md    ← PostHog + GA4 implementation guide
│   ├── tracking-plan.md      ← Event registry and tracking checklist
│   └── [YOUR_DEV_GUIDES].md
│
├── design/                   ← Design system and assets
│   └── [YOUR_DESIGN_DOCS].md
│
├── guides/                   ← User and team guides
│   └── BRANDING_GUIDE.md
│
├── ai-agents/                ← AI-assisted development guides
│   └── [YOUR_AI_AGENT_CONFIGS].md
│
├── roadmap/                  ← Product roadmap and planning
│   ├── ROADMAP.md            ← Product roadmap by phase
│   ├── FEATURE_REFERENCE.md  ← Common SaaS features by phase
│   └── COMPETITOR_ANALYSIS.md← Competitive analysis framework
│
└── prd/                      ← Product Requirements Documents
    ├── PRD-TEMPLATE.md       ← Template for new PRDs
    ├── PRD-001-example.md    ← Example PRD
    └── prd-tracker.json      ← PRD status and task tracker
```

---

## Role-Based Reading Paths

### "I'm a Founder or Product Manager"

You care about what we're building, why, and when.

| Start Here | Then Read | Deep Dive |
|---|---|---|
| [ROADMAP.md](./roadmap/ROADMAP.md) | [FEATURE_INDEX.md](./FEATURE_INDEX.md) | `prds/` directory |
| [STATUS.md](./STATUS.md) | [NEXT_STEPS.md](./NEXT_STEPS.md) | `decisions/` directory |
| [FAQ.md](./FAQ.md) | [DEMO_MODE.md](./DEMO_MODE.md) | [BILLING_MODELS.md](./architecture/BILLING_MODELS.md) |

**Key questions this path answers:**
- What is the current state of the product?
- What are we building next and why?
- How do we prioritize features?
- What does the revenue model look like?

---

### "I'm a Developer"

You care about how things work, how to set up, and how to contribute.

| Start Here | Then Read | Deep Dive |
|---|---|---|
| `developer/` setup guides | [DOMAIN_MODEL.md](./architecture/DOMAIN_MODEL.md) | [ROLE_ACCESS_CONTROL.md](./architecture/ROLE_ACCESS_CONTROL.md) |
| [STATUS.md](./STATUS.md) | [MAINTAINABILITY.md](./architecture/MAINTAINABILITY.md) | [RELIABILITY.md](./architecture/RELIABILITY.md) |
| [Analytics Setup](./developer/analytics-setup.md) | [Tracking Plan](./developer/tracking-plan.md) | [Analytics Architecture](./architecture/ANALYTICS_ARCHITECTURE.md) |
| [FEATURE_INDEX.md](./FEATURE_INDEX.md) | [VERSION_MANAGEMENT.md](./architecture/VERSION_MANAGEMENT.md) | [MOBILE_ARCHITECTURE.md](./architecture/MOBILE_ARCHITECTURE.md) |

**Key questions this path answers:**
- How do I set up the development environment?
- What is the domain model and database schema?
- What are the coding standards and review process?
- How do we handle deployments and versioning?

---

### "I'm a Designer"

You care about the user experience, brand consistency, and design systems.

| Start Here | Then Read | Deep Dive |
|---|---|---|
| `design/` directory | `guides/BRANDING_GUIDE.md` | [FEATURE_INDEX.md](./FEATURE_INDEX.md) |
| [DEMO_MODE.md](./DEMO_MODE.md) | [LOCALIZATION_ANALYSIS.md](./LOCALIZATION_ANALYSIS.md) | [APP_STORE_COMPLIANCE.md](./architecture/APP_STORE_COMPLIANCE.md) |

**Key questions this path answers:**
- What is the design system and component library?
- How does branding apply across surfaces?
- What features need design work?
- What are the accessibility requirements?

---

### "I'm Using AI to Build"

You are leveraging AI assistants (Claude, ChatGPT, Copilot, etc.) to accelerate development.

| Start Here | Then Read | Deep Dive |
|---|---|---|
| `CLAUDE.md` (project root) | [PromptGuide-Architecture.md](./architecture/PromptGuide-Architecture.md) | `ai-agents/` directory |
| [DOMAIN_MODEL.md](./architecture/DOMAIN_MODEL.md) | [FEATURE_INDEX.md](./FEATURE_INDEX.md) | `prds/` directory |

**Key questions this path answers:**
- How do I prompt an AI assistant to generate architecture docs?
- What context does the AI need to write good code for this project?
- Where are the prompt guides for each documentation area?
- How do I maintain consistency when using AI-generated content?

---

## Quick Links

### Project Status
- [Project Status](./STATUS.md) — What's working, what's not
- [Roadmap](./roadmap/ROADMAP.md) — Where we're headed
- [Feature Reference](./roadmap/FEATURE_REFERENCE.md) — Common SaaS features by phase
- [PRD Tracker](./prd/prd-tracker.json) — PRD status and task completion
- [Next Steps](./NEXT_STEPS.md) — Immediate priorities
- [Feature Index](./FEATURE_INDEX.md) — Every feature, tracked

### Architecture
- [Domain Model](./architecture/DOMAIN_MODEL.md) — Entities, relationships, principles
- [Role Access Control](./architecture/ROLE_ACCESS_CONTROL.md) — RBAC and permissions
- [Billing Models](./architecture/BILLING_MODELS.md) — Pricing and subscription architecture
- [Mobile Architecture](./architecture/MOBILE_ARCHITECTURE.md) — Mobile platform patterns
- [Reliability](./architecture/RELIABILITY.md) — SLAs, monitoring, incident response
- [Maintainability](./architecture/MAINTAINABILITY.md) — Code standards, testing, reviews
- [Version Management](./architecture/VERSION_MANAGEMENT.md) — Versioning and migrations
- [Audit & Compliance](./architecture/AUDIT_COMPLIANCE.md) — Regulatory requirements
- [App Store Compliance](./architecture/APP_STORE_COMPLIANCE.md) — iOS and Android requirements
- [Demo Separation](./architecture/DEMO_SEPARATION.md) — Marketing vs app architecture

### Analytics
- [Analytics Choices](../decisions/ANALYTICS_CHOICES.md) — Compare PostHog, GA4, Mixpanel, Amplitude, Plausible
- [Analytics Setup](./developer/analytics-setup.md) — PostHog + GA4 implementation guide with code
- [Analytics Architecture](./architecture/ANALYTICS_ARCHITECTURE.md) — Admin dashboard, KPIs, growth metrics
- [Tracking Plan](./developer/tracking-plan.md) — Event registry, funnels, implementation checklist

### Guides & References
- [Demo Mode](./DEMO_MODE.md) — Show before you build
- [Localization Analysis](./LOCALIZATION_ANALYSIS.md) — i18n planning
- [FAQ](./FAQ.md) — Common questions by audience
- [Architecture Prompt Guide](./architecture/PromptGuide-Architecture.md) — AI prompts for generating docs

---

## Status Legend

Each document and feature uses the following status indicators:

| Status | Meaning |
|---|---|
| `Template` | Structure exists but needs to be filled in with your project specifics |
| `In Progress` | Being actively worked on; partially complete |
| `Complete` | Finished and reviewed; ready for use |
| `Needs Review` | Content exists but needs validation or update |
| `Deprecated` | No longer relevant; kept for reference |

---

## How to Use These Templates

1. **Start with the Domain Model.** Everything else flows from understanding your entities and relationships.
2. **Fill in the Roadmap.** Define your phases and what "done" looks like for each.
3. **Register Features.** Use FEATURE_INDEX.md to track every feature from idea to production.
4. **Use the Prompt Guides.** Each section has prompts you can feed to an AI assistant to generate drafts.
5. **Iterate.** These documents are living artifacts. Update them as the product evolves.

---

## Contributing to Documentation

- Follow the template structure in each file
- Replace `[YOUR_APP_NAME]`, `[YOUR_DOMAIN]`, and similar placeholders with your actual values
- Keep the status legend updated
- Link between documents using relative paths
- When adding a new document, register it in this INDEX.md

---

*Last updated: [DATE]*
*Documentation version: Template v1.0*
