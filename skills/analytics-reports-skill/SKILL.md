---
name: analytics-reports
description: Build the critical report set a marketer and a PLG product manager need, in GA4 (acquisition, landing, intent, broken pages) and a product analytics tool like PostHog (onboarding, activation, conversion, retention, errors). Covers the GA4 admin baseline, key events, custom dimensions, channel groups, Explorations, Library collections, alerts, a Looker Studio roll-up, PostHog dashboards, the shared event taxonomy, and a browser-agent (Cowork) setup prompt. Load for "set up GA4 reports", "what dashboards do we need", "funnel/retention/activation reporting", or any analytics console setup across one or many apps.
---

# Analytics Reports Skill

Stack-agnostic. Works for one product or a portfolio of many. Read once, then
run the phases in order. Knowledge current as of late 2026; anything marked
**verify** moves often in Google's UI, so check the official help page first.

The install side (tags, SDKs, consent) is `docs/developer/analytics-setup.md`
and the event names are `docs/data/DATA_TAXONOMY.md`. This skill is about what
to **report** once events flow, and how to set the consoles up so the reports
are trustworthy.

Private specifics (property ids, measurement ids, per-app event maps) never go
in this public file. Keep them in a private analytics repo or in each app repo.

---

## 0. Ground rules

1. **Split the job by tool, on purpose.** GA4 sees the marketing site: where
   people came from, what they read, whether they showed intent (store click,
   signup click, waitlist). The product tool (PostHog) sees the product:
   onboarding, activation, paywall, purchase, retention. Do not force in-app
   funnels into GA4 and do not put marketing attribution only in PostHog.
2. **Privacy first.** No PII, content, transcripts or free text in event
   properties. Enums and ids only. Honour consent (Consent Mode v2, DNT, GPC).
   A product that promises on-device processing sends no content, ever.
3. **Reports are only as good as the event names.** Before you build a single
   report, map the real event names from the code (grep the analytics module).
   Never invent an event in a report spec that the code does not send; list it
   as a code follow-up instead.
4. **The agent does the clicking.** A browser agent can do every console step.
   It stops only for a password, 2FA, or anything that costs money. Never
   create a paid product, plan, or integration tier.
5. **One property per product, not per page.** A studio or parent site that
   hosts many product pages is one property with an `app` dimension.

---

## 1. Inventory first (30 minutes, saves days)

For every product, record in a table:

| Field | Where to find it |
|---|---|
| Domain(s) and whether it is an SPA | hosting config, router |
| GA4 property id, web stream, measurement id | GA4 Admin > Data streams |
| Which Google account owns the property | GA4 Admin > Account access |
| Where the measurement id is set in code (env var or constant) | grep `G-` and `GA4` |
| Which routes send GA4 at all (often marketing-only) | analytics module |
| Product tool project and the `app` value the product sends | SDK init |
| Billing provider and whether it forwards events (RevenueCat, Stripe) | integrations page |
| Real event names and their properties | grep the analytics module |

Mismatches found here (an id in code that points to no property, a property
with no stream, a page list missing a product) are your first fixes.

---

## 2. GA4 admin baseline (every property)

| Setting | Value | Why |
|---|---|---|
| Data retention | 14 months | Default 2 months kills year-over-year Explorations |
| Google signals | Off | Thresholding hides small numbers; no ads use |
| Enhanced measurement: page changes on history events | **Off for SPAs that send a manual `page_view`** | Otherwise double page views |
| Enhanced measurement: outbound clicks | Off when the site sends its own `outbound_click` | Duplicates |
| Enhanced measurement: scrolls, site search, file downloads, form interactions | On (cheap signal) | |
| Internal traffic filter | Define rule, set filter to Active | Owner traffic pollutes small sites |
| Unwanted referrals | Payment and auth hosts (checkout and billing pages, OAuth providers, auth backend) | Otherwise "referral: stripe.com" steals conversions |
| Search Console link | Linked to the verified domain property | Queries and landing pages report |
| Key events | The intent events only (see 3) | Too many key events makes "conversions" meaningless |

