# Workflow Automation Guide

How to connect your SaaS to the rest of the world using webhooks, events, and automation platforms. This guide covers the architecture, common patterns, and security considerations.

---

## 1. Webhook Architecture

Webhooks are HTTP callbacks. When something happens in your system, you send a POST request to a URL. When something happens in an external system, they send a POST request to you.

### Outbound Webhooks (Your System to External)

Your app fires events that other systems consume.

```
[User Action] -> [Your App] -> [POST to webhook URL] -> [External System]
```

### Inbound Webhooks (External to Your System)

External systems notify you when something happens.

```
[External Event] -> [POST to your endpoint] -> [Your App] -> [Process Event]
```

### Architecture Principles

- **Fire and forget**: Outbound webhooks should not block your main application flow. Queue them.
- **Idempotent processing**: Inbound webhooks may be delivered more than once. Design your handlers to handle duplicates.
- **Retry logic**: If delivery fails, retry with exponential backoff (1s, 5s, 30s, 5m, 30m).
- **Logging**: Log every webhook sent and received. You will need this for debugging.

---

## 2. Event Catalog

Define every event your system can produce. This becomes the contract between your app and any integrations.

### Event Catalog Template

| Event Name | Description | Trigger | Payload Fields |
|---|---|---|---|
| `user.created` | New user registered | User completes signup | `user_id`, `email`, `plan`, `created_at` |
| `user.updated` | User profile changed | User updates profile | `user_id`, `changed_fields`, `updated_at` |
| `user.deleted` | User account removed | User deletes account | `user_id`, `deleted_at` |
| `subscription.created` | New subscription started | Payment succeeds | `user_id`, `plan`, `amount`, `currency`, `started_at` |
| `subscription.updated` | Plan changed | User upgrades/downgrades | `user_id`, `old_plan`, `new_plan`, `effective_at` |
| `subscription.canceled` | Subscription canceled | User cancels | `user_id`, `plan`, `canceled_at`, `effective_end` |
| `payment.succeeded` | Payment processed | Stripe webhook | `user_id`, `amount`, `currency`, `invoice_id` |
| `payment.failed` | Payment failed | Stripe webhook | `user_id`, `amount`, `error`, `retry_at` |
| `usage.threshold` | Usage limit approached | Background job | `user_id`, `metric`, `current`, `limit`, `percent` |

### Payload Structure

Standardize your event payloads:

```json
{
  "event": "user.created",
  "timestamp": "2025-01-15T10:30:00Z",
  "data": {
    "user_id": "usr_abc123",
    "email": "user@example.com",
    "plan": "pro"
  },
  "metadata": {
    "event_id": "evt_xyz789",
    "version": "1.0"
  }
}
```

Always include:
- **event_id**: Unique identifier for idempotency
- **timestamp**: When the event occurred
- **version**: Schema version for forward compatibility

---

## 3. Integration Platforms

You do not need to build every integration from scratch. These platforms connect your webhooks to hundreds of services.

### Zapier

- **Best for**: Non-technical users, wide app catalog
- **Setup**: Create a Zap with your webhook as the trigger
- **Cost**: Free for basic, paid for multi-step workflows
- **Docs**: https://zapier.com/developer

### Make (formerly Integromat)

- **Best for**: Complex multi-step workflows, visual builder
- **Setup**: Create a scenario with a webhook module
- **Cost**: More generous free tier than Zapier
- **Docs**: https://www.make.com/en/integrations

### n8n

- **Best for**: Self-hosted, developer-friendly, full control
- **Setup**: Deploy on your infrastructure, create workflows via UI or code
- **Cost**: Free (self-hosted) or paid (cloud)
- **Docs**: https://docs.n8n.io/

### Direct Integrations

For high-volume or critical integrations, consider direct API integration:
- **Stripe**: Payment events via Stripe webhooks
- **Slack**: Notifications via Slack Incoming Webhooks
- **Email providers**: Transactional emails via API
- **CRM**: User data sync via API

---

## 4. Common Automation Templates

### New User Welcome Sequence

**Trigger**: `user.created`

```
1. [Immediate]  Send welcome email with getting-started guide
2. [+1 day]     Send tips email highlighting key feature
3. [+3 days]    Check if user completed onboarding
                 -> If yes: send "power user tips" email
                 -> If no: send "need help?" email with support link
4. [+7 days]    Send social proof email (testimonials, case studies)
5. [+14 days]   If on free trial: send upgrade reminder with value recap
```

**Implementation**:
- Queue emails via your email provider's drip campaign feature
- Or use a webhook to trigger a sequence in ConvertKit / Loops / Customer.io
- Cancel the sequence if the user converts to paid

### Payment Received

**Trigger**: `payment.succeeded`

