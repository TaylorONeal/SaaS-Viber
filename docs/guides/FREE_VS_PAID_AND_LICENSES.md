# Free vs Paid and Licenses

> Added Nov 8, 2026. Every price, limit, and rule in this file is as of Nov 8, 2026. Verify on the vendor pricing page before you buy, enroll, or ship. Prices and free tiers change, and a figure that was true in November may not be true when you read this.
> Companion docs: `decisions/ANALYTICS_CHOICES.md` (which vendor, corrected Nov 8, 2026, with as-of notes in that file), `docs/guides/ANALYTICS_DATABASES_AND_CUSTOMER_RECORDS.md` (where the data lives), `docs/architecture/ANALYTICS_ARCHITECTURE.md` (dashboards), `docs/developer/analytics-setup.md` (install steps), `decisions/BACKEND_CHOICES.md` (backend options), `docs/guides/SUPABASE_SETUP.md` (Supabase setup).

## In one minute

Free tiers are real, and they are not production plans. Every tool in this guide gives you something for free, and every one of them takes something away when you outgrow it, or when you stop using it, or when you need the feature that only the paid tier has.

The rule is short: build and validate on free, run paying customers on paid. A free Supabase project pauses after 1 week without activity and must be restored by hand. Free PostHog drops usage over the limit instead of billing you for it, so your dashboard quietly loses data. GA4 keeps your data for 14 months at most, then it is gone, and you cannot fix that backwards.

Read the table for the tool you are considering, check the license section before you rely on self-hosting, and fill in the cost projection at the end with your own numbers before you commit.

## 1. Plain language: what free means

A free tier is a sample, not a plan. It exists so you can learn the tool and prove your idea. It comes with three kinds of limit, and you need to know which kind you are on:

- A usage limit: you get this much per month, then it stops, or you start paying. PostHog free gives you 1M events a month, then drops the excess. Mixpanel free gives you 1M events a month, then you are on usage pricing.
- A time limit: your data expires. GA4 keeps exploration data for 2 or 14 months. PostHog Cloud free keeps events for 1 year. Supabase free has no automatic backups at all.
- A feature limit: the thing you need lives behind the paid tier. PostHog's paid features are Cloud-only. Plausible funnels live at the $19 tier. Supabase automatic backups live on Pro.

None of these limits is a trap. All of them are a decision you make on purpose, once, instead of discovering them during launch week.

## 2. One table per tool

### 2.1 GA4 (Google Analytics 4), standard

| | Free (standard) | Paid (GA4 360) |
|---|---|---|
| Price | $0, no subscription, no traffic fee, no trial | Separate enterprise contract, reported about $50,000 per year starting. Google does not publish a price. Verify before you budget. |
| What you get | Web traffic and acquisition, campaign attribution, Search Console link, BigQuery daily export | Unsampled data, higher limits, enterprise support |
| Limits that bite | Exploration data retention 2 or 14 months (set 14 on day one, cannot fix backwards); 30 key events; 100 audiences; 50 event-scoped custom dimensions; sampling above 10M events per exploration query; BigQuery daily export 1M events per day | Higher limits, exact numbers in the 360 contract |
| BigQuery streaming export | Unlimited, but $0.05 per GB (about 600,000 events per GB) | Same mechanism, priced in the contract |
| BigQuery sandbox | 10 GB storage cap, tables expire after 60 days, no streaming, 1 TB queries per month | Not applicable |
| Consent | GA4 includes no consent banner. Consent Mode V2 passes the visitor's choice to Google tags. Basic mode blocks tags without consent. Advanced mode sends cookieless signals and supports modeling. | Same |

GA4 is web analytics. It does not do in-app product analytics, and its web tag does not belong in a native app. See the Apple in-app note in section 4.

### 2.2 PostHog Cloud

| | Free | Pay-as-you-go (above free) |
|---|---|---|
| Price | $0, no card needed, resets monthly | Usage pricing, see rates below |
| What you get | 1M analytics events, 5,000 session recordings, 1M feature flag requests, 1,500 survey responses, 100,000 error exceptions, 10 GB logs. One project, 1-year event retention. | Same product, metered |
| Over the free limit | Usage is dropped, not billed. Your dashboard quietly loses the excess events. | Anonymous events $0.00005 each after 1M, falling with volume to $0.000009 above 250M. Identified events add $0.000198 each, so an identified event costs about $0.000248 above free. Recordings $0.005 each after 5,000. |
| Regions | EU cloud (Frankfurt) and US cloud exist. Pick at sign-up. | Same |

