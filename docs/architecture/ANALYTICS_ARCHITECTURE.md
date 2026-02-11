# Analytics Architecture

> How analytics flows through your SaaS: data collection, storage, dashboards,
> and the metrics that matter at each stage of growth.

---

## System Overview

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│   Client-Side    │     │   Server-Side     │     │   Third-Party    │
│                  │     │                   │     │                  │
│  React App       │     │  API / Webhooks   │     │  Stripe          │
│  ├ Page views    │────→│  ├ Payment events │────→│  Email provider  │
│  ├ User actions  │     │  ├ Subscription   │     │  Auth provider   │
│  ├ Feature usage │     │  │   changes      │     │                  │
│  └ Errors        │     │  ├ Email events   │     └──────────────────┘
│                  │     │  └ Auth events    │
└────────┬─────────┘     └────────┬──────────┘
         │                        │
         ▼                        ▼
┌─────────────────────────────────────────────┐
│              Analytics Layer                │
│                                             │
│  PostHog / Mixpanel / Amplitude             │
│  ├ Event ingestion                          │
│  ├ User identification and profiles         │
│  ├ Session replay                           │
│  ├ Feature flags                            │
│  └ Funnels, cohorts, retention              │
│                                             │
│  Google Analytics 4                         │
│  ├ Traffic and acquisition                  │
│  ├ Campaign attribution                     │
│  └ Google Ads integration                   │
│                                             │
├─────────────────────────────────────────────┤
│              Data Warehouse (optional)       │
│  BigQuery / Snowflake                       │
│  ├ Raw event data export                    │
│  ├ Custom SQL analysis                      │
│  └ BI tool connections (Metabase, Looker)   │
└─────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────┐
│              Admin Dashboard                │
│  (Your app's built-in analytics views)      │
│                                             │
│  Platform Admin: Full metrics + all orgs    │
│  Org Admin: Org-scoped usage metrics        │
│  Org Member: Personal usage only            │
└─────────────────────────────────────────────┘
```

---

## The Metrics That Matter

### Phase 1 (MVP) — Are people using it?

| Metric | Definition | Target | Where to Track |
|---|---|---|---|
| **Signups** | New accounts created | Growing week over week | PostHog / GA4 |
| **Activation rate** | % of signups who complete core action | > 40% | PostHog funnel |
| **Time to value** | Minutes from signup to first core action | < 5 minutes | PostHog |
| **DAU / WAU / MAU** | Daily / Weekly / Monthly active users | Growing | PostHog |
| **Session duration** | Average time in app per session | Increasing | PostHog |
| **Error rate** | % of sessions with errors | < 1% | Sentry + PostHog |

### Phase 2 (Growth) — Is the business healthy?

| Metric | Definition | Target | Where to Track |
|---|---|---|---|
| **MRR** | Monthly Recurring Revenue | Growing | Stripe |
| **Churn rate** | % of subscribers who cancel per month | < 5% | Stripe + PostHog |
| **LTV** | Lifetime Value per customer | > 3x CAC | Calculated |
| **CAC** | Customer Acquisition Cost | Decreasing | GA4 + Stripe |
| **Trial → Paid conversion** | % of trials that convert to paid | > 15% | PostHog funnel |
| **NPS / CSAT** | Net Promoter Score / Customer Satisfaction | NPS > 30 | PostHog surveys |
| **Retention (30-day)** | % of users active 30 days after signup | > 40% | PostHog cohort |
| **Feature adoption** | % of users who use feature X | Varies | PostHog |

### Phase 3 (Scale) — Is the platform reliable?

| Metric | Definition | Target | Where to Track |
|---|---|---|---|
| **Uptime** | % of time service is available | > 99.9% | Monitoring tool |
| **P95 response time** | 95th percentile API latency | < 500ms | APM tool |
| **Error rate (API)** | % of API requests that return 5xx | < 0.1% | Monitoring |
| **Support ticket volume** | Tickets per 100 users per month | Decreasing | Support tool |
| **Revenue per employee** | MRR / team size | Increasing | Manual |

---

## Growth Funnels

### Acquisition Funnel

```
Visitor → Sign-up Started → Sign-up Completed → Activated → Trial → Paid
  100%        45%                 30%              18%         12%    6%
```

Track each stage to find where users drop off. The biggest drop is your highest-priority fix.

### Engagement Funnel

```
Login → View Dashboard → Use Core Feature → Complete Key Action → Return Next Day
 100%       85%               60%                 40%                  25%
```

### Revenue Funnel

```
Pricing Viewed → Checkout Started → Payment Completed → Retained at 30 Days
     100%              35%                20%                   75%
```

### Measuring Funnels

In PostHog, create funnels with these events:

```
Acquisition funnel:
  Step 1: $pageview (page = /signup)
  Step 2: signup_completed
  Step 3: onboarding_completed
  Step 4: core_action_completed
  Step 5: payment_completed

Time window: 14 days
Breakdown by: utm_source, signup_method, plan
```

---

## Cohort Analysis

### What to Cohort By

| Cohort Dimension | What It Tells You |
|---|---|
| **Sign-up week** | Is retention improving over time? |
| **Acquisition channel** | Which channels bring the stickiest users? |
| **Plan type** | Do paid users retain better than free? |
| **Onboarding completion** | Does finishing onboarding predict retention? |
| **First feature used** | Which features correlate with long-term retention? |

### Retention Table Pattern

```
         Week 0   Week 1   Week 2   Week 3   Week 4
Jan 1    100%     45%      35%      30%      28%
Jan 8    100%     48%      38%      32%
Jan 15   100%     52%      40%
Jan 22   100%     50%
```

**Healthy SaaS retention:** Week 4 retention > 25%, flattening (not declining) by Week 8.

---

## Admin Dashboard Architecture

### Platform Admin Dashboard

What the internal team sees at `/admin/analytics`:

```
┌──────────────────────────────────────────────────────┐
│  Admin Analytics Dashboard                           │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐        │
│  │ MRR    │ │ Users  │ │ Churn  │ │ NPS    │        │
│  │ $12.4K │ │ 1,247  │ │ 3.2%  │ │  42    │        │
│  │ ▲ 18%  │ │ ▲ 12%  │ │ ▼ 0.5%│ │ ▲ 3   │        │
│  └────────┘ └────────┘ └────────┘ └────────┘        │
│                                                      │
│  ┌────────────────────────────────────────────┐      │
│  │ Revenue Over Time (MRR line chart)         │      │
│  │ ███████████████████████████████████████████ │      │
│  └────────────────────────────────────────────┘      │
│                                                      │
│  ┌────────────────────┐ ┌────────────────────┐      │
│  │ Signups by Channel │ │ Conversion Funnel  │      │
│  │ Organic    45%     │ │ Visit   → Signup   │      │
│  │ Google     25%     │ │ Signup  → Active   │      │
│  │ Referral   15%     │ │ Active  → Trial    │      │
│  │ Social     10%     │ │ Trial   → Paid     │      │
│  │ Other       5%     │ │                    │      │
│  └────────────────────┘ └────────────────────┘      │
│                                                      │
│  ┌────────────────────────────────────────────┐      │
│  │ Retention Cohorts (heatmap)                │      │
│  │ Week 0  Week 1  Week 2  Week 3  Week 4    │      │
│  │ ██████  ████    ███     ██      ██         │      │
│  └────────────────────────────────────────────┘      │
│                                                      │
│  ┌────────────────────┐ ┌────────────────────┐      │
│  │ Top Features       │ │ Recent Signups     │      │
│  │ 1. Dashboard  89%  │ │ user@co.com  2m ago│      │
│  │ 2. Projects   67%  │ │ jane@co.com  15m   │      │
│  │ 3. Reports    45%  │ │ bob@co.com   1h    │      │
│  └────────────────────┘ └────────────────────┘      │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Org Admin Dashboard

What organization admins see at `/org/analytics`:

```
┌──────────────────────────────────────────────────────┐
│  [Org Name] Usage Analytics                          │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐        │
│  │ Members│ │ Active │ │ Items  │ │ Plan   │        │
│  │   12   │ │  8/12  │ │  347   │ │ Pro    │        │
│  │        │ │ 67%    │ │ ▲ 23   │ │        │        │
│  └────────┘ └────────┘ └────────┘ └────────┘        │
│                                                      │
│  ┌────────────────────────────────────────────┐      │
│  │ Team Activity (daily active members)       │      │
│  │ ████████████████████████████████████████   │      │
│  └────────────────────────────────────────────┘      │
│                                                      │
│  ┌────────────────────────────────────────────┐      │
│  │ Member Activity                            │      │
│  │ Name          Last Active    Actions (7d)  │      │
│  │ Alice         2 min ago      47            │      │
│  │ Bob           1 hour ago     23            │      │
│  │ Charlie       3 days ago     5             │      │
│  │ Diana         14 days ago    0  ⚠️          │      │
│  └────────────────────────────────────────────┘      │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Role-Based Access to Analytics

| Dashboard | Platform Admin | Org Admin | Org Manager | Org Member |
|---|---|---|---|---|
| Platform MRR / revenue | Yes | — | — | — |
| Platform user growth | Yes | — | — | — |
| Platform funnel metrics | Yes | — | — | — |
| Platform retention cohorts | Yes | — | — | — |
| All org metrics | Yes | — | — | — |
| Own org usage metrics | Yes | Yes | Yes | — |
| Own org member activity | Yes | Yes | Yes | — |
| Own personal usage | Yes | Yes | Yes | Yes |

---

## Dashboard Component Patterns

### Stat Card

```typescript
interface StatCardProps {
  label: string;           // "Monthly Revenue"
  value: string;           // "$12,400"
  change: number;          // 18 (percent change)
  changeLabel: string;     // "vs last month"
  trend: "up" | "down" | "flat";
  icon?: React.ReactNode;
}
```

Display rules:
- Positive change = green text with ▲
- Negative change for bad metrics (churn up) = red text with ▲
- Negative change for good metrics (churn down) = green text with ▼
- Flat = muted text with —

### Time-Series Chart

```typescript
interface TimeSeriesProps {
  data: { date: string; value: number }[];
  period: "7d" | "30d" | "90d" | "1y";
  metric: string;          // "MRR", "DAU", etc.
  format: "number" | "currency" | "percent";
}
```

Recommended library: **Recharts** (React-native, composable, lightweight).

### Funnel Chart

```typescript
interface FunnelStep {
  name: string;            // "Visit"
  count: number;           // 10000
  conversionRate: number;  // 0.45 (from previous step)
}
```

Display as horizontal bars with conversion rates between each step.

### Retention Heatmap

```typescript
interface CohortRow {
  cohortDate: string;       // "2025-01-06"
  cohortSize: number;       // 150
  retention: number[];      // [1.0, 0.45, 0.35, 0.30, ...]
}
```

Color scale: dark (high retention) → light (low retention).

---

## Data Collection Strategy

### What to Collect In-App vs. External Tools

| Data | Collect In-App | External Tool |
|---|---|---|
| User signups and registrations | Yes (audit log) | PostHog |
| Feature usage events | No | PostHog |
| Page views and navigation | No | PostHog + GA4 |
| Revenue and payments | Yes (billing tables) | Stripe Dashboard |
| Errors and exceptions | No | Sentry |
| Session replays | No | PostHog |
| Traffic sources and campaigns | No | GA4 |
| Email open/click rates | No | Email provider dashboard |
| NPS and surveys | No | PostHog surveys |
| Support tickets | Yes (if built-in) | Zendesk / Intercom |

### Admin Dashboard Data Sources

The admin dashboard queries your own database for metrics you own:

```sql
-- MRR calculation
SELECT SUM(plan_amount) as mrr
FROM subscriptions
WHERE status = 'active';

-- Signup trend (last 30 days)
SELECT DATE(created_at) as date, COUNT(*) as signups
FROM users
WHERE created_at > NOW() - INTERVAL '30 days'
GROUP BY DATE(created_at)
ORDER BY date;

-- Churn rate (monthly)
SELECT
  COUNT(*) FILTER (WHERE canceled_at BETWEEN start_of_month AND end_of_month) as churned,
  COUNT(*) FILTER (WHERE created_at < start_of_month AND status = 'active') as total,
  ROUND(churned::numeric / NULLIF(total, 0) * 100, 1) as churn_rate
FROM subscriptions;
```

External analytics (PostHog, GA4) provide behavioral data that's too expensive to store yourself.

---

## Event Data Flow

```
User clicks "Create Project"
         │
         ▼
┌──────────────────────┐
│ React Component      │
│ onClick handler      │
│ calls trackEvent()   │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ analytics.ts         │
│ Routes to PostHog    │
│ Routes to GA4        │
│ Logs in dev mode     │
└──────────┬───────────┘
           │
     ┌─────┴──────┐
     ▼            ▼
┌─────────┐  ┌─────────┐
│ PostHog │  │   GA4   │
│ Cloud   │  │  Cloud  │
└─────────┘  └─────────┘
     │
     ▼
┌─────────────────┐
│ PostHog Funnel  │
│ shows this user │
│ reached step 3  │
└─────────────────┘
```

---

## Privacy Architecture

### Data Classification

| Data Type | Storage | Retention | GDPR |
|---|---|---|---|
| Aggregate metrics (DAU, MRR) | Your database | Indefinite | Not PII |
| Event data with user ID | PostHog / analytics tool | 2 years | Pseudonymized PII |
| Session replays | PostHog | 90 days | PII (may contain text input) |
| IP addresses | GA4 (anonymized by default) | 14 months | PII |
| Payment data | Stripe (not your DB) | Per Stripe policy | PII |

### Right to Erasure

When a user requests data deletion:

1. Delete from your database (users, subscriptions, content)
2. Call PostHog API: `DELETE /api/person/{distinct_id}`
3. GA4: Request deletion via Google's User Deletion API
4. Stripe: Cancel subscription, delete customer (if no legal hold)
5. Log the erasure event in audit trail (without PII)

### Consent Flow

```
New visitor arrives
    │
    ▼
Is EU/UK/CA user? (GeoIP check)
    │
    ├─ No → Initialize all analytics
    │
    └─ Yes → Show consent banner
              │
              ├─ Accepts all → Initialize all analytics
              ├─ Accepts essential only → Initialize Plausible only (no cookies)
              └─ Rejects all → No analytics initialized
```

---

## Related Docs

- `decisions/ANALYTICS_CHOICES.md` — Choose your analytics platform
- `docs/developer/analytics-setup.md` — Implementation guide with code
- `docs/prd/ATTRIBUTION_TRACKING.md` — Event taxonomy, funnels, attribution models
- `docs/developer/tracking-plan.md` — Event implementation checklist
- `docs/architecture/AUDIT_COMPLIANCE.md` — GDPR and data compliance
- `docs/data/DATA_TAXONOMY.md` — Data classification and retention
