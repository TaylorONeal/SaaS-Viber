# Payment Integration: Key Decisions

> **Prompt Guide**: Use this document to understand your payment options. Then use `docs/architecture/PromptGuide-Architecture.md` to generate your payment implementation plan.

## Why This Matters

Payment integration directly affects your revenue, legal obligations, and customer trust. The right choice depends on your business model (subscription, usage-based, marketplace), your market (US-only vs global), and how much tax/compliance headache you want to absorb. Get this wrong and you're either leaving money on the table or drowning in tax filings.

---

## Key Concept: Merchant of Record (MoR) vs Payment Processor

This is the single most important distinction in payment processing.

### Payment Processor (Stripe, PayPal, Square)
- **You** are the merchant. Your company name appears on the customer's credit card statement.
- **You** are responsible for sales tax collection, remittance, and compliance.
- **You** handle refunds, chargebacks, and disputes.
- **You** need to register for tax in every jurisdiction where you have nexus.
- **Lower fees**, but higher operational burden.

### Merchant of Record (Paddle, LemonSqueezy)
- **They** are the merchant. Their company name appears on statements.
- **They** handle sales tax, VAT, and GST collection and remittance globally.
- **They** manage refunds and chargebacks.
- **You** just receive payouts.
- **Higher fees**, but dramatically less operational overhead.

**Rule of thumb**: If you're a small team selling globally, MoR saves you hundreds of hours in tax compliance. If you're US-only or have a finance team, a payment processor gives you more control and lower fees.

---

## Decision Matrix

| Factor | Stripe | LemonSqueezy | Paddle | PayPal | Square | Stripe Connect |
|--------|--------|-------------|--------|--------|--------|---------------|
| Type | Processor | MoR | MoR | Processor | Processor | Marketplace |
| Transaction fee | 2.9% + $0.30 | 5% + $0.50 | 5% + $0.50 | 2.9% + $0.30 | 2.6% + $0.10 | 2.9% + $0.30 + platform fee |
| Subscription billing | Excellent | Good | Good | Basic | Basic | Excellent |
| Usage-based billing | Yes (Meters API) | Limited | Limited | No | No | Yes |
| Tax handling | Stripe Tax (add-on) | Included | Included | Manual | Manual | Stripe Tax |
| Global coverage | 46+ countries | Global (MoR) | Global (MoR) | 200+ countries | 6 countries | 46+ countries |
| Invoicing | Built-in | Built-in | Built-in | Built-in | Basic | Built-in |
| Developer experience | Best-in-class | Good | Good | Dated | Good | Excellent |
| Self-serve checkout | Checkout Sessions | Checkout overlay | Checkout overlay | Buttons/SDK | Web Payments | Checkout |
| Customer portal | Yes | Yes | Yes | No | No | Yes |
| Webhooks | Excellent | Good | Good | Inconsistent | Good | Excellent |
| Payout schedule | 2 days (US) | Monthly | Monthly | Instant transfer | 1-2 days | Varies |
| Chargeback handling | You handle | They handle | They handle | Complex | You handle | Split |

---

## Option 1: Stripe -- RECOMMENDED Default

**What it is**: The industry standard payment processor. Best APIs, best documentation, most features.

### When to Choose It
- You want maximum flexibility and control
- US or single-country focus initially
- You need usage-based billing (metered subscriptions)
- Your dev team values excellent documentation and DX
- You're building subscription SaaS (Stripe Billing is best-in-class)

### Tradeoffs
- **Pro**: Best API design in the payment industry
- **Pro**: Stripe Billing handles complex subscription logic (trials, proration, upgrades)
- **Pro**: Stripe Tax automates tax calculation (add-on, 0.5% per transaction)
- **Pro**: Customer Portal lets users manage their own subscriptions
- **Pro**: Stripe CLI for local webhook testing
- **Con**: You're the merchant of record (tax compliance is on you)
- **Con**: 2.9% + $0.30 adds up; volume discounts require negotiation
- **Con**: Support quality has declined as they've scaled

### Implementation Pattern