Worked arithmetic, from the verified rates only, not a vendor quote: 1M extra anonymous events at $0.00005 each is $50. The same 1M events, if they are identified, cost about $248. The difference is the identified-event surcharge, and it is the number that surprises teams. Measure your identified share before you budget.

### 2.3 Supabase

| | Free | Pro |
|---|---|---|
| Price | $0 | From $25 per month per organization, plus compute per project |
| What you get | 2 active projects per organization, 500 MB database per project, 50,000 monthly active users (shared across the org), 5 GB egress per month, 1 GB file storage, 500,000 edge function invocations per month, 200 realtime concurrent connections | 8 GB disk per project then $0.125 per GB, 100,000 MAU then $0.00325 each, 250 GB egress then $0.09 per GB, 100 GB storage, $10 per month compute credit (covers one Micro instance) |
| What breaks on free | Free projects pause after 1 week without activity and must be restored manually. No automatic backups. Built-in email sender limited to 2 emails per hour. | Spend cap blocks metered overage by default on Pro. Automatic backups included. |
| Rule | Free is for building and validating. A product paying customers rely on belongs on Pro. Never run production customer records on a free project that can pause. | Pro is the starting paid tier for production. |

### 2.4 Mixpanel

| | Free | Growth |
|---|---|---|
| Price | $0, no card | Growth starts at $0 for the first 1M events per month, then usage-based up to 20M events per month. About $140 per month at 1.5M events, about $120 per month billed annually. |
| What you get | Up to 1M events per month, 10,000 session replays per month, unlimited seats, 10 feature flags | Same product, metered |
| The old figure, flagged | Many older articles say Mixpanel free is 20M events per month. That is outdated. Current (Sept to Nov 2026) is 1M free. 20M is the Growth ceiling, not the free tier. If an article or a doc says 20M free, it is wrong, and this repo used to say it too. | Same warning applies in reverse: do not budget on 20M free. |

### 2.5 Plausible

| | Free | Cloud |
|---|---|---|
| Price | There is no free tier. | Cloud starts at $9 per month for up to 10,000 monthly pageviews. $14 per month up to 3 sites. $19 per month up to 10 sites with funnels and ecommerce revenue attribution. 30-day trial, no card. |
| What you get | Nothing, except the trial. | Privacy-first web analytics, no cookies, lightweight script |
| Correction | The old line in this repo said Plausible is pageviews only, with no custom events or funnels. That is outdated. Funnels and ecommerce revenue attribution exist at the $19 tier. | Check the current pricing page for the pageview limit at each tier before you buy. This file does not state pageview limits for the $14 and $19 tiers, because they were not verified. |

Self-hosted Plausible is open source and free to run. Verify the license SPDX in the Plausible repo before naming the license in your own docs. This file does not name it, because it was not verified.

### 2.6 What was not verified

These figures appear in `decisions/ANALYTICS_CHOICES.md` and were not verified in the Nov 8, 2026 check, so this file does not repeat them as fact. Check the vendor docs before you rely on them: Amplitude free tier (stated as 10M events per month in the repo), Heap free tier (stated as 10K sessions per month), Mixpanel cost at scale ($833 per month at 100M events), and any Amplitude or Heap pricing at scale. The corrections file lists each one as unverified, not as corrected.

## 3. Licenses: what you are actually allowed to do

### 3.1 The open-core pattern

Most of the tools in this guide are open-core: the core product is open source, and some features live behind a paid tier. That is a business model, not a trick, but it changes what self-hosting gives you.

- PostHog: MIT core, plus an `ee/` directory under a commercial license. Self-hosting is officially unsupported by PostHog docs, suggested only under 300,000 events per month, and paid features are Cloud-only. So self-hosting PostHog gives you the MIT core, without the paid features, without support, and without a future. Do not plan a business on it.
- Supabase: Apache-2.0 for the Supabase repo. Open source Firebase alternative, real Postgres, data exportable. Self-hosting with Docker is a real option, and the license allows commercial use. The paid tiers buy you hosting, backups, and support, not the license.
- Plausible self-hosted: open source and free to run. Verify the license SPDX in the repo before naming it. Do not copy a license name from memory.

