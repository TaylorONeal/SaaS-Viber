# SaaS Feature Reference by Phase

> Not sure what to put on your roadmap? Here's what most SaaS products need,
> organized by when you should build it. Copy the features relevant to your
> product into your ROADMAP.md.

---

## How to Use This File

1. Scan each phase below
2. Check the features that apply to your product
3. Copy them into `docs/roadmap/ROADMAP.md` under the matching phase
4. Add your domain-specific features (the things unique to YOUR product)
5. Prioritize: P0 = must ship, P1 = should ship, P2 = if time allows

This list is intentionally comprehensive. **No product needs all of these.** Pick what matters for your users and cut everything else.

---

## Phase 1: MVP

> Ship the smallest thing someone would pay for.

### Authentication & Identity

| Feature | Priority | Why It Matters |
|---|---|---|
| Email/password sign up | P0 | Basic account creation |
| Email/password sign in | P0 | Returning users need to get back in |
| Email verification | P0 | Prevents fake accounts, required for most auth providers |
| Password reset flow | P0 | Users forget passwords on day one |
| Sign out | P0 | Security basic |
| OAuth sign in (Google, GitHub) | P1 | Reduces sign-up friction by 20-40% |
| Session management | P0 | Keep users logged in, handle token refresh |
| Account deletion | P1 | GDPR requirement, builds trust |

### Core Product

| Feature | Priority | Why It Matters |
|---|---|---|
| [Your primary entity] CRUD | P0 | The core thing users create/manage in your app |
| [Your secondary entity] CRUD | P1 | Supporting data for the primary entity |
| Dashboard / home page | P0 | First thing users see after login |
| Basic navigation (sidebar or top nav) | P0 | Users need to move between sections |
| Search / filtering | P1 | Finding things matters once users have >5 items |
| Settings page (user profile) | P1 | Name, email, avatar, preferences |
| Empty states for every section | P0 | New users see empty pages — guide them |
| Loading states (skeletons) | P0 | Perceived performance, prevents layout shift |
| Error states with recovery actions | P0 | Things will break — help users recover |
| 404 page | P1 | Broken links need a soft landing |

### Payments

| Feature | Priority | Why It Matters |
|---|---|---|
| Pricing page | P0 | Users need to see what they're paying for |
| Stripe (or equivalent) integration | P0 | Collect money |
| Subscription creation | P0 | User picks a plan and pays |
| Billing portal (manage card, view invoices) | P1 | Self-service reduces support load |
| Webhook handling for payment events | P0 | Stripe notifies you of changes |
| Free tier or trial period | P1 | Lets users try before committing |

### Onboarding

| Feature | Priority | Why It Matters |
|---|---|---|
| Welcome screen after first sign-up | P0 | First impression, set expectations |
| Guided first action (wizard or checklist) | P1 | Get user to "aha moment" fast |
| Welcome email | P0 | Confirms registration, provides next steps |

### Infrastructure

| Feature | Priority | Why It Matters |
|---|---|---|
| Environment configuration (.env) | P0 | Dev, staging, production separation |
| Error tracking (Sentry or equivalent) | P0 | Know when things break in production |
| Basic CI/CD pipeline | P1 | Automated deploys reduce human error |
| SSL / HTTPS | P0 | Security and trust |
| Responsive layout (mobile-friendly) | P0 | 50%+ of traffic is mobile |

---

## Phase 2: Growth

> Features that drive acquisition, retention, and revenue.

### Team & Organization

| Feature | Priority | Why It Matters |
|---|---|---|
| Organization / workspace creation | P0 | Multi-user products need team containers |
| Invite team members (email invite) | P0 | Core growth loop |
| Role-based access (admin, member, viewer) | P0 | Not everyone should have the same permissions |
| Member management (remove, change role) | P1 | Admin control |
| Organization settings page | P1 | Name, logo, billing, plan details |

### Notifications

| Feature | Priority | Why It Matters |
|---|---|---|
| In-app notification bell | P1 | Real-time awareness of updates |
| Transactional emails (receipts, invites, resets) | P0 | Expected by users |
| Notification preferences (opt in/out) | P1 | Users want control; also a legal requirement |
| Email digest (daily/weekly summary) | P2 | Re-engagement without being annoying |

### Analytics & Data

| Feature | Priority | Why It Matters |
|---|---|---|
| User analytics (DAU, WAU, MAU) | P0 | Know if your product is alive |
| Revenue analytics (MRR, churn, LTV) | P0 | Know if your business is healthy |
| Funnel tracking (sign-up → activation → payment) | P1 | Know where users drop off |
| Usage analytics (feature adoption) | P2 | Know what features people actually use |
| Export to CSV | P2 | Users and admins need data out |

### Engagement

| Feature | Priority | Why It Matters |
|---|---|---|
| Onboarding checklist (persistent) | P1 | Drives activation beyond first session |
| Re-engagement email (24h / 72h) | P1 | Recovers abandoned sign-ups |
| Changelog / what's new | P2 | Shows product is alive, builds trust |
| Feedback collection (in-app widget) | P1 | User voice drives roadmap |

### Billing

