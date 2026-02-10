# End-to-End Scenarios

> Complete user journey walkthroughs showing how all system components collaborate.

## Scenario Format

Each scenario includes: **Actors**, **Preconditions**, **Steps** (with diagram), **Postconditions**, and **Verification checklist**.

---

## Scenario 1: New User Signs Up and Activates Subscription

**Actors:** Anonymous visitor | **Postconditions:** Active tenant with paid subscription

```mermaid
sequenceDiagram
    participant U as Visitor
    participant App as Frontend
    participant API as API
    participant DB as Database
    participant Pay as Payment Provider
    participant Email as Email Service

    Note over U,Email: Registration
    U->>App: Click Sign Up
    App->>API: POST /auth/register
    API->>DB: Create tenant (free tier) + user (owner)
    API->>Email: Send verification email

    Note over U,Email: Email Verification
    U->>API: POST /auth/verify-email {token}
    API->>DB: Set email_verified = true

    Note over U,Email: Subscription
    U->>App: Select Pro plan
    App->>API: POST /billing/checkout {planId}
    API->>Pay: Create checkout session
    U->>Pay: Complete payment
    Pay->>API: Webhook: checkout.session.completed
    API->>DB: Activate subscription
    API->>Email: Send confirmation
```

### Verify
- [ ] Tenant created with default plan, user has `owner` role
- [ ] Subscription linked to payment provider, features updated

---

## Scenario 2: User Upgrades Plan

**Actors:** Authenticated owner/admin | **Postconditions:** Higher tier active, prorated billing

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant API as API
    participant Pay as Payment Provider
    participant DB as Database

    U->>App: Open Billing, click Upgrade
    App->>API: POST /billing/change-plan {newPlanId}
    API->>Pay: Update subscription (prorate)
    API->>DB: Update subscription + tenant plan
    API-->>App: Confirmation
    App->>App: Refresh feature flags
```

### Verify
- [ ] Proration correct, new features accessible immediately
- [ ] Downgrade path available (reverse flow)

---

## Scenario 3: Admin Manages Team Members

**Actors:** Admin, invited user | **Postconditions:** New member in tenant

```mermaid
sequenceDiagram
    participant A as Admin
    participant API as API
    participant DB as Database
    participant Email as Email Service
    participant I as Invited User

    A->>API: POST /team/invite {email, role}
    API->>DB: Check seat limit, create invitation
    API->>Email: Send invitation email
    I->>API: POST /auth/register-invited {token, password}
    API->>DB: Create user in tenant, mark invitation accepted
```

### Verify
- [ ] Seat limit enforced per plan, invitation expires after configured period
- [ ] Role correctly assigned, admin can revoke pending invitations

---

## Scenario 4: Payment Fails and Recovery

**Actors:** System (automated), affected user | **Postconditions:** Recovered or downgraded

```mermaid
sequenceDiagram
    participant Pay as Payment Provider
    participant API as Webhook Handler
    participant DB as Database
    participant Email as Email Service
    participant U as User

    Pay->>API: Webhook: invoice.payment_failed
    API->>DB: Subscription -> past_due
    API->>Email: Payment failure notification

    alt Payment succeeds on retry
        Pay->>API: Webhook: invoice.payment_succeeded
        API->>DB: Subscription -> active
    else All retries exhausted
        Pay->>API: Webhook: subscription.deleted
        API->>DB: Cancel subscription, downgrade to free
        API->>Email: Cancellation notice
        U->>API: POST /billing/reactivate
        Note over U,Pay: Standard checkout flow
    end
```

### Verify
- [ ] Grace period before restriction, data preserved on downgrade
- [ ] Easy reactivation path, webhook idempotency enforced

---

## Scenario 5: User Exports Their Data

**Actors:** Authenticated user | **Postconditions:** Downloadable archive

```mermaid
sequenceDiagram
    participant U as User
    participant API as API
    participant Q as Job Queue
    participant Worker as Worker
    participant Storage as File Storage
    participant Email as Email Service

    U->>API: POST /account/export
    API->>Q: Enqueue export job
    API-->>U: 202 Accepted {jobId}
    Worker->>Q: Pick up job
    Worker->>Storage: Upload archive
    Worker->>Email: Send download link
    U->>API: GET /account/export/{jobId}/download
    API->>Storage: Generate signed URL (24h expiry)
```

### Verify
- [ ] Export includes all user data (GDPR), large exports async
- [ ] Download link expires, rate limiting on export requests

---

## Template: Adding a New Scenario

```markdown
## Scenario N: {Title}

**Actors:** {Who} | **Postconditions:** {Expected state}

\`\`\`mermaid
sequenceDiagram
    participant A as {Actor}
    participant B as {Component}
    A->>B: {Action}
    B-->>A: {Response}
\`\`\`

### Verify
- [ ] {Assertion 1}
- [ ] {Assertion 2}
```

---

## Related Docs

- [Key Flows](./03-key-flows.md) -- Individual flow diagrams composing these scenarios
- [Domain Model](./01-domain-model.md) -- Entities referenced in these scenarios