The general rule: a license tells you what you may do with the code. A free tier tells you what you may do with the vendor's hosted service. They are different promises, and confusing them is how teams end up self-hosting a product whose best features they cannot legally run.

### 3.2 How to check a license before you rely on it

1. Read the `LICENSE` file at the root of the repo. That is the license. The README may summarize it, and the summary may be wrong.
2. Check the `license` field in `package.json`. It should match the `LICENSE` file. If it does not, ask, and do not ship on either one alone.
3. Look for an `ee/` or `enterprise/` directory. If it exists, read its license separately. The core license does not cover it.
4. Check the vendor docs for the words "self-hosting" and "unsupported". PostHog's docs say self-hosting is officially unsupported. That sentence matters more than the presence of a Docker file.
5. For a hosted service, the license is irrelevant and the terms of service are everything. GA4 is not open source. Its $0 tier is a pricing decision by Google, not a license grant, and it can change.

### 3.3 Commercial use, in one paragraph each

- PostHog core (MIT): you may use it commercially, modify it, and run it. The `ee/` directory is under a commercial license, so you may not use those features without paying. Self-hosting is unsupported, so commercial use of a self-hosted PostHog is possible and unwise at the same time.
- Supabase (Apache-2.0): you may use it commercially, modify it, self-host it, and sell a product built on it. The Apache-2.0 license requires you to keep the license notice. That is the whole obligation that matters for most teams.
- Anything else in the analytics stack (Amplitude, Heap, Mixpanel, Plausible self-hosted): check the license in the repo before you rely on it. This file does not name those licenses, because they were not verified Nov 8, 2026. Naming a license from memory is how a team ships a violation.

## 4. Why GA4 is web-first, and what that means for apps

Apple's App Tracking Transparency rule (iOS 14.5 and later) defines tracking as linking user or device data from your app with data from other companies' apps, websites, or offline properties for targeted advertising or advertising measurement, or sharing with data brokers. An analytics SDK that repurposes the data it collects to enable targeted advertising in other developers' apps counts as tracking even if you do not use it for that.

The practical consequences, as of Nov 8, 2026:

- Privacy Nutrition Labels must match actual behavior, including every SDK. Privacy manifests (`PrivacyInfo.xcprivacy`) are required for commonly used third-party SDKs. Inconsistencies trigger rejection or post-launch removal under Guideline 5.1.1.
- Firebase Analytics counts as Usage Data and as third-party sharing, because the data goes to Google. Declare it.
- IDFV (identifier for vendor) may be used for analytics across apps from the same provider without ATT.
- In-app product analytics belongs in a first-party event table, or in a vendor SDK chosen with the label and manifest in mind. GA4's web tag does not belong in a native app.
- App Store Connect and Play Console give store attribution (downloads, sources) separately from in-app behavior, and the two do not join automatically.

## 5. Fill-in cost projection (fictional yoga app, Second Mat)

Assumptions, stated so you can replace them with your own measurements. These are assumptions, not facts. Measure your real event volume before you budget.

- Events per monthly active user: 100 per month (a teacher who opens the app a few times a week and teaches from a sequence).
- Identified share on PostHog: 80% identified, 20% anonymous, once users are signed in.
- Pageviews: roughly 5 per monthly active user per month on the marketing site.

### 5.1 At 1,000 monthly active users (100,000 events per month)

| Tool | Cost per month | Why |
|---|---|---|
| GA4 standard | $0 | Within the free tier. Set retention to 14 months on day one. |
| PostHog Cloud | $0 | 100,000 events is inside the 1M free tier, identified or not. |
| Supabase | $25 | Free fits on paper (50,000 MAU, 500 MB), but production belongs on Pro. Budget Pro from day one of paying customers. |
| Mixpanel | $0 | 100,000 events is inside the 1M free tier. |
| Plausible | $9 | About 5,000 pageviews, inside the $9 tier for up to 10,000 monthly pageviews. |
| Total, GA4 plus PostHog plus Supabase Pro plus Plausible | $34 | Plus your time. No other analytics spend. |

### 5.2 At 10,000 monthly active users (1,000,000 events per month)

