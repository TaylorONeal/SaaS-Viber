# Analytics Platform Choices

> Choose your analytics stack. Most SaaS products need two layers:
> **product analytics** (what users do inside your app) and
> **web analytics** (how users find and arrive at your app).
> Some tools cover both. This guide helps you pick.

---

## Decision Matrix

| Factor | PostHog | Google Analytics 4 | Mixpanel | Amplitude | Plausible | Heap |
|---|---|---|---|---|---|---|
| **Primary strength** | All-in-one product analytics | Web traffic and acquisition | Event analytics and funnels | Behavioral analytics | Privacy-first web analytics | Auto-capture everything |
| **Event tracking** | Custom + autocapture | Custom + enhanced measurement | Custom events | Custom events | Pageviews only | Autocapture + custom |
| **Funnels** | Yes (advanced) | Yes (basic) | Yes (advanced) | Yes (advanced) | No | Yes (advanced) |
| **Cohort analysis** | Yes | Yes (basic) | Yes | Yes (advanced) | No | Yes |
| **Retention charts** | Yes | No (use BigQuery) | Yes | Yes | No | Yes |
| **Session replay** | Yes (built-in) | No | No | Yes (add-on) | No | Yes (built-in) |
| **Feature flags** | Yes (built-in) | No | No | Yes (Experiment) | No | No |
| **A/B testing** | Yes (built-in) | No (use Optimize) | No | Yes (built-in) | No | No |
| **Heatmaps** | Yes (built-in) | No | No | No | No | Yes (built-in) |
| **Surveys** | Yes (built-in) | No | No | No | No | No |
| **User identification** | Yes | Limited | Yes | Yes | No (anonymous) | Yes |
| **Self-host option** | Yes (Docker) | No | No | No | Yes (Docker) | No |
| **GDPR-friendly** | Yes (self-host = full control) | Requires consent | Requires consent | Requires consent | Yes (no cookies) | Requires consent |
| **Free tier** | 1M events/mo | Unlimited (sampled) | 20M events/mo | 10M events/mo | 10K pageviews/mo | 10K sessions/mo |
| **Cost at scale** | $450/mo (10M events) | Free (unsampled in 360) | $833/mo (100M events) | Custom (>10M) | $19/mo (100K views) | Custom |
| **React SDK** | Yes (posthog-js) | Yes (gtag.js) | Yes (mixpanel-js) | Yes (amplitude-js) | Script tag only | Yes (heap-js) |
| **Server-side SDK** | Yes (Node, Python, Go) | Yes (Measurement Protocol) | Yes (Node, Python) | Yes (Node, Python) | No | Yes (Node) |
| **Data warehouse export** | Yes (BigQuery, S3) | Yes (BigQuery linked) | Yes (raw data export) | Yes (Snowflake, BigQuery) | No | Yes |
| **Learning curve** | Low-Medium | Low | Medium | Medium-High | Very Low | Low |
| **Community** | Large, growing | Largest | Large | Large | Small, growing | Medium |

---

## Recommended Combinations

### Solo Builder / Early MVP

**PostHog (free tier)** — One tool covers everything.

```
PostHog handles:
✓ Product analytics (events, funnels, retention)
✓ Session replay (see what users actually do)
✓ Feature flags (safe rollouts)
✓ A/B testing (experiment without extra tools)
✓ Surveys (collect feedback in-app)
```

Cost: Free up to 1M events/month. Self-host for unlimited.

### Growth-Stage SaaS

**PostHog + Google Analytics 4** — PostHog for product, GA4 for acquisition.

```
GA4 handles:                    PostHog handles:
✓ Traffic sources               ✓ In-app behavior
✓ SEO performance               ✓ Feature adoption
✓ Campaign attribution          ✓ Funnel analysis
✓ Google Ads integration        ✓ Retention cohorts
✓ Search Console link           ✓ Session replays
                                ✓ A/B testing
```

Cost: GA4 free + PostHog free tier = $0 to start.

### Data-Driven Team

**Amplitude + GA4 + Segment** — Best-in-class analytics with a data layer.

```
Segment (data layer):   → Routes events to all tools
GA4 (acquisition):      → Traffic, campaigns, SEO
Amplitude (product):    → Behavioral analytics, experiments
Data warehouse:         → BigQuery/Snowflake for custom analysis
```

Cost: Significant ($1K+/mo at scale). Best for funded teams.

### Privacy-First / EU-Focused

**Plausible + PostHog (self-hosted)** — No cookies, full GDPR compliance.

```
Plausible:              → Lightweight web analytics (no consent needed)
PostHog (self-hosted):  → Full product analytics on your infrastructure
```

Cost: Plausible $9/mo + hosting costs for PostHog.

---

## Tool-by-Tool Breakdown

### PostHog

**Choose PostHog if:**
- You want one tool instead of five
- You're a solo builder or small team
- You want session replays without paying for FullStory/Hotjar
- You care about GDPR and want self-hosting as an option
- You want feature flags and A/B testing without separate tools

**Tradeoffs:**
- Pro: All-in-one reduces tool sprawl and context switching
- Pro: Generous free tier (1M events/month)
- Pro: Self-host option for full data control
- Pro: Open source — you can inspect the code
- Con: Acquisition/traffic analytics weaker than GA4
- Con: Self-hosted requires DevOps knowledge
- Con: Younger product — some features less mature than specialists
- Con: Can be noisy with autocapture enabled

