# GA4 and Web Analytics

> Added Nov 8, 2026. All prices, limits, and rules in this file are as of Nov 8, 2026. Verify in the vendor docs or console before you buy, enroll, or ship. Analytics tools change their free tiers and limits without warning.
>
> Related docs: [Analytics Choices](../../decisions/ANALYTICS_CHOICES.md) (the vendor decision matrix, read this first for the choice, then this doc for the GA4 decisions) | [Analytics Setup](../developer/analytics-setup.md) (the code: gtag.js, the analytics service, the React hook) | [Tracking Plan](../developer/tracking-plan.md) (the event registry) | [Attribution End to End](./ATTRIBUTION_END_TO_END.md) (how a visit becomes a customer record) | [Admin Dashboard](./ADMIN_DASHBOARD.md) (what you read every week instead of GA4) | [SEO Strategy](./SEO_STRATEGY.md) (what GA4 measures) | [PLG Framework](./PLG_FRAMEWORK.md) (activation is a first-party question, not a GA4 one)

## In one minute

GA4 answers one question: where did people come from, and what did they do on your website before they signed up. That is its job, and it is good at it. It is not your product analytics. It does not tell you what people do inside your app, it does not tell you which store install came from which ad, and it does not join to your customer records. Use GA4 for acquisition on the web, use a product tool or your own first-party event table for what happens after signup, and never add the two together as if they counted the same people.

GA4 standard is free, $0, with no subscription and no traffic fee, as of Nov 8, 2026. The paid tier is GA4 360, a separate enterprise contract, reported at about $50,000 per year starting, and Google does not publish a price for it. Free does not mean unlimited. The limits that bite are set on day one and cannot be fixed backwards, so this doc starts with the day-one settings.

## 1. Plain language: the two sinks rule

CueCraft, the yoga app this template grew out of, runs two separate sinks and the rule it proved is the first rule of this doc: **name the sink per question before you count anything.**

- **GA4** is the third-party sink. It counts anonymous web visits, traffic sources, and landing pages. It knows nothing about your accounts.
- **Your own database** is the first-party sink. It counts signed-in behavior: signups, activations, payments. It knows your customers and nothing about anonymous visitors who never signed up.

A visitor who reads your landing page and leaves is a GA4 row. A customer who signs up and teaches their first class is a first-party row. The two populations overlap only at signup, and only if you deliberately join them there (see [Attribution End to End](./ATTRIBUTION_END_TO_END.md)). If you add GA4 users and database users together, you count some people twice and miss others entirely. Every question in this doc starts with "which sink answers this", and the answer is never both.

A third half-present sink is worse than two. CueCraft had PostHog scaffolding sitting in its env example with empty keys and no dependency installed, which is a tool that looks live and answers nothing. If a vendor is not wired, remove it. Wire it or remove it, there is no third state.

## 2. What GA4 is for, and what it is not for

Use GA4 for:

- Where web traffic comes from: search, social, email, referral, direct.
- Which landing pages and campaigns bring signups, measured as far as the web can see them.
- How the marketing site performs: page views, scroll, outbound clicks, video plays.
- Google Ads and Search Console integration, if you run ads or care about organic search.

Do not use GA4 for:

- What users do inside your app after signup. That is product analytics: PostHog, or your own event table.
- Revenue you can defend. GA4 sees a purchase event only if you send it one, and it has no access to your Stripe or RevenueCat records. Revenue lives in your billing system.
- Who a specific customer is. GA4 has no explicit `user_id` configuration in the CueCraft setup, and even when you set one, GA4 is not your customer record.
- Store attribution. App Store Connect and Google Play Console report downloads and sources separately, and neither joins to GA4 or to in-app behavior automatically.

## 3. The day-one settings (do these before the first real visitor)

Most GA4 mistakes are settings made once and regretted for a year. Do these on day one, in this order.

### 3.1 Create one property, one web stream

One GA4 property per product, one web data stream per site. Do not share a property across two products, and do not create a second property "just to test". Testing happens in DebugView, not in a second property. The measurement ID looks like `G-XXXXXXXXXX`. It is not a secret, but it is not a credential either: it identifies the property, and anyone who has it can send events to it, so do not publish it in screenshots and do not copy a real one from another repo. Use the placeholder in docs and the real one only in your env file.

### 3.2 Set exploration retention to 14 months immediately

GA4 exploration data retention is 2 months or 14 months. The default is 2. Set it to 14 months on day one. You cannot fix this backwards: data older than your retention setting is gone, and changing the setting later does not bring it back. This is the single most expensive GA4 setting to miss. As of Nov 8, 2026, verify the current location of the setting in the GA4 admin panel before you click, because Google moves it.

