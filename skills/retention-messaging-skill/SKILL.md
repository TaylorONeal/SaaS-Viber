---
name: retention-messaging
description: Set up Apple's retention messages for auto-renewable subscriptions - the message, image or offer a subscriber sees after tapping Cancel Subscription in Apple's own cancel flow. Covers the no-code App Store Connect setup, retention offers and eligibility, App Review copy rules, the Retention Messaging API (default messages, real-time endpoint, 700 ms budget, performance test), entitlement handling and measurement. Load for "reduce churn on iOS", "retention message", "cancel flow offer", "win back subscribers who cancel", or any App Store subscription retention work.
---

# Retention Messaging Skill (Apple)

When a subscriber cancels an App Store subscription, they do it in Apple's UI,
not yours. Your app never sees the moment. Retention messages are the one place
Apple lets you speak inside that flow: after the subscriber taps **Cancel
Subscription**, Apple shows a **Confirm Cancellation** page with a "From the
developer" section holding your message, plus **Keep Subscription** and, when
configured, an offer or plan-switch button.

Knowledge current as of November 2026. Anything marked **verify** changes often;
check the official doc before relying on it. Sources are listed in section 10.

Scope: Apple auto-renewable subscriptions only. Google Play and web checkout
cancel flows are separate; see `docs/guides/WORKFLOW_AUTOMATION.md`
("Subscription Canceled - Retention Flow").

---

## 0. Ground rules

1. **Apps without auto-renewable subscriptions skip this skill.** Lifetime
   unlocks, consumables and non-renewing subscriptions have no cancel flow.
2. **Agent prepares, human submits.** The agent drafts copy, localizations,
   eligibility and the offer table, and fills the App Store Connect form up to
   **Add for Review**. The human reviews the preview and clicks submit. Offers
   cost revenue, so the price and duration are the owner's call.
3. **Never store App Store Connect passwords, API keys (`.p8`) or signing keys
   in the repo.** Same rule as every other skill.
4. **Truthful copy only.** Retention messages are store metadata and pass
   through App Review. See section 4.
5. **Start with App Store Connect, not the API.** The API needs a server that
   answers in 700 ms and access by request. Earn that complexity with data.
6. **Evidence or it did not happen.** A message is live only when App Store
   Connect shows it approved and a sandbox tester has seen it on a device.

---

## 1. Pick the path

| Path | What you get | Cost | Use when |
|---|---|---|---|
| **A. App Store Connect (no code)** | Up to 10 messages per app, text plus optional image, retention offers with eligibility rules and per-country availability, preview tool | Form work only | Default. Every app with an auto-renewable subscription should do this at launch |
| **B. Retention Messaging API** | Pick the message per subscriber in real time (tenure, usage, plan), switch-plan suggestions, signed promotional offers, bullet points, default messages per product and locale | A public HTTPS endpoint with a 700 ms production timeout, a passed performance test, access by request | You have churn data showing that different subscribers need different messages |
| **C. Subscription platform** | Path B without running the server: several subscription-management platforms host the real-time endpoint and the message editor | Platform fees, vendor lock-in for this piece | You already use one for entitlements and want targeting or experiments without new backend work |

Precedence when more than one is configured (API changelog 1.6, 2026-11-04):
real-time response from your endpoint, then the App Store Connect message, then
the API default message. Default messages fall back to the next most relevant
configured locale.

---

## 2. Path A: App Store Connect setup

**Where:** App Store Connect > Apps > (your app) > sidebar **Monetization** >
**Subscriptions** > **Retention Messaging** section > **Get Started** (first
time) or **+**.

**Roles that can do it:** Account Holder, Admin, App Manager, Marketing.

### 2.1 Limits to plan around

| Item | Limit |
|---|---|
| Messages per app | 10. Deleting one cannot be undone |
| Messages per subscription | One active message at a time. Assigning a subscription to a second message removes it from the first |
| Subscriptions per message | Unlimited |
| Retention offers | Up to 10 per subscription per billing plan type (standard, or monthly with 12-month commitment); all 10 can sit on one message |
| Image sizes | 3840 x 2160 or 5244 x 2950 pixels, from the Asset Library or uploaded |
| Reference name and offer identifier | Cannot be changed after creation |
| Devices that show messages | iOS and iPadOS 15.1+, visionOS 1+, macOS 14+ |

### 2.2 Steps

1. Create the message: unique reference name (internal only), then **Create**.
2. Header text: one line on the value of staying.
3. Body text: features, upcoming content, what stops working. **No prices or
   offers in the text** (see section 4).