**Cost progression:**
| Scale | Cost |
|---|---|
| 0 - 1M events/mo | Free |
| 1M - 2M events/mo | ~$50/mo |
| 2M - 10M events/mo | ~$250-450/mo |
| 10M+ events/mo | Self-host (hosting costs only) |

### Google Analytics 4 (GA4)

**Choose GA4 if:**
- You need Google Ads integration
- SEO and organic traffic analysis is important
- You want free, unlimited web analytics
- Your team already knows Google's ecosystem
- You need Search Console integration

**Tradeoffs:**
- Pro: Free with massive scale
- Pro: Best Google Ads integration
- Pro: BigQuery export for raw data
- Pro: Huge community and documentation
- Con: Privacy concerns (Google owns the data)
- Con: Complex UI, steep learning curve for advanced features
- Con: Sampled data at high volumes (unless GA4 360)
- Con: Limited product analytics (no session replay, weak funnels)
- Con: Cookie-based — requires consent in EU

**Cost progression:**
| Scale | Cost |
|---|---|
| Any volume | Free (standard) |
| Enterprise (unsampled) | ~$50K-150K/year (GA4 360) |

### Mixpanel

**Choose Mixpanel if:**
- Event analytics and funnels are your primary need
- You want the best funnel and retention analysis
- Your team is comfortable with a query-builder interface
- You need strong mobile analytics

**Tradeoffs:**
- Pro: Best-in-class funnel analysis
- Pro: Excellent retention and cohort tools
- Pro: Strong mobile SDKs
- Pro: Generous free tier (20M events)
- Con: No session replay, heatmaps, or feature flags
- Con: Can be complex for non-technical users
- Con: Requires careful event instrumentation (no autocapture)
- Con: Gets expensive at scale

### Amplitude

**Choose Amplitude if:**
- Behavioral analytics and experimentation are core to your strategy
- You have a data-savvy team
- You want built-in A/B testing with analytics
- You're optimizing for product-led growth

**Tradeoffs:**
- Pro: Most powerful behavioral analytics
- Pro: Built-in experimentation platform
- Pro: Excellent cohort and retention analysis
- Pro: Strong data governance features
- Con: Steep learning curve
- Con: Can be expensive for small teams
- Con: Overkill for early-stage products
- Con: Complex setup

### Plausible

**Choose Plausible if:**
- Privacy is a hard requirement (EU market, healthcare, etc.)
- You want simple, lightweight web analytics
- You don't need product analytics (or use a separate tool)
- You want to avoid cookie consent banners

**Tradeoffs:**
- Pro: No cookies — no consent banner needed
- Pro: GDPR compliant by design
- Pro: Simple, clean dashboard
- Pro: Self-host option
- Pro: Lightweight script (~1KB)
- Con: Pageviews only — no custom events or funnels
- Con: No user identification
- Con: No session replay or product analytics
- Con: Not suitable as your only analytics tool for a SaaS

---

## Implementation Patterns

### Analytics Service Abstraction

Wrap your analytics calls behind an abstraction so you can switch providers without touching every component.

```typescript
// src/lib/analytics.ts

interface AnalyticsEvent {
  name: string;
  properties?: Record<string, unknown>;
}

interface AnalyticsService {
  init(): void;
  identify(userId: string, traits?: Record<string, unknown>): void;
  track(event: AnalyticsEvent): void;
  page(name?: string, properties?: Record<string, unknown>): void;
  reset(): void;
}
```

This pattern lets you:
- Use PostHog in development, GA4 + PostHog in production
- Add/remove providers without changing component code
- Disable tracking in test environments
- Batch events for performance

See `docs/developer/analytics-setup.md` for the full implementation guide.

### Event Naming Convention

Use `object_action` format with lowercase and underscores:

```
signup_started
signup_completed
feature_used
payment_completed
subscription_cancelled
```

See `docs/prd/ATTRIBUTION_TRACKING.md` for the complete event taxonomy.

---

## Decision Checklist

Before choosing, answer these:

- [ ] Do you need product analytics (in-app behavior), web analytics (traffic), or both?
- [ ] Do you serve EU users? (GDPR affects tool choice)
- [ ] Do you need session replays?
- [ ] Do you need A/B testing?
- [ ] What's your monthly event volume estimate?
- [ ] Who will query the data — engineers or marketers?
- [ ] Do you need Google Ads integration?
- [ ] Do you want to self-host for data sovereignty?

### Quick Decision Tree

```
Need Google Ads integration?
  → Yes: GA4 (for acquisition) + PostHog (for product)
  → No:
    Privacy-critical (EU, healthcare)?
      → Yes: PostHog (self-hosted) + Plausible
      → No:
        Want one tool for everything?
          → Yes: PostHog
          → No:
            Want best-in-class behavioral analytics?
              → Yes: Amplitude or Mixpanel
              → No: PostHog
```

---

## Related Docs

- `docs/prd/ATTRIBUTION_TRACKING.md` — Event taxonomy, funnels, attribution models
- `docs/developer/analytics-setup.md` — Implementation guide with code
- `docs/architecture/ANALYTICS_ARCHITECTURE.md` — Admin dashboard, KPIs, growth metrics
- `docs/developer/tracking-plan.md` — Event implementation checklist