### 3.3 Budget your 30 key events

GA4 standard allows 30 key events. A key event is a conversion: the events you count as success. Thirty sounds like a lot until every team marks their favorite event as key. Pick at most 10 to start, and leave the rest empty. Your key events should be: `sign_up`, `purchase`, and the one activation event your product is built around, plus the two or three steps of your main funnel. Everything else is a regular event. If you run out of key events, you do not buy more, you re-prioritize. The full event registry lives in [Tracking Plan](../developer/tracking-plan.md).

### 3.4 Single-page apps: turn off automatic page views

If your site is a single-page app, GA4's automatic `page_view` fires once on load and then never again as the user moves between routes, because the page never reloads. The CueCraft pattern, proven in its web app, is: set `send_page_view: false` in the gtag config, and call a manual page view on every route change. If you leave automatic page views on and also fire manual ones, you double-count every route change. Check for this duplication in DebugView before launch, not after.

### 3.5 Enhanced measurement: check what it duplicates

Enhanced measurement (scrolls, outbound clicks, site search, video engagement, file downloads) is on by default in a new stream. That is fine, but check it against your own events. If you already fire a custom `outbound_link_clicked` event and enhanced measurement fires one too, you have two events for one click under two different names. Pick one source per behavior and turn the other off. The tracking plan is the list of who owns what.

### 3.6 Consent Mode, and the missing banner

GA4 includes no consent banner. None. If you serve visitors in the EU, or anywhere consent is required, you must build or buy the banner and wire it to Consent Mode V2 yourself. Consent Mode V2 passes four choices to Google tags: `analytics_storage`, `ad_storage`, `ad_user_data`, `ad_personalization`.

- **Basic mode:** tags are blocked entirely until the visitor consents. No data, no modeling. Simple, honest, and the default you should start with.
- **Advanced mode:** tags send cookieless signals before consent and Google models the missing data. More data, more complexity, and modeling is an estimate, not a count. Do not report modeled numbers as if they were counted.

CueCraft, as of its Oct 2026 review, had GA4 live with no consent gate and no analytics opt-out, and its own review flagged it: "GA's live consent signals were inactive; its health label is not proof of consent." A green health label in the console means the tag fires. It does not mean you have consent. Decide the consent gate before you expand tracking, not after. The gate is a product decision, not a code snippet: who sees the banner, what the default is, where the choice is stored, and how a visitor withdraws it. If you do not have those answers, do not add more tracking.

### 3.7 Link BigQuery on day one, or accept the 1M events per day ceiling

GA4 standard offers a daily BigQuery export, limited to 1M events per day as of Nov 8, 2026. Streaming export is unlimited but costs $0.05 per GB, about 600,000 events per GB. Link BigQuery on day one even if you never query it, because the export starts from the day you link it, not before. The BigQuery sandbox is free with limits: 10 GB storage cap, tables expire after 60 days, no streaming, 1 TB of queries per month. That is enough to learn on and not enough to rely on. If you expect more than 1M events a day, say so in your decision record and plan for streaming costs or a different sink.

Other limits to know on day one: 100 audiences, 50 event-scoped custom dimensions, and sampling above 10M events per exploration query. Sampling means GA4 answers from a subset and estimates the rest. If a number matters enough to act on, it must come from an unsampled source: BigQuery, or your own database.

## 4. How GA4 connects to PostHog (product) and to first-party events

The recommended combo in this template is GA4 for acquisition plus PostHog for product. PostHog is the product analytics tool: events, funnels, retention, session replay, feature flags. Its license is MIT core plus an `ee/` directory under a commercial license (open-core), as of Nov 8, 2026. Its Cloud free tier, resetting monthly with no card needed, is 1M analytics events, 5,000 session recordings, 1M feature flag requests, 1,500 survey responses, 100,000 error exceptions, and 10 GB logs, for one project, with 1-year event retention. Past the limits on free, usage is dropped, not billed. Above free, anonymous events cost $0.00005 each after 1M, falling with volume to $0.000009 above 250M; identified events add $0.000198 each, so an identified event costs about $0.000248 above free; recordings cost $0.005 each after 5,000. EU cloud is in Frankfurt, US cloud exists; pick at sign-up, because moving later is a migration.

