# Admin Dashboard

> Added Nov 8, 2026. All prices, limits, and rules in this file are as of Nov 8, 2026. Verify in the vendor docs or console before you buy, enroll, or ship.
>
> Related docs: [Analytics Architecture](../architecture/ANALYTICS_ARCHITECTURE.md) (the dashboard mockups and role table this doc turns into a contract) | [GA4 and Web Analytics](./GA4_AND_WEB_ANALYTICS.md) (what GA4 answers) | [Attribution End to End](./ATTRIBUTION_END_TO_END.md) (where the numbers come from) | [Tracking Plan](../developer/tracking-plan.md) (the event registry) | [Analytics Choices](../../decisions/ANALYTICS_CHOICES.md) (the vendor decision matrix)

## In one minute

An admin dashboard answers three questions every week: are people signing up, are they staying, and are they paying. Everything else is decoration. You have three ways to build it: query your own first-party tables, read the vendor dashboard, or put a BI layer on top of a warehouse. The right choice depends on who is reading it and how much you trust the number. This doc gives you the decision table, the reporting contract that makes the numbers honest, and the worked example from CueCraft's admin reporting repair, which is the best pattern in the family. The contract is the doc: read-only, UTC cohorts, mature denominators, N/A instead of zero, test accounts excluded, and no number without its denominator and date range.

## 1. Plain language: what the dashboard is for

The dashboard is not the product. Nobody pays you because your admin page has nice charts. It exists so a human can answer, in under a minute, whether the business is healthy, and so an agent can check its work against a number that means something. If a chart does not change a decision, remove it. If a number does not have a denominator, it is not a number, it is a vibe.

The existing architecture doc in this repo shows mockups of a platform admin dashboard and an org admin dashboard with invented numbers: MRR, users, churn, NPS. Mockups are useful for layout and useless for truth. This doc replaces the mockup with a contract: what is queried, from which table, over which dates, with which denominator, and what shows when there is not enough data. A dashboard route is not a dashboard. TeacherTree proved that: its Analytics page was a placeholder, not a funnel, cohort, or revenue dashboard, while the working surface was a small card that said "Book taps show interest, not completed bookings or attendance." That card was more honest than the placeholder, because it said what the number was not.

## 2. The three options

### 2.1 Option A: build on your own first-party tables

You write SQL against your own database and render the results in your own admin pages. This is the default recommendation in this template, and it is what the worked example below does.

What you get: numbers you own, from the same tables as your customer records, with no sampling and no vendor limits. What it costs: you write the queries, you maintain them, and you are responsible for the access control. The queries are simple at first (signups per day, activation rate, retention by cohort) and grow with the product.

When to choose it: you have a first-party event table already, your team can write SQL, and the dashboard is for your own decisions rather than for showing customers.

### 2.2 Option B: use the vendor dashboard

You read PostHog, GA4, or Mixpanel directly. No code, no maintenance, and the funnels and cohorts are built in.

What you get: speed, and charts that are better than anything you will build in week one. What it costs: the numbers live in a rented sink with its own limits. PostHog Cloud free is 1M events a month with 1-year retention, and past the limit usage is dropped, not billed, so a quiet overage silently loses data. GA4 standard samples above 10M events per exploration query and keeps exploration data for 2 months unless you set 14 months on day one. Mixpanel free is 1M events a month as of Nov 8, 2026. Vendor dashboards also answer the vendor's questions, not yours: PostHog will not tell you Stripe revenue, and GA4 will not tell you activation.

When to choose it: you need something this week, the questions are standard (funnels, retention, traffic), and you accept that the vendor's limits are your limits.

### 2.3 Option C: use a BI layer on a warehouse

You export events to BigQuery (from GA4, daily export up to 1M events per day as of Nov 8, 2026, streaming above that at $0.05 per GB) and read them with a BI tool such as Looker Studio, or with Metabase or Looker on your own warehouse. This is the option for a team that has outgrown both A and B: too many questions for hand-written pages, too much data for the vendor's free tier.

What you get: one place where GA4's anonymous visits and your first-party events sit side by side for analysis, with real SQL and real charts. What it costs: a warehouse to maintain, an export to keep running, and a second access-control problem, because the BI tool needs its own permissions. The warehouse is a copy for analysis, never the source of truth for per-person decisions.

When to choose it: you have a data-savvy person on the team, your event volume is past what hand-written queries handle comfortably, or you need joins across sources that no single vendor provides.

### 2.4 Decision table

| Question | A: Own tables | B: Vendor dashboard | C: BI on warehouse |
|---|---|---|---|
| Who reads it | Your team | Your team | Your team, plus analysts |
| Cost to start | A few SQL queries | $0 on free tiers | Export plus BI setup |
| Cost at scale | Your database grows | Free tier limits bite, then pay-as-you-go | Warehouse and BI costs |
| Numbers you own | All of them | None, they live in the vendor | The copy, not the source |
| Sampling | None | GA4 above 10M per query, PostHog drops past free | None, if you export everything |
| Revenue | Yes, join to Stripe and RevenueCat | No, vendors do not see billing | Yes, if you export billing |
| Store attribution | Population level only | Population level only | Population level only |
| Maintenance | You maintain the queries | Vendor maintains the tool | You maintain export and BI |
| Right for | Most apps in this template | Week one, or standard questions only | Teams with a data person |

