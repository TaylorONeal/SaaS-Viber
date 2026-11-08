# In-App Purchase vs Web Checkout: Which Rail for Which Sale

> **Added Nov 8, 2026.**
> **All prices, fees, and legal claims in this guide are as of Nov 8, 2026. Verify in the store console or provider docs before you ship.** Store rules and court cases move. A fee that was true in November can be different by launch day, and a rule that applies in the US can be the opposite in the EU.
> **Companion docs:** `decisions/PAYMENT_CHOICES.md` (web payment providers) | `docs/architecture/BILLING_MODELS.md` (pricing models and lifecycle) | `docs/developer/payments-setup.md` (Stripe setup) | `docs/architecture/APP_STORE_COMPLIANCE.md` (store compliance checklist) | `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (launch order, billing reconciliation, submit day) | `skills/retention-messaging-skill/SKILL.md` (Apple cancel-flow retention) | `skills/mobile-skill/SKILL.md` (web vs in-app billing decision) | `docs/workflows/subscription-management.md` (trial, dunning, refund flows)

## In one minute

One question decides almost everything: **is the thing being bought used inside the app, or outside it?**

- Bought and used **inside the app** (premium features, extra storage in the app, a subscription that unlocks in-app content): Apple and Google normally require their own billing. That is In-App Purchase (IAP) on iOS through StoreKit, and Google Play Billing on Android. The stores take a cut.
- Bought for use **outside the app** (a physical product shipped to a door, a haircut, a taxi ride, a hotel room): use web checkout, for example Stripe. The stores do not take a cut and do not require their billing.
- Bought elsewhere and **read or watched inside the app** (a book, a video subscription, a magazine): this is the reader-app case. It has its own exemption. See the reader-app paragraph below.
- If you sell on **iOS, Android, and the web**, do not build three billing systems. Use RevenueCat as the bridge for the two stores and Stripe for web checkout, with one entitlement table that every rail writes to. See the RevenueCat section below.

If you remember nothing else: decide the rail per sale before you write entitlement code, create every store product in the first submission, and never build a business that only works while a court case is going your way.

---

## 1. Plain language: the one question that decides everything

### 1.1 What are you selling, and where is it used?

Ask this about every single thing you charge for, one at a time. Different items in the same app can use different rails.

| What you sell | Where it is used | Usual rail |
|---|---|---|
| Premium features, extra projects, more storage, an ad-free upgrade | Inside the app | IAP / Play Billing |
| A monthly subscription that unlocks content or features in the app | Inside the app | IAP / Play Billing (or web checkout if an exemption applies, see section 5) |
| A one-time unlock, extra credits, virtual currency spent in the app | Inside the app | IAP / Play Billing |
| A physical product: a book, a T-shirt, a piece of hardware | Outside the app, shipped to the buyer | Web checkout (Stripe) |
| A real-world service: a booking, a class in a studio, a delivery, a ride | Outside the app | Web checkout (Stripe) |
| A digital book, magazine, newspaper, song, film, or video bought elsewhere and consumed in the app | Inside the app, bought outside it | Reader-app exemption, see section 5.1 |
| Access to a service that exists on web, iOS, and Android at the same time | Everywhere | Multiplatform case, see section 5.2. The answer depends on your category and region, and it needs a deliberate decision, not an assumption |

### 1.2 Why the stores care

Apple and Google built the store, the payment screen, the receipts, the refunds, and the trust that makes a stranger tap Buy. Their rule, in plain words: if the value is delivered inside the app, the purchase goes through their billing and they take a percentage. If the value is delivered outside the app, they do not claim it.

This is not a suggestion. An app that sells in-app digital goods through a web link where the rules do not allow it gets rejected at review, or pulled later. The compliance checklist in `docs/architecture/APP_STORE_COMPLIANCE.md` lists the same rule under Business, and the launch playbook in `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 5) makes billing reconciliation a gate before submission.

### 1.3 The words, in plain language