Self-hosting PostHog is officially unsupported by PostHog docs, suggested only under 300,000 events per month, and paid features are Cloud-only. The existing decision doc in this repo says "self-host for unlimited" and "10M+ events, self-host, hosting costs only". Both are wrong as of Nov 8, 2026. Do not plan a self-hosted PostHog deployment on that basis. The decision doc was corrected in the same Nov 8, 2026 batch: see `decisions/ANALYTICS_CHOICES.md`, which used to list Mixpanel free as 20M events per month (verified now: 1M free, 20M is the Growth ceiling) and Plausible as pageviews only with no funnels (verified now: funnels and ecommerce revenue attribution exist at the $19 per month tier). The corrected figures are listed in the decision record at the end of this doc.

How the three pieces connect:

1. **The web tag (GA4)** fires on the marketing site and the landing page. It answers acquisition.
2. **The product SDK (PostHog)** fires inside the app. It answers behavior. The same event names go to both where they overlap, so a funnel step means the same thing in both tools. The analytics service abstraction in [Analytics Setup](../developer/analytics-setup.md) is how you keep one `trackEvent` call that fans out to both.
3. **The first-party event table (your database)** receives the events that must never be lost or sampled: signup, activation, payment. CueCraft's pattern is the model: a single source of truth for event names (`shared/analyticsEvents.ts`, 31 client-postable names enforced against a 44-event database union), a POST endpoint (`POST /api/analytics/events`) that validates the event name against an allowlist and bounds the metadata, and server-derived events (`signup_completed`, `first_flow_generated`, `user_activated`, `upgrade_completed`) that the client is never allowed to post, because the endpoint is unauthenticated and a client could fake a purchase. The drift lesson is worth copying verbatim: before the allowlist module existed, the client type and the server whitelist drifted, the client swallowed non-2xx responses, and events were silently lost with an HTTP 400 nobody saw. Two events were lost this way. Your event pipeline needs a loud failure for a rejected event, not a silent one.

A first-party table is also the only sink that survives a vendor going away. GA4 and PostHog are rented. Your database is yours. If you can afford only one sink, make it the first-party table and add GA4 for acquisition second.

## 5. DB choices for analytics: where the events live

You have three places to put analytics data, and the choice is about ownership and volume, not about fashion.

### 5.1 Your app database (first-party event table)

Events live in the same database as your customer records, in an insert-only table: rows are written once and never updated. TeacherTree is the smallest honest version of this in the family: an allowlisted set of 16 events, a sanitizer that drops unrecognized keys and strings over 40 characters (60 for a handle) and anything containing `@`, `/`, or `:`, a UUID per event for dedup, insert-only writes, and silent failure so analytics never breaks a teacher's flow. No third-party SDK at all.

This is the right first choice for most apps in this template. It is cheap, it is yours, and it answers the questions you will actually ask in year one. Its limits are volume and querying: a Postgres table with millions of rows needs indexes on the columns you filter by, and a retention policy with a real purge job. TeacherTree's migration comment promises 400-day retention with no purge job or scheduling behind it. A retention target in a comment is not a retention system. Do not claim automatic deletion until the operating job and a readback are verified.

### 5.2 A warehouse (BigQuery, or your Postgres as the warehouse)

A warehouse is where events go when the app database gets too big to query comfortably, or when you want GA4's raw export next to your first-party events. GA4's BigQuery export is the cheap path in: daily export up to 1M events, streaming above that at $0.05 per GB. If you go this way, the warehouse is a copy, not the source of truth. The source of truth stays the first-party table, and the warehouse is where you join GA4's anonymous visits to your own events for analysis, never for per-person decisions.

### 5.3 The vendor (PostHog Cloud, Mixpanel, GA4 itself)

The vendor holds the data and gives you the dashboards. This is the fastest path and the least owned. PostHog Cloud free is 1M events a month with 1-year retention, then usage is dropped, not billed, which means a quiet month over the limit silently loses data. Mixpanel free is 1M events a month as of Nov 8, 2026, with 10,000 session replays, unlimited seats, no card, and 10 feature flags. Plausible has no free tier: Cloud starts at $9 per month for up to 10,000 monthly pageviews, $14 per month for up to 3 sites, $19 per month for up to 10 sites with funnels and ecommerce revenue attribution, with a 30-day trial and no card. Its self-hosted version is open source and free to run; verify the license SPDX in its repo before naming the license in your own docs.

The rule that decides between them: if the question is "where did they come from", the vendor is fine. If the question is "did this customer pay, and what did they do before they paid", the answer must come from a sink you own.

### 5.4 Supabase as the analytics database: free vs Pro, and the pause rule