Start with A, use B for the questions it answers well (GA4 for acquisition, PostHog for product funnels), and move to C when the questions outgrow the pages. Do not start with C. A warehouse with no questions is a bill, not an asset.

## 3. The worked example: the yogaflow F632 pattern

CueCraft's web app, yogaflow, had an admin reporting page that was wrong in the ways admin pages are usually wrong: it counted the wrong people, it counted them too early, and it showed zero where it should have shown "we do not know yet". The repair, spec F632, approved Oct 19, 2026, is the contract this doc copies. Copy the contract, not the code. Your tables have different names. The rules are the same.

### 3.1 Read-only, no new event writers

The repair changed no collection, no identity, no schema, no billing, no native code, and no provider settings. It added one read endpoint, `GET /api/admin/growth-metrics`, that reads the existing tables and returns numbers. That is the rule: the dashboard reads, it never writes events, never changes identity, and never touches billing. If your dashboard needs a new event to answer a question, the event is a separate decision with its own tracking-plan entry, not a side effect of building the page.

### 3.2 UTC signup cohorts, 28 complete days by default

The endpoint takes an explicit UTC signup cohort: by default the last 28 complete UTC days, with optional start and end as single `YYYY-MM-DD` values spanning 1 to 366 complete UTC days. "Complete" is the operative word. Today is not a complete day, and a cohort that includes today is a cohort with a missing denominator. Always use complete days, always say the timezone, and always say the range on the page next to the number. A retention number without its date range is not a number.

### 3.3 Mature denominators only

A rate is a fraction, and the denominator must be old enough for the thing to have happened yet. F632's maturity rules:

- 24-hour first save needs accounts at least 24 hours old.
- Strict 7-day second save needs accounts at least 7 days old.
- Profile-return windows of 1 to 2, 7 to 14, and 30 to 60 days need accounts at least 3, 15, and 61 days old.

If the denominator is not mature, the cell shows N/A, not zero. Zero means nobody did it. N/A means we do not know yet because not enough time has passed. Showing zero for an immature cohort tells the team the product is broken when it is only young. That is the single most valuable rule in this doc.

Zero eligible accounts, or absent activation-status records, also produce N/A. Absent data is not zero data.

### 3.4 Test accounts excluded, anonymous demos excluded, store installs excluded

Test accounts are excluded by default. Anonymous demos and store installs are excluded from cohort denominators. A cohort is people who signed up, and a test account is not a person, a demo is not a signup, and a store install is not an account until someone signs in. If your activation rate includes your own test accounts, your own demos, and your own installs, you are measuring yourself.

### 3.5 Honest labels

Every number carries its label: what it counts, over which dates, from which table, with which denominator. "Book taps show interest, not completed bookings or attendance" is the model sentence. Write the equivalent for every metric on your dashboard: what it is, and what it is not.

## 4. What the dashboard shows: cohorts, retention, revenue

### 4.1 Signups and activation

Signups per day, from the profiles table, over complete UTC days. Activation rate: the share of a signup cohort that completed the one core action, with the denominator matured per the rules above. Activation is defined once, in the product doc, and never redefined on the dashboard. TeacherTree's definition is a good model: activation is persisting at least one valid class or event and generating a graphic in the same session. Your definition will be different. It must be one sentence, and the dashboard must use it.

### 4.2 Retention: cohort tables, not averages

Retention is a table, not a number. Rows are signup cohorts (by week), columns are weeks since signup, cells are the share of the cohort still active. A single "30-day retention" number hides whether retention is improving or collapsing. The cohort table shows it. The existing architecture doc's retention table pattern is the right shape, but its numbers are invented. Fill it from your own tables, with mature denominators, and leave immature cells as N/A.

Healthy is a direction, not a threshold. The architecture doc suggests week 4 retention above 25%, flattening by week 8. Treat that as a starting point to test against your own product, not a promise. A yoga app and a finance app do not retain the same way, and a threshold copied from a doc is not a target.

### 4.3 Revenue: from billing, never from analytics

MRR, churn, and trial-to-paid conversion come from Stripe and RevenueCat, not from GA4 or PostHog. The dashboard joins billing to the profiles table for the cohort view, and it never adds Stripe customers and RevenueCat customers together, because they overlap. The source of truth per question is written on the page: revenue from Stripe plus RevenueCat, signups from profiles, attribution from the profile. See [Attribution End to End](./ATTRIBUTION_END_TO_END.md) for the four-populations rule.

### 4.4 What an admin may see, and never see

**An admin may see:** aggregate signups, activation, retention, and revenue; per-cohort tables; funnel step counts; and, for support purposes, a single customer's own record when that customer asks for help, with the access logged.

