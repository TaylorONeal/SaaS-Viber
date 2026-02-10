# Platform Overview

> **Last Updated**: [Date]
> **Version**: [Semantic version, e.g., 1.0.0]
> **Owner**: [Product Lead]

---

## 1. Product Vision

### Vision Statement
<!-- One sentence that describes the aspirational future state your product enables -->
[TEMPLATE: "We envision a world where [target users] can [transformative capability] without [current friction/pain]."]

### Mission Statement
<!-- How the product works toward the vision, more concrete and actionable -->
[TEMPLATE: "[Product Name] enables [target users] to [core action] by providing [key differentiator], resulting in [primary outcome]."]

### Product Principles
<!-- 3-5 principles that guide all product decisions. When two good ideas conflict, principles break the tie. -->
1. **[Principle Name]**: [One-sentence explanation. e.g., "Simplicity over power -- we will sacrifice advanced features before we sacrifice ease of use."]
2. **[Principle Name]**: [One-sentence explanation]
3. **[Principle Name]**: [One-sentence explanation]
4. **[Principle Name]**: [One-sentence explanation]
5. **[Principle Name]**: [One-sentence explanation]

---

## 2. Target Users & Personas

### Primary Personas

#### Persona 1: [Name / Archetype]
| Attribute | Detail |
|-----------|--------|
| **Role** | [Job title or function] |
| **Company Size** | [Solo / SMB / Mid-market / Enterprise] |
| **Technical Skill** | [Non-technical / Semi-technical / Technical] |
| **Primary Goal** | [What they are trying to accomplish] |
| **Key Frustration** | [What blocks them today] |
| **Willingness to Pay** | [Price sensitivity and budget authority] |
| **Acquisition Channel** | [How they find tools like this] |
| **Success Metric** | [How they measure whether the product works for them] |

**Jobs to Be Done**:
1. When [situation], I want to [motivation], so I can [expected outcome].
2. When [situation], I want to [motivation], so I can [expected outcome].

**A Day in Their Life**:
[2-3 sentence narrative describing how this persona encounters the problem and how the product fits into their workflow.]

#### Persona 2: [Name / Archetype]
| Attribute | Detail |
|-----------|--------|
| **Role** | [Job title or function] |
| **Company Size** | [Solo / SMB / Mid-market / Enterprise] |
| **Technical Skill** | [Non-technical / Semi-technical / Technical] |
| **Primary Goal** | [What they are trying to accomplish] |
| **Key Frustration** | [What blocks them today] |
| **Willingness to Pay** | [Price sensitivity and budget authority] |
| **Acquisition Channel** | [How they find tools like this] |
| **Success Metric** | [How they measure whether the product works for them] |

**Jobs to Be Done**:
1. When [situation], I want to [motivation], so I can [expected outcome].

#### Persona 3: [Name / Archetype -- e.g., Admin / Account Owner]
<!-- Repeat the table format above -->

### Anti-Personas
<!-- Who is this product explicitly NOT for? Clarity here prevents scope creep. -->
- **[Anti-persona]**: [Why they are not our target, and why that is a deliberate choice]
- **[Anti-persona]**: [Why they are not our target]

---

## 3. Core Value Proposition

### Value Proposition Canvas

#### Customer Profile
| Element | Detail |
|---------|--------|
| **Customer Jobs** | [What tasks are they trying to complete?] |
| **Pains** | [What frustrations, risks, or obstacles do they face?] |
| **Gains** | [What outcomes or benefits do they desire?] |

#### Value Map
| Element | Detail |
|---------|--------|
| **Products & Services** | [What we offer] |
| **Pain Relievers** | [How we address their specific pains] |
| **Gain Creators** | [How we deliver specific gains] |

### Positioning Statement
For [target customer] who [statement of need], [Product Name] is a [product category] that [key benefit]. Unlike [primary alternative], our product [primary differentiator].

### Elevator Pitch
[2-3 sentences. This is what you say when someone asks "So what does your product do?" at a conference.]

---

## 4. Architecture Overview

> For the full technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

### System Context Diagram
```
[External Users] --> [CDN / Edge] --> [Frontend SPA]
                                          |
                                    [API Gateway]
                                    /     |     \
                            [Auth]  [Core API]  [Workers]
                              |         |           |
                          [Identity] [Database]  [Queue]
                          [Provider]    |           |
                                   [Cache]    [Storage]
```