Supabase is the database this template uses most, and its license is Apache-2.0, as of Nov 8, 2026. Free is $0: 2 active projects per organization, 500 MB database per project, 50,000 monthly active users shared across the org, 5 GB egress per month, 1 GB file storage, 500,000 edge function invocations per month, 200 realtime concurrent connections. Pro starts at $25 per month per organization plus compute per project: 8 GB disk per project then $0.125 per GB, 100,000 MAU then $0.00325 each, 250 GB egress then $0.09 per GB, 100 GB storage, and a $10 per month compute credit that covers one Micro instance. Spend cap blocks metered overage by default on Pro.

The rule for the docs, and for your decision record: **Free is for building and validating. A product paying customers rely on belongs on Pro. Never run production customer records on a free project that can pause.** Free projects pause after 1 week without activity and must be restored manually. A paused project does not answer queries, does not receive events, and does not tell your users why. There are no automatic backups on Free. If your analytics events and your customer records live in the same Supabase project, and they should at the start, that project is production the day your first real customer signs up.

For the analytics tables specifically: put events in their own schema or their own tables, not mixed into your customer tables. Enable row level security on them, with insert-only policies for the event writer and read policies that only your admin role can use. Never let a client read the raw event table. TeacherTree's pattern is the model: clients cannot read the raw table, and per-teacher stats come from a security-definer function scoped to the signed-in teacher. See [Supabase Setup](./SUPABASE_SETUP.md) for the project and RLS setup this builds on.

## 6. Why GA4's web tag does not belong in a native app

This is the question the whole "probably not the app" instinct is about, and the answer is App Store rules, not taste.

GA4's web tag is a website tag. Putting it in a native iOS or Android app means sending app behavior to a third-party advertising company, and both stores treat that as a disclosure and consent question, not a technical one.

- **App Tracking Transparency (ATT), iOS 14.5 and later:** tracking means linking user or device data from your app with data from other companies' apps, websites, or offline properties for targeted advertising or advertising measurement, or sharing it with data brokers. An analytics SDK that repurposes the data it collects to enable targeted advertising in other developers' apps counts as tracking even if you do not use it for that. If your SDK counts, you must ask the user first, and most users say no.
- **Privacy nutrition labels** must match actual behavior, including every SDK. If the label says one thing and the SDK does another, that is a rejection or a post-launch removal under Guideline 5.1.1.
- **Privacy manifests** (`PrivacyInfo.xcprivacy`) are required for commonly used third-party SDKs. You must declare what the SDK collects and why.
- **IDFV** (identifier for vendor) may be used for analytics across apps from the same provider without ATT. That is the identifier you already have; do not reach for the advertising identifier instead.
- **Firebase Analytics** counts as Usage Data and as third-party sharing, because the data goes to Google. Declare it. If you use Firebase Analytics as the in-app alternative to GA4, which is the natural choice since it is the same Google backend with a native SDK, the label and the manifest must say so.

The practical consequence, proven across the CueCraft family: in-app product analytics belongs in a first-party event table or in a vendor SDK chosen with the label and manifest in mind. CueCraft iOS does exactly this: no product analytics SDK at all, and its native app posts events to the web backend's first-party pipeline, so rows land in the same tables as the web events. The GA4 web tag stays on the web. App Store Connect and Google Play Console give you store attribution, downloads and sources, separately from in-app behavior, and the two do not join automatically. That gap is the subject of [Attribution End to End](./ATTRIBUTION_END_TO_END.md).

The honest "none" decision is also a valid decision. Three apps in the family run no analytics by design: one removed its network permission entirely, one froze a `remoteAnalytics: false` feature gate, one has no backend at all. If you choose none, document the absence with evidence, say how questions get answered instead (interviews, a voluntary study), and name the gate for changing it: a product decision, a privacy review, a store disclosure update. "No analytics" written down beats "analytics" that was never wired. CueCraft iOS proved the failure mode: Sentry was installed in `package.json` with no `init`, no DSN consumer, and no capture call, so crash reporting looked present and was not. An installed dependency is not a wired integration.

## 7. What GA4 cannot tell you

Say this list out loud before you promise anyone a number from GA4:

- **It cannot tell you which ad or post caused a specific signup.** GA4 attributes sessions, not people, and its attribution is modeled. The first-party join at signup is the only per-person answer, and it lives in your database.
- **It cannot tell you what happened in the app.** No in-app events, no activation, no retention. Those are first-party or PostHog questions.
- **It cannot tell you revenue you can defend.** Revenue is Stripe, RevenueCat, or your own billing table. GA4 purchase events are a shadow of that, and a shadow that can be faked by a client.
- **It cannot tell you anything older than your retention setting.** Two months by default, 14 months if you set it on day one.
- **It cannot tell you anything about a visitor who declined consent** in basic Consent Mode, and it can only model them in advanced mode. Modeled is not counted.
- **It cannot tell you store installs.** That is App Store Connect and Play Console, and the iOS side does not join per person.
- **It cannot tell you that a missing `utm_source` means direct traffic.** CueCraft's review says it plainly: missing or empty `utm_source` is unattributed, not proven direct traffic. Label it "unattributed" and move on.