| Feature | Priority | Why It Matters |
|---|---|---|
| Multiple pricing tiers | P0 | Different users need different plans |
| Plan upgrade / downgrade | P0 | Self-service plan changes |
| Dunning flow (failed payment retry) | P0 | Recovers 10-30% of churning revenue |
| Proration on plan changes | P1 | Fair billing when users change mid-cycle |
| Annual billing option | P1 | Higher LTV, lower churn |
| Coupon / promo codes | P2 | Marketing lever |

---

## Phase 3: Scale

> Reliability, performance, and operational maturity.

### Platform Hardening

| Feature | Priority | Why It Matters |
|---|---|---|
| Rate limiting on public endpoints | P0 | Prevent abuse |
| Database query optimization (indexes, N+1) | P0 | Performance at scale |
| Caching layer (CDN, API, query) | P1 | Speed and cost reduction |
| Load testing (what happens at 10x traffic) | P1 | Know your limits before they find you |
| Uptime monitoring with alerting | P0 | Know when you're down before users tell you |
| Structured logging | P1 | Debug production issues efficiently |
| Incident response runbook | P1 | When things break at 3am |
| Database backups with tested restore | P0 | Data loss is extinction-level |

### Compliance & Security

| Feature | Priority | Why It Matters |
|---|---|---|
| Audit logging | P0 | Who did what, when — required for enterprise |
| GDPR data export (right to access) | P1 | Legal requirement for EU users |
| GDPR data deletion (right to erasure) | P1 | Legal requirement for EU users |
| Cookie consent banner | P1 | Legal requirement in EU, California |
| Terms of Service and Privacy Policy pages | P0 | Legal requirement everywhere |
| SOC 2 preparation | P2 | Enterprise customers ask for it |
| Two-factor authentication (2FA) | P1 | Security expectation for B2B |
| SSO / SAML | P2 | Enterprise requirement |

### Admin & Operations

| Feature | Priority | Why It Matters |
|---|---|---|
| Admin dashboard (internal) | P0 | Manage users, orgs, subscriptions |
| User impersonation (admin) | P1 | Debug user-reported issues fast |
| Feature flags | P1 | Safe rollouts, A/B testing |
| API for integrations (public) | P2 | Power users and partners want programmatic access |
| Webhook system (outbound events) | P2 | Integrations and automation |

---

## Phase 4: Expand

> New markets, platforms, and revenue streams.

### Platform Expansion

| Feature | Priority | Why It Matters |
|---|---|---|
| Mobile app (iOS) | Depends | If your users expect mobile |
| Mobile app (Android) | Depends | If your users expect mobile |
| PWA enhancements (offline, push) | P2 | Mobile-like without app store |
| Public API + developer docs | P1 | Ecosystem and integration revenue |
| Marketplace / integration directory | P2 | Network effects |

### Internationalization

| Feature | Priority | Why It Matters |
|---|---|---|
| Multi-language UI (i18n) | P1 | Expand addressable market |
| Multi-currency billing | P1 | Required for international revenue |
| Locale-aware formatting (dates, numbers) | P1 | Feels native to each market |
| RTL layout support | P2 | Arabic, Hebrew markets |

### Enterprise

| Feature | Priority | Why It Matters |
|---|---|---|
| SSO / SAML integration | P0 | Table stakes for enterprise deals |
| Custom domains / white-label | P1 | Enterprise branding requirement |
| Advanced role permissions | P1 | Enterprise needs granular control |
| SLA dashboard | P2 | Prove your reliability |
| Priority support tier | P1 | Enterprise pays for faster help |
| Custom contracts / invoicing | P1 | Enterprise doesn't use credit cards |

### Content & SEO

| Feature | Priority | Why It Matters |
|---|---|---|
| Landing page(s) with value proposition | P0 | Organic traffic needs somewhere to land |
| Blog / content hub | P1 | SEO and thought leadership |
| Documentation / help center | P1 | Self-service support |
| Structured data (JSON-LD, OpenGraph) | P1 | Rich search results and social sharing |
| Sitemap and robots.txt | P1 | Search engine indexing |

---

## Domain-Specific Features

> These are the features unique to YOUR product. Add them here as you define your domain model.

| Feature | Phase | Priority | Notes |
|---|---|---|---|
| [Your unique feature 1] | [Phase] | [P0/P1/P2] | [What makes this your differentiator] |
| [Your unique feature 2] | [Phase] | [P0/P1/P2] | [Notes] |
| [Your unique feature 3] | [Phase] | [P0/P1/P2] | [Notes] |

---

## Using This With AI Tools

Paste this prompt into your AI agent to generate a roadmap from this reference:

```
Read docs/roadmap/FEATURE_REFERENCE.md and docs/roadmap/ROADMAP.md.

My product is [DESCRIBE YOUR PRODUCT IN ONE SENTENCE].
My target users are [WHO].
The core thing users do in my app is [PRIMARY ACTION].

From the feature reference, select the features relevant to my product
for each phase. Add my domain-specific features:
- [Feature 1]
- [Feature 2]
- [Feature 3]

Generate a filled-in ROADMAP.md with:
1. Real feature names (not placeholders)
2. Priorities assigned based on my product
3. Reasonable timeline estimates
4. Success metrics with specific targets
5. Exit criteria for each phase
```