4. Localize: switch locale from the language menu at the top of the page.
   Cover **every storefront where the subscription is sold**. Missing locales
   are the most common gap.
5. Optional image in the Image section. Shown when there is no offer or the
   subscriber is not eligible for one.
6. **Subscriptions & Offers** > **Choose Subscriptions and Offers**: attach the
   subscriptions this message covers.
7. Optional retention offer per subscription (**Add Retention Offer**):
   - Reference name and offer identifier (permanent; the identifier shows up in
     Sales and Trends and in StoreKit transactions, so make it readable, for
     example `retain_monthly_50pct_3mo`).
   - **Paid Subscription Duration**: minimum paid tenure before the offer
     appears. Use it to keep trial users and brand-new subscribers out.
   - **Wait Between Offers**: cooldown per offer. It applies to each offer on
     its own, not across the subscription, so a subscriber eligible for two
     offers can get the second without waiting.
   - Countries or regions.
   - Type: Pay as you go, Pay up front, or Free; duration; price. App Store
     Connect converts prices for other regions; adjust where needed.
8. Use the preview tool on the right: card view, iPhone and iPad, each
   subscription, each offer, and **None** (the ineligible version).
9. **Add for Review**. Status reference: App Store Connect Help >
   Reference > Retention message statuses.

### 2.3 Editing a live message

Editing an approved message creates a new draft next to the published version.
The published version keeps showing until the draft is approved, then it is
replaced. **There is no rollback.** Sandbox testers always see the newest
draft, so sandbox checks reflect what you are about to ship, not what is live.

### 2.4 What to put in the first message

A starter set that works for most SaaS apps:

| Subscription | Message angle | Offer |
|---|---|---|
| Monthly | Concrete features they use, and what stops working | Optional, paid tenure at least 2 to 3 months |
| Annual | Upcoming roadmap or content they would miss | Usually none; consider a cheaper tier via the API later |
| Any | Data reassurance: what happens to their data after the end date | None |

Keep the first version simple. Measure for a full billing cycle before adding
offers or moving to the API.

---

## 3. Path B: Retention Messaging API

Access is by request (Apple Developer > Contact > Request access to the
Retention Messaging API; the Account Holder submits it). **Verify** access
status before planning work around it.

### 3.1 Moving parts

| Piece | What it does |
|---|---|
| Upload Image / Upload Message | Uploads content. Apple checks it; only `APPROVED` items can be shown. Messages have header and body text, optional image reference, optional bullet points and header position |
| Configure Default Message | One per product per locale. Text messages only (with or without image or bullets) |
| Get Retention Message (your endpoint) | Apple calls it when an active subscriber opens a subscription details page with a Cancel button. Request is a signed JWS (`signedPayload`) with the original transaction id, locale, environment and signed date |
| Initiate Performance Test | Runs in sandbox. You must pass before you can set the production URL |
| Configure Realtime URL | Sets sandbox and production endpoint URLs |

Recommended API domains since 2026-05-05: `api.storekit.apple.com` and
`api.storekit-sandbox.apple.com` (old `itunes` domains still work).

### 3.2 Real-time endpoint rules

1. **Answer in under 700 ms in production** or Apple times out and falls back.
   Aim for under 200 ms. No cold starts on the hot path: pick a runtime that
   stays warm, precompute per-subscriber decisions, and read from a cache.
2. **Verify the JWS signature** on every request before trusting any field.
3. **HTTPS with a valid certificate, TLS 1.2+.**
4. **Return only `APPROVED` message ids.** Since API 1.6 the id can also be an
   App Store Connect message.
5. **Switch-plan:** the suggested product must be in the **same subscription
   group**. Use text-only messages (no image).
6. **Promotional offer:** your server signs the offer and returns the signature
   with the message id. Text-only message. Offer created in App Store Connect
   first.
7. **Fail safe:** if anything is slow or uncertain, return nothing. Apple uses
   the App Store Connect message, then the default.
8. Log the decision (message id, offer, latency) keyed by original transaction
   id, with no extra personal data. Follow `skills/privacy-skill/SKILL.md`.

### 3.3 Rollout order

1. Upload messages and images, wait for `APPROVED`.
2. Configure a default message for every product in every sold locale.
3. Build the endpoint; point the **sandbox** URL at it.
4. Run the performance test until it passes.
5. Set the production URL.
6. Start with one targeting rule (for example, tenure under vs over six months)
   before adding more.

---

## 4. Copy rules (App Review rejects these)