- **In-App Purchase (IAP):** buying something inside an iOS app, paid through Apple. Built with StoreKit, which is Apple's toolkit for purchases.
- **Google Play Billing:** the Android equivalent. Buying inside an Android app, paid through Google.
- **Web checkout:** buying on your website, paid through a provider such as Stripe. The customer types card details on your site, not in the app.
- **Entitlement:** a record in your database that says "this account may use the paid thing." Every rail (Apple, Google, web) must write to the same entitlement table, or one customer ends up paying twice and still locked out. See `docs/architecture/BILLING_MODELS.md` for the subscription lifecycle that table has to support.
- **Merchant of record:** the company legally selling the thing, named on the card statement, responsible for tax. With Stripe you are the merchant of record. With Paddle or LemonSqueezy they are. See `decisions/PAYMENT_CHOICES.md` for the full comparison.
- **StoreKit:** Apple's framework for in-app purchases on iOS. StoreKit 2 is the current version.
- **Paywall:** the screen in your app that shows the plans and prices and asks the customer to subscribe.
- **Offer:** a discounted or free period Apple lets you attach to a subscription, for example an introductory price or a win-back offer. See section 7.

---

## 2. Expert detail: the rails

### 2.1 Apple In-App Purchase (StoreKit)

The default for digital goods used inside an iOS app.

**Fees, as of Nov 8, 2026. Verify in App Store Connect before you ship.**

- Standard rate: **30%** of the sale goes to Apple, you keep 70%.
- Small Business Program: **15%** if your business earns under $1 million in App Store proceeds in the previous calendar year. You must enroll; it is not automatic.
- Auto-renewable subscriptions: **15%** after a subscriber has been subscribed for one continuous year, even outside the Small Business Program.

**Product types.** Apple has four, and the type must match your paywall copy. If the paywall says "no auto-renewal," the store product must be non-renewing. A mismatch is a rejection. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 5.1, for the reconciliation table.

| Type | What it is | Example |
|---|---|---|
| Auto-renewable subscription | Renews by itself until the customer cancels | $10/month Pro plan |
| Non-renewing subscription | Fixed length, ends by itself, no automatic renewal | 3 months of access, paid once |
| Non-consumable | Bought once, kept forever, restorable | Lifetime unlock, remove ads forever |
| Consumable | Bought, used up, bought again | 100 credits, extra lives, a pack of exports |

**What Apple handles for you:** payment processing, receipts, sales tax in most regions, refunds through Apple, subscription management in iOS Settings, family sharing where you enable it.

**What you still own:** entitlements on your server, restore purchases (a visible control, reviewers test it), receipt validation through App Store Server Notifications, and handling renewals that carry an offer.

### 2.2 Google Play Billing

The default for digital goods used inside an Android app. Same shape, different console.

**Fees, as of Nov 8, 2026. Verify in Google Play Console before you ship.**

- Standard rate: **30%**.
- **15%** on the first $1 million of Play earnings per year, and **15%** on auto-renewable subscriptions after 12 months of continuous subscription.

Google's product types mirror Apple's: subscriptions (auto-renewing), one-time products (consumable and non-consumable). Google also has its own rules on steering users to web payment, and its own regional carve-outs. Do not assume an Apple exemption automatically works on Google Play. Check Play Console policy for your category and region before you ship.

### 2.3 Web checkout with Stripe

The default for everything used outside the app, and the alternative for web-only sales.

**Fee, as of Nov 8, 2026. Verify in Stripe docs before you ship.** Stripe charges **2.9% + $0.30 per successful card charge** in the US. Other regions and payment methods differ. Stripe Tax is an add-on at 0.5% per transaction, as of Nov 8, 2026 (see `decisions/PAYMENT_CHOICES.md`, which lists the same figure; confirm it in Stripe docs before you ship).

**What Stripe handles:** checkout pages, subscriptions, proration, trials, invoices, the customer portal where subscribers change cards and cancel, webhooks that tell your server what happened.

**What you still own:** tax registration and remittance (you are the merchant of record), refunds and chargebacks, PCI scope (use Stripe Checkout or Elements and never handle raw card numbers; see `decisions/PAYMENT_CHOICES.md`, PCI section), and idempotent webhook handling (see `docs/developer/payments-setup.md` and `docs/architecture/BILLING_MODELS.md`, webhook section).

**When web checkout is the right rail:**

- Physical goods and real-world services, always.
- A web-only product with no app at all.
- An exempt sale inside an app, where the rules allow it (see section 5).
- A customer who signed up on the web and manages billing on the web, while the app only reads the entitlement.

**When web checkout is the wrong rail:** selling an in-app digital good inside the app while routing the customer to a web page to dodge the store fee, in a region and category where the rules do not allow it. That is the rejection described in section 1.2.

### 2.4 RevenueCat as the bridge

RevenueCat is a subscription platform that sits between your app and the stores. It is not a payment processor and it does not replace Stripe. Think of it this way: RevenueCat talks to Apple and Google, Stripe talks to the web, and your server trusts one entitlement table.