### Technology Stack Summary
| Layer | Technology | Rationale |
|-------|-----------|-----------|
| **Frontend** | [e.g., React / Next.js / Vue] | [Why chosen] |
| **API** | [e.g., Node.js / Python / Go] | [Why chosen] |
| **Database** | [e.g., PostgreSQL / MongoDB] | [Why chosen] |
| **Cache** | [e.g., Redis / Memcached] | [Why chosen] |
| **Auth** | [e.g., Custom / Auth0 / Clerk] | [Why chosen] |
| **Payments** | [e.g., Stripe / Paddle] | [Why chosen] |
| **Hosting** | [e.g., AWS / GCP / Vercel] | [Why chosen] |
| **CI/CD** | [e.g., GitHub Actions / GitLab CI] | [Why chosen] |
| **Monitoring** | [e.g., Datadog / Sentry / Grafana] | [Why chosen] |

### Key Architectural Decisions
| Decision | Choice | Alternatives Considered | Rationale |
|----------|--------|------------------------|-----------|
| [Decision area] | [What we chose] | [What we considered] | [Why] |

---

## 5. Feature Categories & Status

### Feature Status Legend
| Status | Meaning |
|--------|---------|
| Shipped | Live in production, available to all users |
| Beta | Live but flagged, limited rollout |
| In Development | Actively being built |
| Approved | PRD approved, in backlog |
| Planned | On roadmap, PRD in progress |
| Exploring | Under research, not committed |
| Deferred | Considered and postponed |

### Core Platform Features
| Feature | Status | PRD | Phase | Owner |
|---------|--------|-----|-------|-------|
| User Authentication & SSO | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| User Onboarding | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Role-Based Access Control | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Organization / Workspace Management | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Billing & Subscription Management | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Notification System | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Audit Logging | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Settings & Preferences | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |

### Domain-Specific Features
| Feature | Status | PRD | Phase | Owner |
|---------|--------|-----|-------|-------|
| [Core domain feature 1] | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| [Core domain feature 2] | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| [Core domain feature 3] | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |

### Growth & Engagement Features
| Feature | Status | PRD | Phase | Owner |
|---------|--------|-----|-------|-------|
| Referral Program | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| In-App Messaging / Announcements | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Usage Analytics Dashboard | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Email Campaigns & Drip Sequences | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |

### Integration & API Features
| Feature | Status | PRD | Phase | Owner |
|---------|--------|-----|-------|-------|
| Public REST API | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Webhooks | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Third-Party Integrations | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |
| Data Import / Export | [Status] | [PRD-XXX](./PRD-XXX.md) | [Phase] | [Owner] |

---

## 6. Competitive Positioning

### Competitive Landscape
| Competitor | Positioning | Strengths | Weaknesses | Our Advantage |
|-----------|-------------|-----------|------------|---------------|
| [Competitor 1] | [How they position] | [What they do well] | [Where they fall short] | [Why we win] |
| [Competitor 2] | [How they position] | [What they do well] | [Where they fall short] | [Why we win] |
| [Competitor 3] | [How they position] | [What they do well] | [Where they fall short] | [Why we win] |

### Positioning Matrix
```
                    High Ease of Use
                         |
                         |
        [Us?]            |           [Competitor A?]
                         |
   Low ──────────────────┼────────────────── High
   Functionality         |              Functionality
                         |
        [Competitor C?]  |           [Competitor B?]
                         |
                    Low Ease of Use
```
<!-- Replace with your actual strategic axes -->

### Defensibility & Moats
| Moat Type | Current Strength (1-5) | Strategy to Strengthen |
|-----------|----------------------|----------------------|
| Network Effects | [Rating] | [Strategy] |
| Switching Costs | [Rating] | [Strategy] |
| Data Advantage | [Rating] | [Strategy] |
| Brand | [Rating] | [Strategy] |
| Technical Complexity | [Rating] | [Strategy] |
| Ecosystem / Integrations | [Rating] | [Strategy] |

---

## 7. Revenue Model

### Pricing Tiers
| Tier | Price | Target Persona | Key Features | Limits |
|------|-------|---------------|--------------|--------|
| Free | $0/mo | [Who] | [What is included] | [Usage caps] |
| Starter | $[X]/mo | [Who] | [Everything in Free, plus...] | [Usage caps] |
| Professional | $[X]/mo | [Who] | [Everything in Starter, plus...] | [Usage caps] |
| Enterprise | Custom | [Who] | [Everything in Professional, plus...] | [Custom] |

