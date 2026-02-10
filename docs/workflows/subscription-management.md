# Subscription Management Workflow

## Overview

Manages the full lifecycle of a customer subscription: trial start, conversion
to paid, plan changes, cancellation, retention attempts, renewals, and dunning.

---

## Trigger

- User signs up for a free trial
- User selects a paid plan
- User changes their subscription (upgrade, downgrade, cancel)
- Payment processor sends a webhook event

## Actors

- **Customer:** Account owner or billing admin
- **System:** Application backend, subscription service
- **External:** Stripe (or your payment provider), email service

---

## Trial Start to Conversion

```mermaid
flowchart TD
    A([User Signs Up]) --> B[Create Stripe Customer]
    B --> C[Start Trial Period]
    C --> D[Set Trial End Date]
    D --> E{Trial Day 7?}
    E -->|Yes| F[Send Trial Midpoint Email]
    F --> G{Trial Day 11?}
    E -->|No| G
    G -->|Yes| H[Send Trial Ending Soon Email]
    H --> I{Trial Day 14?}
    G -->|No| I
    I -->|Yes| J{Payment Method on File?}
    J -->|Yes| K[Charge and Convert to Paid]
    J -->|No| L[Send Trial Expired Email]
    K --> M{Payment Successful?}
    M -->|Yes| N[Activate Paid Subscription]
    M -->|No| O[Enter Dunning Flow]
    L --> P{User Adds Payment in 7 Days?}
    P -->|Yes| K
    P -->|No| Q[Downgrade to Free / Deactivate]
    I -->|No| E
    N --> R([Active Subscription])
    Q --> S([Trial Expired])
```

### Trial Configuration

| Setting | Value | Notes |
|---------|-------|-------|
| Trial duration | [14 days] | Adjust based on time-to-value |
| Payment required to start | [No] | Reduces friction but lowers conversion |
| Grace period after trial | [7 days] | Time before account restriction |
| Features during trial | [Full access] | Or limited to specific plan tier |

---

## Plan Upgrade / Downgrade

```mermaid
flowchart TD
    A([User Requests Plan Change]) --> B{Upgrade or Downgrade?}
    B -->|Upgrade| C[Calculate Prorated Amount]
    C --> D[Charge Prorated Difference]
    D --> E{Payment Successful?}
    E -->|Yes| F[Apply New Plan Immediately]
    E -->|No| G[Show Payment Error]
    G --> H[Keep Current Plan]

    B -->|Downgrade| I[Schedule Change at Period End]
    I --> J[Send Confirmation Email]
    J --> K{Period End Reached?}
    K -->|Yes| L[Apply New Plan]
    K -->|No| M[User Can Cancel Downgrade]

    F --> N([Plan Changed])
    L --> N
    H --> O([No Change])
    M --> O
```

### Plan Change Rules

| Scenario | Timing | Billing |
|----------|--------|---------|
| Upgrade | Immediate | Prorated charge for remainder of period |
| Downgrade | End of current period | No refund, features available until period ends |
| Same-tier feature add-on | Immediate | Additional charge prorated |
| Quantity change (seats) | Immediate for adds, end of period for removes | Prorated for additions |

---

## Cancellation and Retention

```mermaid
flowchart TD
    A([User Clicks Cancel]) --> B[Show Cancellation Survey]
    B --> C{Reason Category?}
    C -->|Too Expensive| D[Offer Discount / Downgrade]
    C -->|Missing Feature| E[Show Roadmap / Workaround]
    C -->|Not Using It| F[Offer Pause Instead]
    C -->|Switching to Competitor| G[Offer Extended Trial of Premium]
    C -->|Other| H[Collect Feedback]

    D --> I{Accepted Offer?}
    E --> I
    F --> I
    G --> I
    H --> J

    I -->|Yes| K[Apply Retention Offer]
    I -->|No| J[Confirm Cancellation]
    J --> L[Schedule End at Period End]
    L --> M[Send Cancellation Confirmation]
    M --> N[Send Win-Back Email Day 7]
    N --> O[Send Win-Back Email Day 30]

    K --> P([Retained])
    O --> Q([Churned])
```