## 8. Expert detail: the setup checklist in order

1. Property and stream created, one per product. Measurement ID in env only, placeholder `G-XXXXXXXXXX` in docs.
2. Retention set to 14 months. Verified by reading the setting back, not by remembering you set it.
3. Key events chosen, 10 or fewer, matching the tracking plan. The rest are regular events.
4. SPA page views manual, automatic off. Verified in DebugView: one page view per route change, no doubles.
5. Enhanced measurement audited against custom events. One source per behavior.
6. Consent Mode decided (basic to start), banner built, default and withdrawal defined. The decision is written down, not just coded.
7. BigQuery linked. Daily export on. Sandbox limits noted: 10 GB storage, tables expire after 60 days, no streaming, 1 TB queries per month.
8. PostHog or first-party table decided for product analytics, and the event names shared between sinks.
9. First-party endpoint allowlisted, server-derived events blocked from clients, rejected events logged loudly.
10. No vendor left half-wired. Every SDK in `package.json` has an init call, or it is removed.
11. Dashboard that answers "where did they come from" exists in GA4, and the admin dashboard answers "did they stay and pay" from your own data. Neither pretends to answer the other's question.

## 9. Agent instructions

- Never copy a real GA4 measurement ID, PostHog key, or any credential from another repo. Use `G-XXXXXXXXXX` and `phc_your_project_api_key` in docs and examples.
- Never add a new event without adding it to `docs/developer/tracking-plan.md` first, and never add it to the tracking plan without naming its sink: GA4, PostHog, first-party, or more than one, with the reason.
- Never mark an event key in GA4 without checking the count of key events used so far. The limit is 30 and it is shared.
- Never present a GA4 number without its date range and its retention setting. A number older than retention is not a number, it is a guess.
- Never report modeled data as counted data. If Consent Mode advanced is on, say which numbers are modeled.
- Never install an analytics dependency without wiring its init call in the same change, and never leave a vendor half-wired.
- Never change a retention setting, a key event, or a consent default without a human approving the change in writing. These are decisions, not config.
- When you find a stale figure in `decisions/ANALYTICS_CHOICES.md`, correct it with the as-of date and the source, do not silently edit the number. The known stale figures as of Nov 8, 2026 are: Mixpanel free 20M (correct: 1M, 20M is the Growth ceiling), PostHog self-host for unlimited (correct: self-hosting officially unsupported, paid features Cloud-only), GA4 free unlimited (correct: 14-month retention, 30 key events, BigQuery daily export 1M events per day), Plausible pageviews only with no funnels (correct: funnels and ecommerce revenue attribution exist at the $19 per month tier).

## 10. Fill-in checklist and decision record

- [ ] GA4 property created: property name [ ], measurement ID in env only [ ]
- [ ] Exploration retention set to 14 months on [date], verified by reading it back [ ]
- [ ] Key events chosen (10 or fewer): [list them]
- [ ] SPA page views: automatic [off], manual on route change [on], verified in DebugView [ ]
- [ ] Enhanced measurement audit done: duplicate events removed [list them]
- [ ] Consent Mode: [basic / advanced], banner [built / bought / not needed because ], default [ ], withdrawal path [ ]
- [ ] BigQuery linked on [date], daily export [on], streaming [off / on, cost noted]
- [ ] Product analytics sink: [PostHog Cloud / first-party table / both], event names shared [yes / no]
- [ ] First-party endpoint: allowlist [yes], server-derived events blocked [yes], rejected events logged loudly [yes]
- [ ] Half-wired vendors removed: [list removed SDKs]
- [ ] Native app analytics: [first-party pipeline / Firebase Analytics / none, with label and manifest updated]

**Decision record**

- GA4 is for [acquisition on the web]. Product analytics is [PostHog / first-party table]. Revenue is [Stripe / RevenueCat / billing table].
- Analytics database: [app DB first-party table / warehouse / vendor], on [Supabase Free for building / Supabase Pro for production].
- Native app: GA4 web tag [not used in the app because ], in-app analytics is [first-party pipeline / Firebase Analytics / none].
- Stale figures corrected in `decisions/ANALYTICS_CHOICES.md`: Mixpanel free [1M], PostHog self-host [unsupported], GA4 limits [noted], Plausible funnels [exist at $19 tier].
- Verified Nov 8, 2026. Next verify date: [ ].