| Tool | Cost per month | Why |
|---|---|---|
| GA4 standard | $0 | Within the free tier. Watch the BigQuery daily export cap of 1M events per day: 1M events per month is far under it. |
| PostHog Cloud | $0 at exactly 1M, then pay-as-you-go | 1M events is exactly the free limit. One event over, and you pay. At 1.2M events, 200,000 over free: 160,000 identified at about $0.000248 each is about $39.68, plus 40,000 anonymous at $0.00005 each is $2.00, total about $41.68 per month. Arithmetic from the verified rates, not a vendor quote. |
| Supabase | $25 | 10,000 MAU is inside the 100,000 MAU included in Pro. Budget $25 plus compute over the $10 credit. |
| Mixpanel | $0 at exactly 1M | Growth starts at $0 for the first 1M events per month. At 1.5M events, about $140 per month, about $120 per month billed annually. |
| Plausible | $9, then check | About 50,000 pageviews is over the $9 tier limit of 10,000. Check the current pricing page for the tier that covers your pageviews. This file does not state that price, because it was not verified. |
| Total, GA4 plus PostHog plus Supabase Pro plus Plausible | $34 plus PostHog overage plus the Plausible tier step | At exactly 1M events, $34 per month. At 1.2M events, about $76 per month before the Plausible step. |

### 5.3 What the projection does not include

- Your time. Instrumentation, dashboard building, and retention reviews are the real cost at this size.
- Session recordings, surveys, and feature flags beyond the free allowances. PostHog recordings are $0.005 each after 5,000 per month.
- BigQuery streaming export, if you turn it on: $0.05 per GB, about 600,000 events per GB.
- Any vendor whose price was not verified. Amplitude and Heap are not in this projection, because their prices were not verified Nov 8, 2026.

## 6. Agent instructions

- Never state a price, limit, or license name that is not in the verified facts or in this file with an as-of date. If the vendor docs disagree with this file, the vendor docs win, and the agent must say so.
- Never copy a real measurement ID, key, or credential. Use placeholders (`G-XXXXXXXXXX`, `phc_your_project_api_key`).
- Never present the old Mixpanel 20M figure as current. It is the Growth ceiling, not the free tier. Correct it wherever you see it.
- Never recommend self-hosted PostHog for production. It is officially unsupported, paid features are Cloud-only, and the docs must say so.
- Never put production customer records on a free Supabase project. Free pauses after 1 week idle and has no automatic backups.
- Never name a license you have not read. "Check the license in the repo before you rely on it" is a complete answer when the license was not verified.

## 7. Fill-in decision record

- App name: [ ]
- Monthly active users now: [ ]. Projected in 6 months: [ ]
- Events per MAU per month, measured: [ ]. (Do not guess. Measure for one month first.)
- Identified share of events: [ ]%
- GA4: [standard $0 / 360]. Retention set to 14 months on day one: [Yes / No]
- PostHog: [none / Cloud free / Cloud pay-as-you-go]. Region: [US / EU Frankfurt]
- Supabase: [Free for dev / Pro for production]. Project pauses risk accepted: [No, production is on Pro]
- Mixpanel: [none / free / Growth]. Old 20M figure corrected wherever it appeared: [Yes / No]
- Plausible: [none / Cloud $9 / $14 / $19]. Funnels needed: [Yes / No, $19 tier if yes]
- Warehouse: [none / BigQuery export / other]
- Cost ceiling: [At what monthly analytics spend do we re-evaluate? $ ]
- Licenses checked in the repo for every self-hosted tool: [Yes / No, list]

## 8. Fill-in checklist

- [ ] Every price and limit in my plan carries as-of Nov 8, 2026 and a verify note
- [ ] Free tier limits understood: usage, time, and feature limits named per tool
- [ ] Production customer records are on a paid tier, not a free tier that can pause
- [ ] PostHog overage math done with the identified-event surcharge, not the anonymous rate alone
- [ ] Mixpanel 20M figure corrected to 1M free wherever it appeared
- [ ] Plausible funnels noted as a $19 tier feature, not missing
- [ ] Self-hosting decision checked against the license and the vendor's support statement
- [ ] GA4 retention set to 14 months on day one
- [ ] Cost projection filled in with measured event volume, not guesses
- [ ] No real IDs, keys, or credentials in any doc or example