**What RevenueCat does:**

- One SDK for iOS and Android. It wraps StoreKit and Play Billing so your app code does not have two separate purchase implementations.
- Entitlements: it tracks which customer has which entitlement, across Apple, Google, and (through its web billing or Stripe integration) the web.
- Paywalls: it can serve and test paywall layouts without an app release.
- Offer handling: introductory, promotional, and win-back offers flow through it, and it reports redemptions.
- Webhooks: it sends your server a normalized event when a subscription starts, renews, cancels, or lapses, whatever store it came from.

**How it pairs with Stripe:**

- RevenueCat for the stores (Apple and Google purchases).
- Stripe for web checkout (customers who subscribe on your website).
- One entitlement source of truth: your server records the entitlement, keyed by your customer id, and both RevenueCat webhooks and Stripe webhooks write to the same table. Never let the store receipt be the only record, and never let the Stripe subscription be the only record.
- Reconcile by product id: the same plan must have the same product id string in App Store Connect, Google Play Console, RevenueCat, your paywall code, and your server. The launch playbook reconciliation table (`docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 5.1) exists for exactly this check.

**What RevenueCat costs:** RevenueCat pricing is plan-based and has changed over time. This guide does not state a RevenueCat fee, because stating one from memory would be guessing. Check current RevenueCat pricing in their docs before you budget, and record the plan you chose in your decision record. Verify in the provider docs before you ship. In the fee comparison in section 6, the RevenueCat plus Stripe row therefore shows the Stripe fee plus your RevenueCat plan cost, not a made-up combined percentage.

**When RevenueCat is worth it:** you sell subscriptions on iOS and Android, or on iOS, Android, and web. One subscription platform replaces two store integrations and the receipt-validation code you would otherwise write twice.

**When it is not:** web-only product with no app, or a single one-time purchase where StoreKit alone is a day of work. Do not add a platform for a problem you do not have.

### 2.5 One entitlement table, three rails

This is the rule the launch playbook states as a red flag: a server that accepts only one store's receipts has no billing path for the other store.

Design, in plain words:

1. Your database has one `entitlements` (or `subscriptions`) table. See the schema in `docs/architecture/BILLING_MODELS.md`.
2. Apple purchases, Google purchases, and Stripe purchases all write a row there, keyed by your customer id and the plan.
3. Webhooks from all three are idempotent: receiving the same event twice must not create two entitlements or charge twice. See `docs/developer/payments-setup.md` for the Stripe webhook pattern and apply the same rule to store notifications.
4. Handle every status transition in the table: trial, active, grace period, billing retry, cancelled, refunded, expired. See `docs/architecture/BILLING_MODELS.md` (lifecycle) and `docs/workflows/subscription-management.md` (dunning and refund flows).
5. Restore purchases is a visible button in the app. A customer who reinstalls must get their paid access back without emailing support.

---

## 3. The US external-purchase-link rule: moving law

This section is the one most likely to be out of date when you read it. Treat every sentence here as a snapshot, not a promise.

**The short version:** in the United States, an app can currently link out to the web for payment without Apple taking a commission on that purchase. That is a court outcome, not a settled policy, and the rate could change. Outside the US, the standard rules still apply unless a regional carve-out (for example the EU Digital Markets Act, DMA) applies.

**The timeline, as of Nov 8, 2026. Verify in App Store Connect and current Apple guidance before you ship.**

- **Apr 30, 2025:** in Epic v. Apple, a US district judge found Apple in contempt of an earlier anti-steering injunction. Apple had allowed external links but charged 27% on purchases made through them (12% for Small Business Program members). The judge barred Apple from charging any commission on US external-link purchases and from restricting link design. Apple updated its App Review Guidelines so US storefront apps can include buttons and links to buy on the web.
- **Dec 11, 2025:** the Ninth Circuit upheld the contempt finding but said a total ban on any commission went too far. It said Apple may charge a commission based on costs genuinely and reasonably necessary for coordinating external links, and sent the rate back to the district court to set.
- **Aug 13, 2026:** Apple proposed a rate to the district court: 15% for standard developers, 10% for Video, News and Mini Apps partners and for subscription renewals, 5% for Small Business Program members. The court has not decided. These are proposals, not fees, as of Nov 8, 2026.
- **Supreme Court briefing is running:** the Supreme Court agreed in June 2026 to hear part of Apple's appeal, limited to the contempt question. Apple's opening brief was filed in September 2026. A decision is expected in 2027, as of Nov 8, 2026.

**Current practical state, as of Nov 8, 2026:** Apple charges 0% on external-link purchases from US storefront apps, because no rate has been set. Verify in App Store Connect before you ship.

**What this means for your decision:**

- Do not build a business that only works at 0%. If the court sets 15%, your margin must still work. Run your pricing at both 0% and 15% before you commit.
- The US rule is about links to the web. It does not change the rule for purchases made inside the app through Apple's own billing, and it does not automatically apply to Google Play, which has its own policies and its own litigation.
- In the EU, Apple operates under DMA business terms. As of Nov 8, 2026, a single EU fee schedule took effect Oct 1, 2026, with different rates for IAP, alternative payment processing, and link-out purchases. Check the current EU terms in App Store Connect before you ship to the EU; do not carry the US numbers across the Atlantic.
- If you use an external link, follow the current guideline wording for that storefront exactly. Link design, wording, and disclosure requirements are part of the rule and have changed before.

---

## 4. The decision tree

Start at the top. Answer honestly. The first branch that matches is your rail.

```
What are you selling?
|
+-- Physical goods or a real-world service
|   (a T-shirt, a booking, a delivery, a class in a room)
|   --> WEB CHECKOUT (Stripe). The stores do not claim this sale.
|
+-- Digital content or features used inside the app
|   |
|   +-- Is it a reader-app product?
|   |   (book, magazine, newspaper, audio, music, video bought elsewhere)
|   |   --> See section 5.1. Reader-app exemption may apply.
|   |
|   +-- Is it a multiplatform SaaS where the customer buys on the web
|   |   and uses the service on web, iOS, and Android?
|   |   --> See section 5.2. May qualify for external billing.
|   |       Verify your category and region before you rely on it.
|   |
|   +-- Otherwise
|       --> IN-APP PURCHASE (StoreKit) on iOS and
|           PLAY BILLING on Android.
|           Use RevenueCat if you sell on both stores, or on both
|           stores plus the web. Use Stripe for any web sales.
|
+-- Something bought on the web and only read or watched in the app
    --> See section 5.1 (reader apps).
```

**After the tree, ask three more questions:**

1. Do I sell in more than one country? If yes, check each region's rules, not just the US. The EU, South Korea, Japan, and others have their own carve-outs.
2. Do I sell on more than one platform? If yes, one entitlement table, reconciled product ids, and a sandbox purchase, restore, and cancel test on a real device per product. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 5.
3. Does my margin survive the worst plausible fee? Price the plan at the 30% store rate and at the proposed 15% link-out rate before you launch. If it only works at 0%, reprice.

---

## 5. Exemptions, one paragraph each

### 5.1 Reader apps

Apple has a Reader App entitlement for apps whose primary function is providing access to digital content that the customer bought elsewhere: magazines, newspapers, books, audio, music, and video. A qualifying reader app may link to its website for account creation and management, including payment, instead of using IAP for that content. You must apply for the entitlement in App Store Connect; it is not automatic. The link must follow Apple's wording and design rules for that storefront. Google Play has a similar but separate media-consumption concept; do not assume approval on one store means approval on the other. As of Nov 8, 2026, verify the current entitlement requirements in App Store Connect and Play Console before you ship.

### 5.2 Multiplatform SaaS

Some multiplatform services can use external billing instead of IAP, on the logic that the subscription is bought for a service that exists independently of the app, on the web and on other platforms. The compliance doc in this repo (`docs/architecture/APP_STORE_COMPLIANCE.md`) describes this as a SaaS exemption, but that wording is broader than the store rules in practice, and it is a claim to verify, not a guarantee. Whether your app qualifies depends on your category, what the app does without a subscription, and the region. If you rely on this, get the answer in writing from the current guidelines for your category, keep the app genuinely usable and purchasable outside Apple, and do not put in-app purchase buttons or prompts that bypass IAP for non-exempt digital goods. Verify in App Store Connect before you ship. If you are unsure, IAP is the safe rail.

### 5.3 Other carve-outs worth knowing exist

- **EU Digital Markets Act (DMA):** apps distributed in the EU can use alternative payment processing or link out under Apple's EU business terms, with different fees from the standard 30%. The terms changed Oct 1, 2026. Verify the current EU terms before you ship to the EU.
- **South Korea:** Apple and Google allow alternative payment systems for apps distributed in South Korea under local law. Verify the current terms for that storefront.
- **Japan and others:** regional rules exist and change. Check the storefront, not a blog post, before you ship to a new country.

---

## 6. Fee comparison: a $10 per month subscription

All figures as of Nov 8, 2026. Verify in the store console or provider docs before you ship. This table assumes one $10 monthly charge, US pricing, and no tax, no refunds, and no chargebacks. Real months have all three.

| Rail | Fee per $10 charge | You keep per month | You keep per year (12 x $10 = $120 gross) |
|---|---|---|---|
| Apple IAP, standard 30% | $3.00 | $7.00 | $84.00 |
| Apple IAP, 15% (Small Business Program, or auto-renewable after year one) | $1.50 | $8.50 | $102.00 |
| Google Play Billing, standard 30% | $3.00 | $7.00 | $84.00 |
| Google Play Billing, 15% (first $1M per year, or subscription after 12 months) | $1.50 | $8.50 | $102.00 |
| Stripe web checkout, 2.9% + $0.30 | $0.59 | $9.41 | $112.92 |
| RevenueCat + Stripe (web sale) | $0.59 Stripe fee, plus your RevenueCat plan cost | $9.41 before RevenueCat cost | $112.92 before RevenueCat cost |
| RevenueCat + Apple IAP, 15% or 30% store fee | Store fee as above, plus your RevenueCat plan cost | $8.50 or $7.00 before RevenueCat cost | $102.00 or $84.00 before RevenueCat cost |
| US external link, current 0% (see section 3) | $0.00 Apple fee; Stripe fee applies on the web sale | $9.41 on a Stripe web sale | $112.92 on Stripe web sales |
| US external link, if the court sets Apple's proposed 15% | $1.50 Apple fee, plus the web payment fee | About $7.91 on a Stripe web sale at 2.9% + $0.30 | About $94.92 |

**How to read this table:**

- The gap between IAP at 30% and Stripe web is $2.41 per month on a $10 plan, or $28.92 per year per subscriber. On 1,000 subscribers that is $28,920 a year. That is why the rail decision matters, and why it is worth a careful exemption check.
- The gap between IAP at 15% and Stripe web is $0.91 per month, or $10.92 per year per subscriber. At 15%, the store fee buys payment handling, tax handling, and a checkout customers already trust. Many founders keep IAP at 15% and skip the legal risk.
- RevenueCat does not change the store or Stripe fee. It adds a plan cost and saves the engineering cost of two store integrations. Budget it as a platform cost, not as a percentage in this table, and check current RevenueCat pricing before you commit.
- The last row is the scenario to stress-test. If your plan only works while the US link-out fee is 0%, reprice or reconsider before you launch.

---

## 7. Auto-renewing subscriptions and offers

### 7.1 The four Apple offer types

Apple offers four kinds of subscription offer. Each is created in App Store Connect and each has its own rules. The customer-facing copy rules are strict: retention message text must not contain prices or offer details, because every subscriber sees the text, including those not eligible for the offer. The offer card carries the price. See `skills/retention-messaging-skill/SKILL.md`, section 4, for the full copy rules.

| Offer type | What it is | Key limits, as of Nov 8, 2026 |
|---|---|---|
| Introductory offer | A first-time price for new subscribers: free trial, pay as you go, or pay up front | One per subscription group per customer, in practice. Set eligibility in App Store Connect. Verify before you ship |
| Promotional offer | A discounted price for existing or lapsed subscribers, including retention offers shown in the cancel flow | Up to 10 active promotional offers per subscription, per billing plan type, as of Nov 8, 2026. Verify in App Store Connect before you ship |
| Offer code | A code the customer redeems for a free or discounted purchase | One redemption per customer per offer. Expanded in 2026 to all IAP types, see section 8 |
| Win-back offer | An offer for subscribers who cancelled, shown in the App Store or in your app | iOS 18 and later. A promoted win-back offer can appear on the product page. Verify eligibility and placement in App Store Connect before you ship |

### 7.2 Retention messaging in the cancel flow

When a subscriber cancels in Apple's UI, your app never sees the moment. Apple lets you speak inside that flow with a retention message: a short message plus, when configured, an offer or a plan-switch button. Setup is no-code in App Store Connect: up to 10 messages per app, one active message per subscription, retention offers with eligibility rules and per-country availability, and a preview tool. See `skills/retention-messaging-skill/SKILL.md` for the full setup, including the 700 ms real-time API path, the copy rules, and the measurement table. The single most important rule: start with App Store Connect, measure for a full billing cycle, and only then consider the API.

Retention also exists outside Apple. Your web cancel flow and Google Play cancel flow are yours to design: a survey, a pause option, a downgrade, a discount. See `docs/workflows/subscription-management.md` (cancellation and retention) for the web-side flow, and keep the offers consistent across rails so a customer does not get a better deal by cancelling in one place than another.

### 7.3 Monthly billing with a 12-month commitment

Apple announced monthly subscriptions with a 12-month commitment on Apr 27, 2026. The idea: a customer pays monthly at a lower rate than the rolling monthly price, but commits to 12 payments. Cancelling stops renewal after the commitment is complete; it does not erase payments already owed. As of Nov 8, 2026, this option requires iOS 26.4 or later on the customer's device and an app built with the Xcode 26.5 SDK or later, and it is **not available in the United States or Singapore**. Verify availability for your storefronts in App Store Connect before you ship. The 12 monthly payments must total at least the prepaid annual price and no more than 1.5 times that price, as of Nov 8, 2026. If you use RevenueCat, this billing plan appears as a separate product with a monthly suffix; gate it to devices on iOS 26.4 or later and keep the upfront annual option as the fallback.

---

## 8. 2026 additions to name and date

These changed recently enough that older guides get them wrong. All as of Nov 8, 2026. Verify in App Store Connect before you ship.

- **Offer codes expanded to all IAP types (announced Oct 29, 2025; live in 2026).** Offer codes now cover consumables, non-consumables, and non-renewing subscriptions, in addition to auto-renewable subscriptions. Before this change they were subscription-only. Use offer codes, not promo codes, for free or discounted in-app purchases.
- **IAP promo codes no longer created after Mar 26, 2026.** Starting Mar 26, 2026, you can no longer create promo codes for in-app purchases in App Store Connect. Existing promo codes can be redeemed until they expire. Promo codes for a free download of the app itself still exist. If an old guide tells you to generate IAP promo codes, it is out of date.
- **Monthly billing with a 12-month commitment (announced Apr 27, 2026).** See section 7.3. Not available in the US or Singapore, as of Nov 8, 2026.
- **Retention messaging (Nov 2026).** Apple's retention message system and Retention Messaging API are new. See `skills/retention-messaging-skill/SKILL.md`. Knowledge there is current as of November 2026; anything marked verify changes often.
- **US external-link rule still moving (see section 3).** The Ninth Circuit decision of Dec 11, 2025, Apple's Aug 13, 2026 proposal, and the Supreme Court briefing running into 2027 all postdate most existing guides. Do not trust a guide that still quotes the 27% link-out fee as current.

---

## 9. The timing rule that matters most

**Create every in-app purchase and subscription product in the first submission.**

This is the single most expensive mistake in the launch playbook, and it appears in `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 8.1) for a reason. The mechanics:

