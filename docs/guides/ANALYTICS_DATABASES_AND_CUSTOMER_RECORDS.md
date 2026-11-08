# Analytics Databases and Customer Records

> Added Nov 8, 2026. All prices, limits, and rules in this file are as of Nov 8, 2026. Verify in the vendor docs before you build or buy.
> Companion docs: `decisions/ANALYTICS_CHOICES.md` (which vendor), `docs/guides/PAYMENTS_IN_APP_VS_WEB.md` (in-app vs web), `docs/architecture/ANALYTICS_ARCHITECTURE.md` (dashboard mockups and role table), `docs/prd/ATTRIBUTION_TRACKING.md` (attribution models and taxonomy), `docs/developer/tracking-plan.md` (event registry), `docs/developer/analytics-setup.md` (install steps), `docs/data/DATA_TAXONOMY.md` (classification and retention), `docs/guides/SUPABASE_SETUP.md` (Supabase setup), `decisions/BACKEND_CHOICES.md` (backend options), `docs/guides/FREE_VS_PAID_AND_LICENSES.md` (what each tier costs and what each license allows).

## In one minute

Your analytics data lives in three stores, and they must never be added together, because they count different populations.

First, your app database holds customer records: who the person is, what plan they are on, and what they bought. Second, your first-party event table holds what they did in your product, one row per event, written by your own server. Third, your vendors hold their own copies: GA4 holds web traffic, PostHog holds product events if you send them there. Each store answers different questions. The customer record answers "who pays us". The event table answers "what did they do". GA4 answers "where did they come from on the web".

The one thing that joins the three stores is the user id. One person gets one id, from the first anonymous visit, through sign-up, through the first payment, and it never changes. Attribution fields (first referrer, UTM source, medium, campaign) are captured once, at the first visit, and copied onto the customer record at sign-up. That is the whole join. Everything else in this guide is how to keep that join honest, how to keep the event table clean, and how to delete it all properly when someone asks.

## 1. Plain language: the three stores

### 1.1 Store one: customer records in your app database

This is the database your app already has. It holds the tables your product cannot run without: accounts, profiles, subscriptions, and the content users create. It is the source of truth for money and for identity. If a question is about a person (what plan, since when, did they pay, did they cancel), it is answered here, never in a vendor dashboard.

The customer record is not one table. It is four populations that look alike and must not be confused, because each has its own key and its own owner:

| Population | Where it lives | Its key | Who owns it |
|---|---|---|---|
| Auth account | Your auth provider, for example Supabase Auth `auth.users` | Auth user id | Your app |
| Profile | Your `profiles` table | Same auth user id | Your app |
| Stripe customer | Stripe | Stripe customer id | Stripe, mirrored in your subscriptions table |
| RevenueCat customer | RevenueCat | RevenueCat app user id | RevenueCat, mirrored in your entitlements table |

A person can exist in one population and not in another. A visitor who has never signed up exists in none of them. A paying customer exists in all four. A cancelled customer still exists in Stripe and in your database, with a cancelled status. Never count these populations together. Count each one where it lives, and join them only on the ids in the table above.

### 1.2 Store two: your first-party event table

This is a table in your own app database that records what people did: `signup_completed`, `first_flow_generated`, `booking_completed`, and the rest of your event list. It is the store you control completely. You decide the schema, the retention, and the deletion. It is also the store that survives a vendor change: if you stop paying PostHog, your event table still has your history.

The pattern that works, proven in the CueCraft family repos, is small and strict:

- One table for events, insert-only. Rows are never updated and never deleted except by a retention or erasure job.
- An allowlist of event names, enforced on the server. If a name is not on the list, the row is rejected.
- A sanitizer that drops properties you did not allow, and drops strings that are too long or contain characters that do not belong in an event (emails, slashes, colons).
- A UUID on every event for dedup, so a retry does not double count.
- Silent failure. If the event write fails, the user flow must still work. Analytics must never break a teacher saving a class or a customer paying.

TeacherTree runs exactly this pattern: 16 allowlisted events, allowlisted props only, sanitizer, dedup UUID, insert-only into `teachertree.funnel_events`, silent failures, no third-party SDK. It is the smallest honest funnel pipeline in the family, and the best template to copy.

Yogaflow (CueCraft web) runs the same idea at larger scale: a single source of truth for client-postable event names, enforced against the database event union, with server-derived events (`signup_completed`, `first_flow_generated`, `user_activated`, `upgrade_completed`) deliberately not accepted from clients, because the endpoint that accepts them is unauthenticated. Before that allowlist existed, the client type and the server whitelist drifted, and the tracking call swallowed non-2xx responses, so drift produced a silent HTTP 400 and lost rows. Two real events were lost that way. The lesson is in the design: one allowlist, one enforcement point, and loud logging on the server when a row is rejected, even though the client stays silent.