```typescript
// src/lib/payments/stripe.ts
import Stripe from 'stripe';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);

// Create a checkout session for subscription
export async function createCheckoutSession(params: {
  priceId: string;
  orgId: string;
  customerEmail: string;
  successUrl: string;
  cancelUrl: string;
}) {
  return stripe.checkout.sessions.create({
    mode: 'subscription',
    payment_method_types: ['card'],
    customer_email: params.customerEmail,
    line_items: [{ price: params.priceId, quantity: 1 }],
    success_url: params.successUrl,
    cancel_url: params.cancelUrl,
    metadata: { org_id: params.orgId },
    subscription_data: {
      metadata: { org_id: params.orgId },
      trial_period_days: 14,
    },
  });
}

// Webhook handler (critical -- this is where subscription state syncs)
export async function handleWebhook(event: Stripe.Event) {
  switch (event.type) {
    case 'checkout.session.completed':
      // Provision access
      break;
    case 'customer.subscription.updated':
      // Handle plan changes, cancellation scheduled
      break;
    case 'customer.subscription.deleted':
      // Revoke access
      break;
    case 'invoice.payment_failed':
      // Notify customer, retry logic
      break;
  }
}
```

### Subscription Table Pattern

```sql
-- Your database should mirror Stripe state
CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id UUID REFERENCES organizations(id) NOT NULL,
  stripe_customer_id TEXT NOT NULL,
  stripe_subscription_id TEXT UNIQUE NOT NULL,
  plan_id TEXT NOT NULL,
  status TEXT NOT NULL, -- 'active', 'trialing', 'past_due', 'canceled', 'unpaid'
  current_period_start TIMESTAMPTZ,
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Option 2: LemonSqueezy (MoR)

### When to Choose It
- Solo founder or small team selling globally
- You don't want to deal with tax compliance at all
- Your pricing model is simple (flat-rate subscriptions, one-time purchases)
- You value simplicity over maximum control

### Tradeoffs
- **Pro**: Handles all global tax (VAT, GST, sales tax)
- **Pro**: Simple API, good developer experience
- **Pro**: Built-in license key management (great for desktop apps)
- **Pro**: No tax registration needed in any country
- **Con**: 5% + $0.50 per transaction is expensive at volume
- **Con**: Monthly payouts (cash flow impact)
- **Con**: Less flexibility than Stripe for complex billing scenarios
- **Con**: Fewer payment methods than Stripe

---

## Option 3: Paddle (MoR)

### When to Choose It
- B2B SaaS selling to international enterprises
- Tax compliance across EU, UK, US, etc. is a real pain point
- You want MoR benefits with more enterprise features than LemonSqueezy

### Tradeoffs
- **Pro**: MoR with enterprise-grade features
- **Pro**: Handles all tax globally
- **Pro**: Good B2B features (quotes, invoicing, PO numbers)
- **Pro**: Paddle Retain for dunning management
- **Con**: 5% + $0.50 per transaction
- **Con**: API is less elegant than Stripe
- **Con**: Monthly payouts
- **Con**: Approval process to get started (they reject some business types)

---

## Option 4: Stripe Connect (Marketplace/Platform Payments)

### When to Choose It
- You're building a marketplace or platform where money flows between parties
- Sellers/providers on your platform need to receive payments
- You want to take a platform fee on transactions

### Tradeoffs
- **Pro**: Industry standard for marketplace payments
- **Pro**: Handles seller onboarding, KYC/AML compliance
- **Pro**: Flexible fee structures (application fees, destination charges)
- **Con**: Most complex Stripe integration
- **Con**: Seller onboarding can have friction (identity verification)
- **Con**: 0.25% + $0.25 additional per payout to connected accounts

### Connect Account Types

| Type | Standard | Express | Custom |
|------|----------|---------|--------|
| Onboarding | Stripe handles | Stripe-hosted | You build |
| Dashboard | Full Stripe | Limited | You build |
| Branding | Stripe | Your brand | Your brand |
| Effort | Low | Medium | High |
| Best for | Marketplaces | Platforms | White-label |

---

### Option 5: RevenueCat + Stripe (recommended for apps on iOS + Android + web)

**What it is:** RevenueCat is a subscription platform, not a payment processor. It sits between your app and the two app stores: one SDK wraps Apple StoreKit and Google Play Billing, tracks entitlements, serves paywalls, and sends your server one normalized webhook whatever store the purchase came from. Stripe stays in place for web checkout. Your server keeps one entitlement table that both RevenueCat webhooks and Stripe webhooks write to. Reconcile by product id: the same plan must carry the same product id string in App Store Connect, Google Play Console, RevenueCat, your paywall code, and your server.

**When to choose it:**

- You sell subscriptions on iOS and Android, or on iOS, Android, and the web.
- You want one purchase implementation instead of two store integrations plus receipt validation written twice.
- You want paywall tests and subscription offers without an app release.

**When not to choose it:**

- Web-only product with no app, or a single one-time purchase where StoreKit alone is a day of work. Do not add a platform for a problem you do not have.

**Tradeoffs:**

- **Pro:** One SDK for both stores; entitlements across Apple, Google, and web; paywalls and offer handling built in.
- **Pro:** RevenueCat does not replace Stripe. Web checkout keeps Stripe's fees and tooling.
- **Pro:** Offer and retention handling (introductory, promotional, win-back) flows through one place.
- **Con:** RevenueCat is a plan cost on top of the store fee and the Stripe fee. It does not lower either one. Check current RevenueCat pricing in their docs before you budget; this guide does not state a RevenueCat fee, because stating one from memory would be guessing. Verify in the provider docs before you ship.
- **Con:** One more vendor in the billing path. If RevenueCat is down, your purchase flow needs a fallback plan.
- **Con:** You still own the entitlement table, idempotent webhook handling, restore purchases, and account deletion. RevenueCat does not remove any of those jobs.

**Fees to budget, as of Nov 8, 2026. Verify in the store console or provider docs before you ship.** Apple IAP: 30% standard, 15% in the Small Business Program under $1M and for auto-renewable subscriptions after year one. Google Play Billing: 30% standard, 15% on the first $1M per year and on subscriptions after 12 months. Stripe web checkout: 2.9% + $0.30 per successful US card charge. On a $10 per month subscription that is $7.00 kept on IAP at 30%, $8.50 kept on IAP at 15%, and $9.41 kept on Stripe web, before your RevenueCat plan cost. See `../docs/guides/PAYMENTS_IN_APP_VS_WEB.md`, section 6, for the full table.

**Implementation notes:**

- Create every store product in the first submission and attach all of them, plus the subscription group, to the same draft. Adding a product later means a new review and a paywall that cannot ship until Apple approves it.
- Never change price, product type, or paywall copy mid-review.
- A renewal that carries a retention offer or promotional offer must be accepted by your server and webhook handler. A strict parser that rejects unknown offer types can drop the entitlement of the subscriber you just saved.
- Full setup: `../docs/guides/PAYMENTS_IN_APP_VS_WEB.md` (sections 2.4, 7, 9, and 11).

### In-app vs web: which rail for which sale

One question decides the rail: is the thing being bought used inside the app, or outside it? Digital goods and subscriptions used inside the app normally require Apple IAP on iOS and Google Play Billing on Android. Physical goods and real-world services used outside the app use web checkout, for example Stripe, and the stores do not take a cut. Reader apps (books, magazines, newspapers, audio, music, video bought elsewhere) and some multiplatform services have their own exemptions; each needs a deliberate check of the current guidelines for your category and region, not an assumption. In the United States, apps can currently link out to the web for payment with Apple taking 0% on that purchase, as of Nov 8, 2026, because of the Epic v. Apple contempt order of Apr 30, 2025 and the Ninth Circuit decision of Dec 11, 2025, which sent the rate back to the district court; Apple proposed 15% (10% for some partners and renewals, 5% for Small Business Program members) on Aug 13, 2026, the court has not decided, and Supreme Court briefing is running. Do not build a business that only works at 0%: price your plan at 0% and at 15% before you launch. Outside the US the standard rules still apply unless a regional carve-out (for example the EU Digital Markets Act) applies. Verify in the store console or provider docs before you ship. Full decision tree, fee table, and offer rules: `../docs/guides/PAYMENTS_IN_APP_VS_WEB.md`.

## Billing Patterns

### 1. Flat-Rate Subscription
```
Free → $29/mo (Starter) → $99/mo (Pro) → $299/mo (Enterprise)
```
- Simplest to implement, easiest for customers to understand
- Best for: Most B2B SaaS

### 2. Per-Seat Pricing
```
$10/user/month (quantity-based subscription)
```
- Revenue scales with customer growth
- Best for: Collaboration tools, team-based products

### 3. Usage-Based / Metered
```
$0.01 per API call, $0.10 per GB stored, etc.
```
- Stripe Meters API tracks usage, bills at period end
- Best for: API platforms, infrastructure tools, AI/ML products
- Warning: Revenue is less predictable; harder to forecast

### 4. Hybrid (Base + Usage)
```
$49/mo base + $0.01 per API call over 10K
```
- Combines predictable revenue with upside from heavy users
- Best for: Products where base value is clear but usage varies

### 5. One-Time + Subscription
```
$199 setup fee + $49/mo ongoing
```
- Works well for products with onboarding cost
- Use Stripe Checkout with both one-time and recurring line items

---

## International Considerations

### Currency
- Always show prices in the customer's local currency if possible
- Stripe supports 135+ currencies
- LemonSqueezy/Paddle handle currency conversion automatically (MoR benefit)

### Tax
| Approach | Effort | Cost |
|----------|--------|------|
| Ignore (illegal in many jurisdictions) | None | Legal risk |
| Stripe Tax | Low | 0.5% per transaction |
| TaxJar / Avalara | Medium | $99+/mo |
| MoR (Paddle/LemonSqueezy) | None | Included in fees |
| Manual (accountant) | High | Accountant fees |

### PCI Compliance

| Level | Applies to | Requirements |
|-------|-----------|-------------|
| SAQ-A | Using Stripe Checkout or Elements | Simplest; fill out a questionnaire annually |
| SAQ-A-EP | Custom payment form with Stripe.js | More questions, but still manageable |
| SAQ-D | Handling raw card numbers (don't do this) | Full audit, very expensive |

**Recommendation**: Always use Stripe Checkout or Elements. Never handle raw card numbers. Ever.

---

## Webhook Best Practices

Webhooks are how your payment provider tells you what happened. They are critical infrastructure.

```typescript
// Essential webhook handling patterns
export async function handleWebhook(req: Request) {
  // 1. ALWAYS verify the signature
  const signature = req.headers.get('stripe-signature');
  const event = stripe.webhooks.constructEvent(
    await req.text(),
    signature,
    process.env.STRIPE_WEBHOOK_SECRET
  );

  // 2. ALWAYS use idempotency (webhooks can be sent multiple times)
  const processed = await db.processedEvents.findByEventId(event.id);
  if (processed) return new Response('Already processed', { status: 200 });

  // 3. Process the event
  try {
    await processEvent(event);
    await db.processedEvents.insert({ event_id: event.id, processed_at: new Date() });
  } catch (error) {
    // 4. Return 500 so the webhook retries
    return new Response('Processing failed', { status: 500 });
  }

  // 5. ALWAYS return 200 quickly (process async if slow)
  return new Response('OK', { status: 200 });
}
```

---

## Quick Decision Guide

```
Start here:
  |
  v