```
1. [Immediate]  Generate and send receipt email
2. [Immediate]  Update user's subscription status in database
3. [Immediate]  Send internal Slack notification (for early-stage celebration)
4. [Immediate]  Log event in analytics
5. [+1 day]     If first payment: send "thank you" email with tips for paid features
```

### Subscription Canceled - Retention Flow

**Trigger**: `subscription.canceled`

```
1. [Immediate]  Show exit survey (why are you leaving?)
2. [Immediate]  Send confirmation email with end-of-service date
3. [+1 day]     If reason was "too expensive": send discount offer
4. [+3 days]    Send "what you'll lose" email highlighting their usage/data
5. [+7 days]    Final win-back email with limited-time offer
6. [End date]   Export user's data and send download link
7. [+30 days]   "We miss you" email with product updates since they left
```

**Important**: Respect the user's decision. Do not be aggressive. One or two attempts to retain is fine; more than that is annoying.

### Usage Threshold Alert

**Trigger**: `usage.threshold` (at 80% and 100%)

```
At 80%:
1. [Immediate]  In-app notification: "You've used 80% of your plan limit"
2. [Immediate]  Email notification with upgrade CTA

At 100%:
1. [Immediate]  In-app banner: "You've reached your plan limit"
2. [Immediate]  Email with clear upgrade path
3. [Immediate]  Graceful degradation (soft limit) or hard block (depends on product)
```

### Failed Payment - Dunning Flow

**Trigger**: `payment.failed`

```
1. [Immediate]  Email: "Payment failed, please update your card"
2. [+3 days]    Retry payment automatically
3. [+3 days]    If retry fails: email with urgency + update card link
4. [+7 days]    Final retry
5. [+7 days]    If final retry fails: downgrade to free or suspend account
6. [+7 days]    Email: "Your account has been downgraded, here's how to reactivate"
```

---

## 5. Webhook Security

Webhooks are HTTP endpoints. Without security, anyone can send fake events to your system.

### Signing Outbound Webhooks

Sign every outbound webhook so the receiver can verify it came from you:

```javascript
const crypto = require('crypto');

function signPayload(payload, secret) {
  const signature = crypto
    .createHmac('sha256', secret)
    .update(JSON.stringify(payload))
    .digest('hex');
  return signature;
}

// Include in headers:
// X-Webhook-Signature: sha256=<signature>
// X-Webhook-Timestamp: <unix timestamp>
```

### Verifying Inbound Webhooks

Always verify signatures on inbound webhooks. Every major provider (Stripe, GitHub, etc.) signs their webhooks.

**Stripe example:**

```javascript
const event = stripe.webhooks.constructEvent(
  requestBody,
  request.headers['stripe-signature'],
  process.env.STRIPE_WEBHOOK_SECRET
);
```

### Security Checklist

- [ ] All inbound webhook endpoints verify signatures
- [ ] Webhook secrets are stored in environment variables, never in code
- [ ] Endpoints reject requests with invalid or missing signatures
- [ ] Timestamps are checked to prevent replay attacks (reject events older than 5 minutes)
- [ ] Webhook endpoints use HTTPS only
- [ ] Rate limiting on webhook endpoints to prevent abuse
- [ ] Failed verification attempts are logged and monitored
- [ ] Webhook secrets are rotated periodically

### IP Allowlisting (Optional)

Some providers publish their webhook source IPs. If your infrastructure supports it:
- [ ] Allowlist known webhook source IPs
- [ ] Keep the allowlist updated (providers change IPs)
- [ ] Have a fallback plan if an IP changes unexpectedly

---

## 6. Testing Webhooks

### Local Development

- Use **ngrok** or **localtunnel** to expose your local server
- Stripe CLI has a built-in webhook forwarder: `stripe listen --forward-to localhost:3000/api/webhooks/stripe`
- Log every incoming webhook payload during development

### Staging

- [ ] Configure staging webhook endpoints in all external services
- [ ] Verify end-to-end flow for each webhook type
- [ ] Test failure scenarios (what happens if your endpoint is down?)

### Production Monitoring

- [ ] Log all webhook deliveries (inbound and outbound) with timestamps
- [ ] Alert on webhook processing failures
- [ ] Monitor webhook processing latency
- [ ] Set up a dead letter queue for failed webhook processing
- [ ] Review webhook logs weekly for anomalies

---

## 7. Building a Webhook Management UI (Optional)

If you offer webhooks to your customers (outbound), consider building:

- [ ] Endpoint registration UI (URL, events to subscribe to, secret)
- [ ] Delivery log with payloads and response codes
- [ ] Manual retry button for failed deliveries
- [ ] Test event button (sends a sample payload)
- [ ] Event type documentation

This is a significant investment but becomes important if integrations are a core part of your product value.

---

*Start simple: a few key events, one or two automation flows, and proper signature verification. You can add sophistication as your product and user base grow. The security section is not optional -- implement it from day one.*