**Verify** the exact menu names; Google renames them yearly.

---

## 3. Key events and custom dimensions

Key events (mark as key events in Admin > Events once each has fired once, or
create them in advance under Admin > Key events > New key event):

- `store_click` (App Store or Play button), the main intent signal for apps
- `sign_up` or `signup_click` for web products with signup on the site
- `waitlist_signup` for pre-launch pages
- `generate_lead` / `contact_click` for B2B or studio products
- `purchase` only when a web checkout actually completes on the site

Event-scoped custom dimensions to register (only for parameters the code
really sends; registering an unused one wastes a slot of 50):

| Dimension | Parameter | Use |
|---|---|---|
| App | `app` | Portfolio sites and shared properties |
| Store | `store` | ios vs android intent |
| Placement | `placement` | which button or section converted |
| Link host | `host` | outbound destinations |
| CTA | `cta` | which call to action |
| Method | `method` | signup method |

Dimensions only populate from the day they are registered. Register first,
report later.

---

## 4. Custom channel group

Default channel grouping lumps QR codes, partners and AI assistants into
"Referral" or "Unassigned". Create one custom group, copy the defaults, add
these channels **above** the defaults, and set it as primary:

| Channel | Rule |
|---|---|
| QR | medium exactly matches `qr` |
| Partners | source starts with `partner-`, or medium is `embed` |
| App stores | source contains `apps.apple.com` or `play.google.com` |
| Own network | source matches your own domains |
| AI assistants | source matches `chatgpt|perplexity|claude|gemini|copilot` |

This only works if UTMs are consistent: lowercase, underscores,
`utm_medium=qr` on every printed code, `partner-<name>` sources.

---

## 5. The GA4 report set (marketer view)

Build these per property. Explorations cannot be copied between properties,
so a browser agent repeats them; name them identically everywhere so anyone
can find them.

**Explorations**

1. **Acquisition to intent funnel** (Funnel exploration, open funnel):
   `session_start` or `page_view` > landing page view > intent event
   (`store_click` / signup / waitlist). Breakdown: session default channel
   group (custom group from 4). Answers "which channel brings people who act".
2. **What led to the click** (Path exploration, backwards from the intent
   event). Answers "which pages earn the click".
3. **Landing pages by channel** (Free form: rows landing page + query string,
   columns session primary channel group, values sessions, engaged sessions,
   key events, session key event rate). Heatmap cell formatting.
4. **Broken pages** (Free form: page title and page path filtered to the 404
   title, or an explicit `page_not_found` event; rows page path, page
   referrer). Answers "who links to dead pages".
5. **Content cohort** (Cohort exploration, acquisition date by week, return
   criterion any event). Only for content-heavy sites.

**Library collection** ("Growth", published to the left nav):

- Detail report: intent events by `app`, `store`, `placement`
- Detail report: campaigns (session source / medium / campaign) with key events
- Detail report: landing pages with engagement rate and key events
- Built-in: Search Console queries and landing pages (after the link)
- Built-in: Tech > overview (device, browser) for layout bugs

**Custom insights (alerts)**, emailed weekly:

- Intent events down more than 50% week over week
- Broken-page views above a small threshold

**Looker Studio roll-up (one dashboard for the portfolio)**: one report with a
GA4 data source plus a data-source control, so the viewer switches property
from a dropdown. Pages: Overview (users, sessions, engagement rate, key
events, trend), Channels, Landing pages, Intent by app and store, Broken
pages. Free. Requires the viewer's Google account to have Viewer on each
property, so grant that first.

---

## 6. The product report set (PLG PM view, PostHog)

One project per family of products is fine when every event carries an `app`
super property; filter every insight on it. Build one template dashboard,
then duplicate it per product and change the filter.

Standard taxonomy this assumes (rename to yours):