Selling digital goods or subscriptions used inside an iOS or Android app? ──Yes──> Read `../docs/guides/PAYMENTS_IN_APP_VS_WEB.md` and pick the rail per sale before choosing a web provider.
  |
  No
  v
Building a marketplace? ──Yes──> Stripe Connect
  |
  No
  v
Selling globally without a finance team? ──Yes──> LemonSqueezy or Paddle (MoR)
  |
  No (US-focused or have finance team)
  v
Need usage-based billing? ──Yes──> Stripe (Meters API)
  |
  No
  v
Simple subscriptions? ──Yes──> Stripe (default) or LemonSqueezy (simpler)
  |
  Complex billing
  v
Stripe (most flexible billing engine available)
```

---

## Our Decision

**Chosen**: [Payment provider]
**Type**: [Payment processor / MoR / Marketplace]
**Date**: [Date]
**Decided by**: [Who]
**Rationale**: [Why this provider]
**Billing model**: [Flat-rate / Per-seat / Usage-based / Hybrid]
**Tax strategy**: [Stripe Tax / MoR handles it / TaxJar / Manual]
**International plan**: [US-only initially / Global from day one]
**Review trigger**: [When to re-evaluate -- e.g., "when processing >$50K/mo"]
**In-app vs web rail per sale**: [rail per sale, with exemption relied on]
**US external-link position**: [0% today, margin tested at 15%: Yes / No]