**An admin must never see:** another customer's private content; raw event tables with per-person browsing history; passwords, tokens, or keys; or cross-customer data in an org admin view. The existing architecture doc's role table is the shape: platform admin sees all orgs, org admin sees their org, org member sees only their own usage. Enforce it in the database with row level security, not just in the UI. A hidden button is not access control. TeacherTree's pattern is the model: clients cannot read the raw funnel table, and per-teacher stats come from a security-definer function scoped to the signed-in teacher.

**No PII in analytics, ever.** No email, no name, no phone, no IP in an event property, a dashboard filter, or a chart label. If a question needs a person, it is answered from the customer record, not from the analytics tables.

## 5. DB choices for the dashboard, and customer records

The dashboard reads the same database the app writes to, at the start. That is the Supabase decision from [GA4 and Web Analytics](./GA4_AND_WEB_ANALYTICS.md): events in their own tables, insert-only, row level security on, admin reads through a scoped function or a dedicated read role, never through a client key. As volume grows, move the dashboard queries to a read replica or to the warehouse export, so a heavy admin query never slows down a customer. That move is a scaling decision, not a day-one requirement.

The free-versus-Pro rule applies here exactly as it applies to the event tables: Free is for building and validating, and a product paying customers rely on belongs on Pro, because free projects pause after 1 week without activity and must be restored manually, as of Nov 8, 2026. If the dashboard is the only way you know the business is healthy, and it goes down because the project paused, you are flying blind at the worst moment.

Customer records are the dashboard's other half. The four populations, auth users, profiles, Stripe customers, RevenueCat customers, each have their own key, and the dashboard must say which one each number comes from. The profile is the join key for the dashboard, because it is the only record that touches all three. Erasure crosses all four: deleting a profile without clearing the others is hiding, not deletion, and the dashboard must not keep showing a deleted customer in a cohort after erasure. Test the erasure path on a test account and watch the dashboard the next day.

## 6. The vendor dashboard option, honestly

If you choose Option B for a question, say so on the page: "Source: PostHog, last 28 days, free tier, 1-year retention." The vendor's limits become your footnote. PostHog Cloud free drops usage past the limit instead of billing it, so a month over 1M events silently loses data, and the dashboard will show a dip that is not a real dip. GA4 samples above 10M events per exploration query, so a sampled number is an estimate and must be labeled as one. Mixpanel free is 1M events a month as of Nov 8, 2026, and the old 20M figure still circulating in articles and in this repo's decision doc is outdated. Plausible has no free tier and starts at $9 per month for up to 10,000 monthly pageviews, with funnels and ecommerce revenue attribution at the $19 per month tier. None of these is a reason not to use the vendor. All of them are reasons to label the source.

## 7. Agent rules

- Never show a number without its denominator and date range. If either is missing, the cell shows N/A and the reason.
- Never show zero where the data is absent or the cohort is immature. N/A is the honest value.
- Never include test accounts, anonymous demos, or store installs in a signup cohort denominator.
- Never query the raw event table from a client. Admin reads go through a scoped function or a read role with row level security.
- Never add a new metric to the dashboard without writing its definition in one sentence, naming its source table, and naming its denominator.
- Never change a metric definition without noting the change on the dashboard and in the decision record. A definition that changes silently makes history unreadable.
- Never show one customer's data to another customer, and never show cross-org data to an org admin. Enforce it in the database.
- Never put PII in an event property, a filter, or a chart label.
- When a metric looks wrong, check the denominator first. Most dashboard bugs are denominator bugs: the wrong cohort, an immature window, or test accounts included.
- When the dashboard needs a new event to answer a question, add the event to the tracking plan first, as its own change, not as a side effect of the dashboard.

## 8. Fill-in checklist and decision record

- [ ] Dashboard option chosen: [own tables / vendor dashboard / BI on warehouse]
- [ ] Read endpoint built: [route], read-only [yes], no new event writers [yes]
- [ ] Cohort definition: UTC, [28] complete days by default, range [ to ], timezone stated on the page [yes]
- [ ] Maturity rules written: 24h [ ], 7-day [ ], return windows [ ], immature cells show N/A [yes]
- [ ] Test accounts excluded by default [yes], anonymous demos excluded [yes], store installs excluded [yes]
- [ ] Activation defined in one sentence: [ ]
- [ ] Retention shown as a cohort table, not a single number [yes]
- [ ] Revenue source labeled: [Stripe + RevenueCat], never added to analytics counts [yes]
- [ ] Role table enforced in the database: platform admin [ ], org admin [ ], member [ ]
- [ ] No PII in analytics: checked [yes]
- [ ] Erasure tested on a test account, dashboard checked the next day [yes / no]

**Decision record**

- Dashboard is [Option A / B / C] because [ ].
- Cohort window: [28 complete UTC days], maturity rules [as in section 3.3].
- Activation is [one sentence].
- Revenue comes from [Stripe + RevenueCat], signups from [profiles table].
- Source of truth per metric: [list each metric with its table].
- Verified Nov 8, 2026. Next verify date: [ ].