1. Create all IAP products and the subscription group in App Store Connect before the first submission.
2. Attach every product and the subscription group to the same draft submission. The group must be added separately, or Submit stays disabled.
3. Upload an IAP review screenshot for every product at the exact accepted size (for example 1290 by 2796). A larger image was rejected for wrong dimensions on a real launch. One paywall image showing all tiers can serve every product.
4. Confirm the "items ready to submit" count matches your packet before you submit.

**Why it matters:** adding a product later means a new review, a new hold, and a paywall that cannot ship until Apple approves the new product. A launch that planned three tiers but only created one ships with one tier, or waits.

**Never change price, product type, or paywall copy mid-review.** A price change, a product type change, or a paywall copy change during review can reset the review or draw a question that stops the submission. Freeze the paywall with the release candidate. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 0.4 (scope freeze rule) and Phase 7 (pre-flight a week early: open the submission flow, click through to the last step without submitting, and catch blockers before submit day).

**The same discipline applies to Google Play.** Create the products, complete Data Safety and the content rating, and start the closed-testing clock early if you publish under a new personal account. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 1 and Phase 8.2.

---

## 10. Account deletion and refunds as billing requirements

Billing does not end at the purchase. Two requirements are store rules and shape your billing design.

### 10.1 Account deletion

Apple and Google both require a visible in-app path that deletes the account and its data, not just a support email. Build it from the first build. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 0.3 and Phase 3.2, and `docs/architecture/APP_STORE_COMPLIANCE.md`.