| Stage | Event | Notes |
|---|---|---|
| First run | `app_opened` with `first_open=true` | install proxy |
| Signup | `signup_completed` | `method` |
| Onboarding | `onboarding_started`, `onboarding_completed` | |
| Activation | `activation_reached` | `action` names the aha moment, sent once |
| Core use | `key_action` | `action` enum |
| Virality | `share_created` | `surface` enum |
| Monetization | `paywall_viewed`, `purchase_started`, billing events | `placement`, `product_id` |
| Errors | `error_shown` or exception capture | `code` enum only |

Super properties on every event: `app`, `app_version`, `platform`,
`install_source`, `install_campaign`, `schema_version`.

**Dashboard: "<Product> PLG"**

1. **Activation funnel**: `app_opened (first_open)` > `signup_completed` >
   `onboarding_completed` > `activation_reached`. Conversion window 7 days.
   Breakdown `platform`. The single most important chart.
2. **Time to activation**: same funnel, "time to convert" view, median.
3. **Retention**: start `activation_reached`, return `key_action`, weekly,
   8 weeks. Retention on `app_opened` is a weaker fallback.
4. **Engagement**: WAU (unique users, `key_action`), and `key_action` count
   broken down by `action`.
5. **Monetization funnel**: `paywall_viewed` > `purchase_started` > first
   purchase event from the billing integration. Breakdown `placement`.
6. **Acquisition quality**: new users by `install_source` / `install_campaign`,
   and the activation funnel broken down by the same. This is the bridge back
   to the marketer's GA4 view.
7. **Shares**: `share_created` by `surface`, and shares per activated user.
8. **Issues**: error events by `code`, funnel drop-off step list, and the
   biggest-drop step called out in the dashboard description.

**Billing events**: RevenueCat, Stripe and others can forward purchase,
trial, renewal and cancellation events to PostHog. Check whether the
integration is included in the current plan before enabling; if it is paid,
stop and ask.

---

## 7. Issue finding, the part everyone skips

- **Drop-offs**: the step with the biggest absolute loss in the activation
  funnel is next sprint's work. Write it down weekly.
- **Errors**: product errors as an enum event (or exception capture with
  scrubbing). Crash tools (Sentry) for stack traces, not for counts.
- **Broken pages**: either a 404 page with a unique title, or an explicit
  `page_not_found` event with `page_path` and `page_referrer`. SPAs need the
  event; a client-side 404 page never returns a 404 status.
- **Slow pages**: GA4 does not measure speed well. Use Vercel Speed Insights,
  CrUX or PageSpeed for Core Web Vitals; link them from the dashboard.
- **Tracking health**: a weekly check that each key event fired at all. A
  silent zero is usually a broken tag, not a bad week.

---

## 8. Running it with a browser agent (Cowork)

Write one self-contained prompt. It must include:

1. Which browser and profile, one tab, closed at the end.
2. The inventory table with ids, so the agent verifies before it changes.
3. Exactly which Google account owns which property (switch accounts in the
   account menu, never sign out of the main one).
4. The admin baseline, key events, dimensions and channel group, per property.
5. Every Exploration and Library report with exact names, dimensions and
   metrics, so the result is identical across properties.
6. The product dashboard spec, with the `app` filter per product.
7. Stop rules: password, 2FA, any price, any "upgrade", any terms of service.
8. A checkpoint file it updates after each property, so a second run resumes.
9. A final report: per property, what was created, what was skipped and why,
   and any measurement ids it found or created.

Keep code changes out of the browser prompt. Missing events, tags and ids
belong in draft PRs in the product repos.

---

## 9. Done means

- [ ] Every product has a property or a deliberate "no analytics" note
- [ ] Baseline, key events and dimensions set on every property
- [ ] The five Explorations and the Growth collection exist with identical names
- [ ] Looker Studio roll-up switches across all properties
- [ ] Product dashboard per product, filtered on `app`
- [ ] Code follow-ups filed for every event a report needs but the code lacks
- [ ] Private specifics recorded in the private repo, not here