- **No prices or offer details in header or body**: no "$9.99", "50% off",
  "one month free". Every subscriber sees the text, including those not eligible
  for the offer. The offer card carries the price.
- **Factual loss statements are fine**: "After your subscription ends, you
  won't have access to premium features."
- **No coercion or scare claims**, including soft versions ("your device may be
  more exposed").
- **No unverifiable superlatives or statistics** ("the best app", "92% of users
  improved").
- Standard capitalization and punctuation. No all caps, no stacked exclamation
  marks.
- Accurate and current. If a feature is removed or gated, update the message in
  the same release (see lesson 105).

Write two or three variants per message and keep the losers for later tests.

---

## 5. Billing and entitlement checks

Before the first offer goes live, add these to the billing reconciliation in
`docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` section 5.1:

| Check | Why |
|---|---|
| Server and webhook handler accept a renewal that carries an offer (offer type and offer identifier on the transaction) | A redeemed retention offer is a discounted renewal. A strict parser that rejects unknown offer types can drop the entitlement of the subscriber you just saved. **Verify** field names in App Store Server Notifications docs |
| Plan switch updates the entitlement to the new product | Switch-plan changes the product within the group |
| Analytics separate "retention offer redeemed" from normal renewal | Otherwise the save rate is invisible |
| Paywall and web pricing pages unaffected | Retention offers live only in the cancel flow |
| Offer identifier recorded in the launch tracker | It is permanent and appears in reports |

---

## 6. Testing

1. Sandbox Apple Account on a real device running iOS 15.1 or later.
2. Buy the subscription in sandbox, then open Settings > [name] >
   Subscriptions > (app) > **Cancel Subscription**.
3. Confirm: message text per locale, image (ineligible path), offer card
   (eligible path), Keep Subscription, and that cancel still completes in one
   more tap.
4. Redeem the offer in sandbox and confirm the app keeps premium access.
5. Screenshot each state into the launch tracker as evidence.

Remember section 2.3: sandbox shows the newest draft, not the live version.

---

## 7. Measure

| Metric | Source |
|---|---|
| Cancel-flow views, keeps, offer redemptions | App Store Connect subscription reporting (**verify** where retention data lands as reporting rolls out) |
| Offer redemptions by offer identifier | Sales and Trends; Subscription Offer Redemption Report |
| Cancellation reasons | Cancellation reasons report |
| 30/60/90-day survival of saved subscribers | Your entitlement table |

A save that churns next month was a discount, not a save. Judge offers on
90-day survival and net revenue, not redemption count.

---

## 8. Common mistakes

| Mistake | Fix |
|---|---|
| Price or "% off" in the body text | Move it to the offer; text stays value-only |
| Message missing locales for some storefronts | Localize for every storefront the subscription is sold in |
| Offer shown to trial users | Set Paid Subscription Duration |
| Expecting Wait Between Offers to cap all offers | It is per offer; stagger offers deliberately |
| Editing live copy and checking it in sandbox as "what users see" | Sandbox shows the draft. Check the published version status in App Store Connect |
| Using up all 10 message slots on experiments | Delete is permanent; keep a few slots free |
| Building the API endpoint first | Ship Path A, measure, then decide |
| Endpoint on a cold-start serverless function | Keep it warm or precompute; 700 ms includes network |

---

## 9. Report format

| Subscription | Message | Locales | Image | Offer (id, type, price, tenure gate, wait) | Status | Evidence |
|---|---|---|---|---|---|---|

Status values: `Draft`, `In review`, `Approved`, `Rejected (reason)`,
`UNVERIFIED`. Human-only items (submit, offer price sign-off) listed separately.

---

## 10. Sources

- Apple Developer News, "Now available: Retention messages for subscriptions" (2026-11-04): https://developer.apple.com/news/?id=fk9ps3gv
- App Store Connect Help, Configure retention messages: https://developer.apple.com/help/app-store-connect/manage-subscriptions/configure-retention-messages
- Retention Messaging API overview: https://developer.apple.com/documentation/retentionmessaging
- Setting up retention messages (API): https://developer.apple.com/documentation/retentionmessaging/setting-up-retention-messages
- Responding to real-time requests (700 ms): https://developer.apple.com/documentation/retentionmessaging/responding-to-realtime-retention-messaging-requests
- Setting up the Get Retention Message endpoint: https://developer.apple.com/documentation/retentionmessaging/setting-up-retention-messaging-endpoint
- Retention Messaging API changelog (fallback order, 1.6): https://developer.apple.com/documentation/retentionmessaging/retention-messaging-changelog