### Revenue Streams
| Stream | Type | Current % of Revenue | Target % | Notes |
|--------|------|---------------------|----------|-------|
| Subscriptions | Recurring | [%] | [%] | [MRR/ARR details] |
| Usage-Based | Variable | [%] | [%] | [What is metered] |
| Add-Ons | Recurring/One-time | [%] | [%] | [What add-ons] |
| Professional Services | One-time | [%] | [%] | [Implementation, training] |

### Key Business Metrics
| Metric | Current | 6-Month Target | 12-Month Target |
|--------|---------|---------------|----------------|
| MRR | [Value] | [Target] | [Target] |
| ARR | [Value] | [Target] | [Target] |
| Paying Customers | [Count] | [Target] | [Target] |
| ARPU | [Value] | [Target] | [Target] |
| Churn Rate (Monthly) | [%] | [Target] | [Target] |
| LTV | [Value] | [Target] | [Target] |
| CAC | [Value] | [Target] | [Target] |
| LTV:CAC Ratio | [Ratio] | [Target] | [Target] |
| Net Revenue Retention | [%] | [Target] | [Target] |
| Gross Margin | [%] | [Target] | [Target] |

### Conversion Funnel
```
Visitor        --> [Conversion Rate %] --> Sign-Up
Sign-Up        --> [Activation Rate %] --> Activated User
Activated User --> [Conversion Rate %] --> Trial Start
Trial Start    --> [Conversion Rate %] --> Paid Customer
Paid Customer  --> [Expansion Rate %]  --> Upgraded Customer
```

---

## 8. Growth Strategy

### Growth Model
<!-- Which growth model(s) does this product rely on? -->
- [ ] **Product-Led Growth (PLG)**: Self-serve sign-up, freemium, viral loops
- [ ] **Sales-Led Growth (SLG)**: Outbound sales, demos, enterprise contracts
- [ ] **Community-Led Growth (CLG)**: Content, community, ecosystem
- [ ] **Hybrid**: Combination (describe)

### Acquisition Channels
| Channel | Stage | CAC Estimate | Volume Potential | Priority |
|---------|-------|-------------|-----------------|----------|
| Organic Search / SEO | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Content Marketing | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Paid Search (SEM) | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Social Media (Organic) | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Social Media (Paid) | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Referral Program | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Partnerships | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Product Virality | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |
| Outbound Sales | [Current stage] | [Cost] | [Volume] | [P0/P1/P2] |

### Retention Strategy
| Lever | Implementation | Expected Impact | Status |
|-------|---------------|----------------|--------|
| Onboarding Optimization | [How] | [Impact on retention] | [Status] |
| Engagement Loops | [How -- notifications, streaks, digests] | [Impact] | [Status] |
| Feature Adoption | [How -- guided tours, contextual tips] | [Impact] | [Status] |
| Win-Back Campaigns | [How -- email sequences for churned users] | [Impact] | [Status] |
| Customer Success | [How -- proactive outreach for high-value accounts] | [Impact] | [Status] |

### Expansion Strategy
| Vector | Approach | Timeline |
|--------|----------|----------|
| Upsell to higher tiers | [Strategy] | [When] |
| Cross-sell add-ons | [Strategy] | [When] |
| Seat expansion | [Strategy] | [When] |
| Usage growth | [Strategy] | [When] |
| New market segments | [Strategy] | [When] |
| Geographic expansion | [Strategy] | [When] |

### Growth Roadmap
| Phase | Timeline | Focus | Key Milestones |
|-------|----------|-------|---------------|
| Phase 1: Foundation | [Dates] | [Focus area] | [Milestone targets] |
| Phase 2: Traction | [Dates] | [Focus area] | [Milestone targets] |
| Phase 3: Scale | [Dates] | [Focus area] | [Milestone targets] |
| Phase 4: Expansion | [Dates] | [Focus area] | [Milestone targets] |

---

## Appendix

### Glossary
| Term | Definition |
|------|-----------|
| [Term] | [Definition as used in this product context] |

### Document History
| Date | Author | Changes |
|------|--------|---------|
| [Date] | [Name] | [Initial creation / What changed] |