Deletion and billing interact, and the interaction needs a decision before launch:

- Deleting the account must cancel or detach the subscription record on your side, but it must not silently keep charging a customer who can no longer sign in to cancel. The store subscription itself is cancelled by the customer in the store, or ends at period end; your backend must handle the case where the account is gone and a renewal webhook still arrives.
- Deleting the account must purge personal data on the backend. Test the purge; a delete button that only hides the account is a rejection and a trust failure.
- Write down, before launch, what happens to paid access on deletion: does the subscription end immediately, or run to period end? Does the customer get a refund? Put the answer in your privacy policy and your support page, in plain language.

### 10.2 Cancel vs refund are different

Customers confuse them. Your UI and your support copy must not.

- **Cancel** stops future renewals. The customer keeps access until the end of the current paid period. No money moves back, unless your policy says otherwise.
- **Refund** returns money already paid. On Apple, refunds go through Apple, not through you, and Apple decides. On Google, refunds go through Google. On Stripe, refunds go through you, through the Stripe dashboard or API.
- A refund does not always cancel the subscription, and a cancellation does not always refund. Decide the pairing for each rail and write it down. See `docs/workflows/subscription-management.md` (refund processing) for a sample policy: full refund within 24 hours, manual review within 14 days, case by case after that. Your policy is your call; the point is to have one, publish it, and apply it the same way on every rail.
- **Restore purchases** is separate from both. It gives a customer their paid access back after reinstalling or switching devices. It is a visible control, reviewers test it, and it must work even when the subscription was bought on the other store or on the web, if your entitlement table is built right.