### 1.3 Store three: vendor data

GA4 holds web traffic and acquisition. PostHog holds product events, replays, flags, and experiments, if you send them there. These are copies, not originals. They are good at the questions they are built for, and they are the wrong place for the questions they are not. GA4 cannot tell you what a named user did inside your app. PostHog cannot tell you what your revenue is; Stripe can. Your first-party table cannot tell you how many people found you on Google; GA4 can.

Name the sink per question before you count anything. The two-sink rule from yogaflow is the discipline: GA4 and the first-party tables are separate sinks that must never be added together.

### 1.4 How the three stores join

The join is three fields, and only three:

1. `user_id`: your auth user id, once the person has an account. Before that, an anonymous visitor id stored in the browser.
2. `anonymous_id`: the browser id from the first visit, kept until sign-up, then linked to the `user_id` and never used again as the primary key.
3. Attribution fields on the customer record: first referrer, UTM source, medium, and campaign, captured at the first visit and copied onto the account at sign-up.

Tandava's attribution design states the model clearly: one visitor, one journey, frozen at conversion. Three ids: a visitor id, a profile id linked at sign-in on every browser, and a studio relationship carrying source, first-touch, and converting-touch for that studio. Links are added, never replaced. That freezing matters: if you overwrite the first touch with the latest visit, you lose the answer to "where did this paying customer first find us".

The store gap to plan around, honestly: Android install source can pass through Play Install Referrer with UTMs. iOS App Store campaign links are visible only in App Store Connect analytics, not inside the app, so iOS install source is reported from App Store Connect data, not joined per person. Do not promise a per-person iOS install join. It does not exist.

## 2. The identity model: one id from anonymous to paying

A person passes through four states. One id follows them through all four.

| State | What you know | Which id is primary |
|---|---|---|
| Anonymous visitor | Browser id, first referrer, UTMs, pages viewed | `anonymous_id` |
| Signed-up user | Auth user id, email, profile | `user_id`, with `anonymous_id` linked |
| Activated user | Core action done (see your activation definition) | `user_id` |
| Paying customer | Plan, Stripe customer id, RevenueCat id | `user_id`, with Stripe and RevenueCat ids mirrored |

Rules that keep this honest:

- Generate the anonymous id in the browser on first visit and keep it in local storage. Do not regenerate it on every visit.
- At sign-up, send the anonymous id, the first referrer, and the UTMs to the server once, with the signup request, and clear the local storage copy after the server confirms it.
- Server-derived events (signup, activation, upgrade, payment) are created by your server, never accepted from the client. A client can lie about a payment; your server cannot be tricked into recording one.
- Never store a name, email, or phone number inside an event row. Events carry ids. Names live in the profile table, joined only when a signed-in person with permission asks.
- Test accounts are excluded from every funnel and cohort by default. A dashboard that counts your own testing as activation is lying to you.

## 3. Customer records: Supabase and Neon

### 3.1 Supabase Postgres: auth, profiles, and RLS

Supabase is Postgres with auth, storage, edge functions, and realtime in one place. It is the default recommendation in `decisions/BACKEND_CHOICES.md`, and the setup is in `docs/guides/SUPABASE_SETUP.md`.

The pattern that works:

- Auth lives in `auth.users`. Do not write to it directly. Your `profiles` table holds everything else about the person, keyed by the same user id, with a row created at sign-up.
- One schema per app when several apps share a project. TeacherTree keeps its tables in a `teachertree` schema inside a shared Supabase project, so its funnel events never collide with another app's tables. Copy that: a schema per app, not a table prefix per app.
- Row Level Security on every table, including analytics tables. Clients cannot read the raw event table. Aggregates are served by a security-definer function scoped to the signed-in user, as TeacherTree does with `teachertree.my_page_stats(days)`, which returns only that teacher's own stats.
- Separate projects for development, staging, and production. Free tier is fine for staging. Production belongs on Pro, because free projects pause after 1 week without activity and must be restored manually, and have no automatic backups. See `docs/guides/FREE_VS_PAID_AND_LICENSES.md` for the numbers, as of Nov 8, 2026.

### 3.2 Neon Postgres: the yogaflow pattern