### Retention Offers

| Cancel Reason | Offer | Implementation |
|---------------|-------|----------------|
| Too expensive | 20% discount for 3 months | Apply coupon to subscription |
| Not using it | Pause subscription for up to 3 months | Set subscription to `paused` |
| Missing feature | Extend current plan free for 1 month | Apply 100% off coupon for 1 period |
| Switching | Offer premium trial period | Upgrade plan with trial |

### Cancellation Rules

- Cancellation takes effect at end of current billing period
- User retains access until period ends
- No prorated refunds for partial periods (configurable)
- User can reactivate before period end without losing data
- After period end, account moves to free tier or is deactivated

---

## Renewal and Dunning

```mermaid
flowchart TD
    A([Renewal Date]) --> B[Attempt Payment]
    B --> C{Payment Successful?}
    C -->|Yes| D[Renew Subscription]
    D --> E[Send Receipt Email]

    C -->|No| F[Mark as Past Due]
    F --> G[Send Failed Payment Email 1]
    G --> H[Wait 3 Days]
    H --> I[Retry Payment]
    I --> J{Successful?}
    J -->|Yes| D
    J -->|No| K[Send Failed Payment Email 2]
    K --> L[Wait 5 Days]
    L --> M[Retry Payment]
    M --> N{Successful?}
    N -->|Yes| D
    N -->|No| O[Send Final Warning Email]
    O --> P[Wait 7 Days]
    P --> Q[Final Retry]
    Q --> R{Successful?}
    R -->|Yes| D
    R -->|No| S[Cancel Subscription]
    S --> T[Send Cancellation Email]

    E --> U([Active])
    T --> V([Cancelled - Payment Failed])
```

### Dunning Schedule

| Attempt | Timing | Email | Access |
|---------|--------|-------|--------|
| 1st failure | Day 0 | "Payment failed, update card" | Full access |
| 2nd attempt | Day 3 | "Still unable to charge" | Full access |
| 3rd attempt | Day 8 | "Final warning" | Reduced access (read-only) |
| Final attempt | Day 15 | "Subscription cancelled" | Downgrade to free |

---

## Refund Processing

| Scenario | Policy | Implementation |
|----------|--------|----------------|
| Within 24 hours of charge | Full refund, no questions | Automatic via API |
| Within 14 days | Full refund on request | Manual review, then API |
| After 14 days | Pro-rated or case-by-case | Manual review required |
| Duplicate charge | Always full refund | Automatic detection + refund |
| Fraud | Full refund + account review | Flag account, refund, investigate |

### Refund Steps

1. Customer requests refund (support ticket or self-service)
2. System checks refund eligibility based on policy
3. If eligible: process refund via Stripe, adjust subscription
4. Send refund confirmation email
5. Log refund in audit trail
6. If subscription was cancelled due to refund, handle access accordingly

---

## Webhook Events to Handle

| Stripe Event | Action |
|--------------|--------|
| `customer.subscription.created` | Record new subscription |
| `customer.subscription.updated` | Update plan, status, period dates |
| `customer.subscription.deleted` | Mark subscription as cancelled |
| `invoice.paid` | Record successful payment, send receipt |
| `invoice.payment_failed` | Start dunning flow, notify customer |
| `customer.subscription.trial_will_end` | Send trial ending email (3 days before) |
| `charge.refunded` | Record refund, adjust entitlements |

---

## Database State Machine

```
trialing --> active          (payment successful)
trialing --> cancelled       (trial expired, no payment)
active --> past_due          (payment failed)
active --> cancelled         (user cancelled)
active --> paused            (user paused)
past_due --> active          (payment retry successful)
past_due --> cancelled       (all retries exhausted)
paused --> active            (user resumed)
cancelled --> active         (user resubscribed)
```