### 10.3 What the customer sees

Write the billing copy in plain language, in three places, with the same words:

- The paywall: price, billing period, what renews, how to cancel.
- The settings or billing screen: current plan, renewal date, cancel control, restore purchases, link to manage the subscription in the store.
- The cancellation confirmation: what access remains until which date, and what happens to the customer's data.

If the paywall says one thing and the store product says another, the reviewer will find it. Reconcile them in Phase 5.1 of the launch playbook before you submit.

---

## 11. Agent instructions

This section is for an agent building the billing layer. A human still clicks Submit, enters passwords, and signs agreements. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 8.3, for the agent vs human table.

### 11.1 Before writing code

1. Read the decision record at the end of this guide. If it is blank, stop and fill it in with the owner. Do not guess the rail.
2. Read `decisions/PAYMENT_CHOICES.md` for the web provider decision and `docs/architecture/BILLING_MODELS.md` for the pricing model and lifecycle.
3. Confirm the product list: every plan, every tier, every one-time product, with its product id, type, price, and billing period, in one table. Reconcile it against App Store Connect, Play Console, RevenueCat, the paywall code, and the server, per `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 5.1.
4. Confirm the exemption position in writing: which rail, for which sale, in which region, and what guideline or entitlement supports it. If the answer is "probably exempt," treat it as "not exempt" until a human confirms.

### 11.2 While building

1. Build one entitlement table. Every rail writes to it. No rail reads only its own receipts.
2. Make every webhook handler idempotent and verify every webhook signature. Return 200 quickly and process slowly if needed. See `docs/developer/payments-setup.md` and `docs/architecture/BILLING_MODELS.md`.
3. Handle the checkout and webhook race: a customer can reach the success page before the webhook lands. Do not grant access from the checkout redirect alone, and do not deny access while the webhook is in flight.
4. Implement restore purchases as a visible control, and test it from an empty account on a real device.
5. Implement account deletion end to end, including the backend purge and the billing detach, before the first submission.
6. Accept offer-carrying renewals: a renewal that carries a retention offer or a promotional offer must not be rejected by a strict parser. See `skills/retention-messaging-skill/SKILL.md`, section 5.
7. Never change live subscriber configuration during a launch. Do not touch web payment provider settings while a store submission is in review.
8. Never store store passwords, API keys, or signing keys in the repo.

### 11.3 Before submission

1. Run the sandbox purchase, restore, and cancel test on a real device, per product. Simulators cannot do true sandbox purchases. If a physical-device test is blocked, do the static verification set and write the residual risk down in the submit-day packet. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 5.3.
2. Capture IAP review screenshots from the release candidate at the exact accepted size, in the same device session as the purchase tests.
3. Run the pre-flight check a week early: open the submission flow in each console and click through to the last step without submitting. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 7.3.
4. Attach every IAP product and the subscription group to the same draft submission, and confirm the "items ready to submit" count matches the packet.
5. Write review notes from an empty reviewer account. List where purchase, restore, and delete live.

### 11.4 What the agent must not do

- Do not click final Submit for Review. That is a human action.
- Do not enter passwords, sandbox credentials, or two-factor codes.
- Do not accept agreements, banking, tax, or trader-status declarations.
- Do not change prices, product types, or paywall copy mid-review.
- Do not present a built billing flow as tested until a sandbox purchase, restore, and cancel have run on a real device, or the accepted-risk statement is written down and signed off.

---

## 12. Common mistakes

| Mistake | What happens | Fix |
|---|---|---|
| Routing in-app digital sales to web checkout where the rules do not allow it | Rejection at review, or removal later | Decide the rail per sale with the tree in section 4, and verify the exemption |
| Building the business on the US 0% link-out fee | A court-set fee of 15% breaks the margin | Price at 0% and at 15% before launch |
| Creating only one IAP product for the first submission | Later tiers wait on a new review | Create every product in the first submission |
| Changing price or paywall copy mid-review | Review resets or stalls | Freeze the paywall with the release candidate |
| A server that accepts only one store's receipts | Customers on the other store pay and stay locked out | One entitlement table, all rails writing to it |
| No restore purchases control | Reviewer rejection, support tickets | Visible restore control, tested from an empty account |
| Retention message text with a price in it | App Review rejection of the message | Prices live only on the offer card, never in the message text |
| Using IAP promo codes in 2026 | They cannot be created after Mar 26, 2026 | Use offer codes |
| Offering the 12-month commitment plan to US customers | It is not available in the US or Singapore | Gate it by region and OS version |
| Treating cancel and refund as the same thing | Angry customers, wrong entitlements | Separate controls, separate copy, separate handling |

---

## Decision record

Fill this in before writing entitlement code. Keep it in `decisions/` next to `decisions/PAYMENT_CHOICES.md` or in your launch tracker. One row per sale, not one row per app.

**Product:** [App and product name]
**Date:** [Date]
**Decided by:** [Name]

| Sale (what the customer buys) | Used inside or outside the app? | Rail (IAP / Play Billing / Stripe web / Reader / Multiplatform) | Region(s) | Exemption or guideline relied on, if any | Verified in console on (date) |
|---|---|---|---|---|---|
| [Example: Pro monthly subscription] | Inside | IAP + Play Billing via RevenueCat; Stripe on web | US, EU | None; standard store billing. US link-out noted, margin tested at 15% | [Date] |
| [Sale 2] | | | | | |
| [Sale 3] | | | | | |

**Store fees assumed:** Apple [30% / 15% Small Business / 15% after year one], Google [30% / 15%], Stripe [2.9% + $0.30]. All as of Nov 8, 2026; verify in the store console or provider docs before you ship.

**Margin at 30% store fee:** [You keep $___ per $10 sale]
**Margin at 15% store fee:** [You keep $___ per $10 sale]
**Margin on Stripe web:** [You keep $___ per $10 sale]
**Margin if the US link-out fee becomes 15%:** [You keep $___ per $10 sale]
**Business works at 0% only?** [Yes / No. If yes, stop and reprice.]

**RevenueCat used?** [Yes / No. If yes, plan: ___ . Pricing checked on (date) in RevenueCat docs.]
**Entitlement table:** [Table name and location. All rails write to it: Yes / No]
**Restore purchases tested on a real device?** [Yes / No, date and device]
**Account deletion tested end to end, including backend purge?** [Yes / No, date]
**Refund policy published at:** [URL or doc path]
**Cancel vs refund copy reviewed?** [Yes / No]

**Checklist before submission:**

- [ ] Every IAP product and the subscription group created in App Store Connect
- [ ] Every Play product created in Play Console
- [ ] Product ids reconciled across store consoles, RevenueCat, paywall code, and server
- [ ] Sandbox purchase, restore, and cancel run on a real device per product (or accepted-risk statement written)
- [ ] IAP review screenshots at the exact accepted size, from the release candidate
- [ ] All products and the subscription group attached to the same draft submission
- [ ] Paywall frozen: no price, product type, or copy changes mid-review
- [ ] Retention message drafted (if auto-renewable subscriptions exist) per `skills/retention-messaging-skill/SKILL.md`
- [ ] Account deletion works in-app and in the backend
- [ ] Refund policy published and cancel vs refund copy reviewed
- [ ] Fees re-verified in the store console or provider docs before shipping