Yogaflow (CueCraft web) runs on Neon Postgres with Drizzle, and keeps two event tables, `analyticsEvents` and `usageEvents`, in the same database as the product. The web backend exposes `POST /api/analytics/events`, which validates allowed client event names and bounded metadata, verifies a bearer token, and awaits persistence. The native iOS app reuses the same pipeline: it posts to the web backend, and rows land in the same Neon tables. No vendor SDK is needed in the app for product analytics.

Copy the shape, not the code:

- Your app database holds the event table next to the product tables, so one query can join "who paid" to "what they did".
- The event endpoint validates against the allowlist and awaits the write, so a bad event is rejected loudly on the server, not lost silently.
- The native app posts to the same backend as the web app. One pipeline, two clients.

### 3.3 Choosing between them

| Question | Supabase | Neon |
|---|---|---|
| You need auth, storage, and realtime in one place | Yes, built in | No, bring your own |
| You already have auth elsewhere and want plain Postgres | Works, but you pay for features you do not use | Yes, Postgres with a good free tier for dev |
| You run several apps in one project | Yes, one schema per app | Yes, one database per app is the cleaner split |
| You need RLS so clients can read their own rows safely | Yes, RLS is the point | No, enforce in your API |
| Your analytics volume is high and you need partitioning | Possible, but plan it early | Possible, but plan it early |

The database choice matters less than the discipline: one allowlist, insert-only rows, server-derived events kept off the public endpoint, and a retention job that actually runs.

## 4. The first-party event table, in detail

### 4.1 Schema sketch (fictional yoga app, Second Mat)

This is a sketch for a fictional yoga class app called Second Mat. Replace the event names with your own from `docs/developer/tracking-plan.md`.

```sql
-- One row per event. Insert-only. No updates.
CREATE TABLE app_events (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id    uuid NOT NULL UNIQUE,          -- dedup: client retries reuse this
  user_id     uuid REFERENCES auth.users,    -- NULL until sign-up
  anonymous_id uuid NOT NULL,               -- browser id from first visit
  event_name  text NOT NULL,                 -- must be on the allowlist
  properties  jsonb NOT NULL DEFAULT '{}'::jsonb,  -- allowlisted props only
  schema_version smallint NOT NULL DEFAULT 1,
  occurred_at timestamptz NOT NULL DEFAULT now(),
  received_at timestamptz NOT NULL DEFAULT now()
);

-- Attribution captured once, copied to the account at sign-up
CREATE TABLE account_attribution (
  user_id     uuid PRIMARY KEY REFERENCES auth.users,
  first_referrer text,
  utm_source  text,
  utm_medium  text,
  utm_campaign text,
  first_seen_at timestamptz NOT NULL DEFAULT now()
);
```

Event names for Second Mat, as an example allowlist: `signup_started`, `signup_completed`, `sequence_created`, `sequence_saved`, `class_taught`, `pricing_viewed`, `checkout_started`, `payment_completed`, `subscription_cancelled`, `invite_sent`. Server-derived only: `signup_completed`, `class_taught`, `payment_completed`, `subscription_cancelled`. Everything else may come from the client, and only if it is on the list.

### 4.2 What never goes in an event

- Names, emails, phone numbers, or addresses. Events carry ids.
- Passwords, tokens, API keys, or session ids.
- Full text a user typed (class names are fine if they are short and allowlisted; free-form notes are not).
- Payment card data of any kind. That lives in Stripe, never in your database.
- IP addresses, user agent strings, or fingerprints, unless your privacy policy says so and your lawyer agrees. Tandava's server-side session capture stores none of these, and that is the posture to copy.

### 4.3 Retention and purge jobs

A retention target in a migration comment is not a retention system. TeacherTree's docs record a 400-day retention target with no purge job or scheduling behind it, and the doc is honest about that: do not claim automatic deletion until the operating job and a readback are verified.

So build the job, then claim it:

- A scheduled job, daily, that deletes event rows older than your retention target (400 days is a reasonable default; write your own number in the decision record below).
- A readback check: once a month, query for the oldest row and confirm it is inside the window.
- A separate, longer retention for conversion rows if your business needs it (Tandava's design keeps conversions 7 years and anonymous sessions 90 days; that split is a decision, not a default).
- Aggregates survive the purge. Daily counts by event and by channel are not personal data once the ids are gone, and they are what your dashboard reads.

### 4.4 When your app DB is enough, and when to add a warehouse

Your app database is enough while all of these are true:

- Your event volume fits comfortably in your database plan (see the free vs paid numbers in the companion guide).
- Your dashboard queries are aggregates over your own tables, not raw event scans.
- Nobody outside your team needs to query the data with a BI tool.

Add a warehouse when one of these becomes true:

- GA4 BigQuery export: you want raw GA4 events in SQL. Daily export is free up to 1M events per day, as of Nov 8, 2026. Streaming export is unlimited but $0.05 per GB, about 600,000 events per GB. BigQuery sandbox has a 10 GB storage cap, tables expire after 60 days, no streaming, and 1 TB of queries per month. Set the export up on day one if you think you will want it, because GA4 retention is 14 months at most and cannot be fixed backwards.
- PostHog warehouse sync: you want PostHog events joined to your customer records in your own warehouse. This is a paid Cloud feature. Check the current PostHog docs before you budget for it.
- Your analysts need a BI tool (Metabase, Looker) pointed at a warehouse, not at your production database. Never point a BI tool at production.

A warehouse is a copy, not a replacement. The app database stays the source of truth for customer records. The event table stays the source of truth for what people did. The warehouse is where you join them for analysis.

## 5. Deletion: the whole journey, not one table

When a user deletes their account, deletion must reach every store. The steps, adapted from `docs/architecture/ANALYTICS_ARCHITECTURE.md`:

1. Delete or anonymize the profile and content rows in your app database.
2. Delete or anonymize their rows in your first-party event table. Clearing the `user_id` while leaving the browser id and properties behind is partial de-identification, not deletion. TeacherTree's docs are honest that its account removal does exactly that partial job. Decide which one you are doing, and say so in your privacy policy.
3. Delete the person in PostHog, if you use it, via its deletion API.
4. Request deletion in GA4 via Google's User Deletion API.
5. Cancel the subscription and delete the Stripe customer, if there is no legal hold.
6. Log the erasure in an audit trail without any personal data in the log entry.

Write the deletion checklist into your account-deletion flow before you launch, because the stores will not delete themselves, and a user who asks for deletion and finds their events still counted is a trust failure you cannot undo.

## 6. Agent instructions

- Never write an event name that is not on the allowlist. If the feature needs a new event, add it to the allowlist, the tracking plan, and the database union in the same change, or do not ship the event.
- Never put a name, email, token, or key into an event property. If a property value looks like an email, the sanitizer drops it, and the agent must not work around the sanitizer.
- Never mark your own work done without evidence: a row in the event table, a dashboard reading from it, and a retention job with a verified readback.
- Never copy a real measurement ID, key, or credential from another repo. Use placeholders (`G-XXXXXXXXXX`, `phc_your_project_api_key`).
- Never claim a retention target is a retention system. A comment in a migration is not a job. A job with a readback is.
- Never add the three stores together. A count from GA4 plus a count from the event table is not a total. It is two different populations.
- Never invent a price, limit, or license term. Every number in these docs carries as-of Nov 8, 2026 and a verify note. If the vendor docs disagree with this file, the vendor docs win.

## 7. Fill-in decision record

- App name: [ ]
- App database: [Supabase / Neon / other, and why]
- Schema per app, or database per app: [ ]
- Event table name: [ ]
- Retention target for event rows: [ ] days. Purge job scheduled: [Yes / No]. Readback verified on: [date]
- Allowlist location (single source of truth): [file path]
- Server-derived events (never accepted from clients): [list]
- Anonymous id storage: [local storage key]
- Attribution fields copied to the account at sign-up: [first referrer, UTM source, medium, campaign]
- Vendor sinks: GA4 [Yes / No], PostHog [Yes / No, Cloud free / pay-as-you-go], other [ ]
- Warehouse: [none / GA4 BigQuery export / PostHog warehouse sync / other], added when: [trigger]
- Deletion checklist covers: app DB [ ], event table [ ], PostHog [ ], GA4 [ ], Stripe [ ], RevenueCat [ ]
- Test accounts excluded from funnels by default: [Yes / No]

## 8. Fill-in checklist

- [ ] Three stores named, and the question each one answers written down
- [ ] One user id through anonymous, signed-up, activated, and paying
- [ ] Attribution captured at first visit and copied to the account at sign-up
- [ ] Event allowlist in one place, enforced on the server
- [ ] Sanitizer drops unrecognized props, long strings, and emails
- [ ] Dedup UUID on every event
- [ ] Server-derived events not accepted from clients
- [ ] Silent failure: a failed event write never breaks the user flow
- [ ] RLS on the event table; clients cannot read raw rows
- [ ] Retention target set, purge job scheduled, readback verified
- [ ] Deletion reaches all five stores (app DB, event table, PostHog, GA4, Stripe)
- [ ] Test accounts excluded from every funnel and cohort
- [ ] No real IDs, keys, or credentials in any doc or example
