# Key Flows

> Sequence diagrams for the most important operations in the system. Use these as references when tracing bugs, onboarding, or adding new flows.

## User Registration and Onboarding

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant API as API
    participant Auth as Auth Provider
    participant DB as Database
    participant Email as Email Service

    U->>App: Fill registration form
    App->>API: POST /auth/register {email, password, name}
    API->>API: Validate input
    API->>Auth: Create user account
    Auth-->>API: User created (userId)
    API->>DB: Create tenant + user record
    API->>DB: Create default subscription (free tier)
    API->>Email: Send welcome / verification email
    API-->>App: 201 Created {user, session}
    App->>App: Redirect to onboarding wizard
    U->>App: Complete onboarding steps
    App->>API: POST /onboarding/complete {preferences}
    API->>DB: Update tenant settings
    API-->>App: 200 OK
    App->>App: Redirect to dashboard
```

## Authentication Flow

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant API as API
    participant Auth as Auth Provider
    participant DB as Database

    U->>App: Enter credentials
    App->>API: POST /auth/login {email, password}
    API->>Auth: Verify credentials
    Auth-->>API: Valid (tokens)
    API->>DB: Load user + tenant + subscription
    API->>DB: Create session record
    API-->>App: 200 OK {user, accessToken}
    App->>App: Store token (httpOnly cookie)
    App->>App: Redirect to dashboard

    Note over App,API: Subsequent requests
    App->>API: GET /api/resource (Authorization header)
    API->>API: Validate token via middleware
    API->>DB: Resolve tenant context
    API-->>App: 200 OK {data}
```

## Subscription Purchase

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant API as API
    participant Pay as Payment Provider
    participant DB as Database
    participant Email as Email Service

    U->>App: Select plan, click Subscribe
    App->>API: POST /billing/checkout {planId}
    API->>DB: Look up plan details
    API->>Pay: Create checkout session
    Pay-->>API: Checkout URL
    API-->>App: {checkoutUrl}
    App->>Pay: Redirect to payment page
    U->>Pay: Enter payment details, confirm
    Pay->>API: Webhook: checkout.session.completed
    API->>DB: Create / update subscription
    API->>DB: Update tenant plan reference
    API->>Email: Send subscription confirmation
    Pay-->>U: Redirect to success page
    App->>API: GET /billing/status
    API-->>App: {subscription: active, plan: ...}
```

## Feature Access Check

```mermaid
sequenceDiagram
    participant App as Frontend
    participant API as API
    participant Feature as Feature Service
    participant DB as Database
    participant Cache as Cache

    App->>API: GET /api/protected-feature
    API->>Feature: checkAccess(tenantId, "feature_key")
    Feature->>Cache: Lookup cached plan features
    alt Cache hit
        Cache-->>Feature: Features list
    else Cache miss
        Feature->>DB: Load subscription + plan + features
        DB-->>Feature: Data
        Feature->>Cache: Store (TTL: 5 min)
    end
    Feature-->>API: {allowed: true/false, limit: N}
    alt Allowed
        API->>API: Execute feature logic
        API-->>App: 200 OK {result}
    else Denied
        API-->>App: 403 Forbidden {upgradeUrl}
    end
```

## Webhook Processing

```mermaid
sequenceDiagram
    participant Ext as External Service
    participant WH as Webhook Endpoint
    participant Q as Job Queue
    participant Handler as Webhook Handler
    participant DB as Database
    participant Email as Email Service

    Ext->>WH: POST /webhooks/{provider}
    WH->>WH: Verify signature
    WH->>WH: Parse event type
    WH->>Q: Enqueue webhook job {event}
    WH-->>Ext: 200 OK (acknowledge fast)

    Q->>Handler: Process event
    alt payment_succeeded
        Handler->>DB: Update subscription status
        Handler->>Email: Send receipt
    else payment_failed
        Handler->>DB: Mark subscription past_due
        Handler->>Email: Send payment failure notice
    else subscription_cancelled
        Handler->>DB: Mark subscription cancelled
        Handler->>Email: Send cancellation confirmation
    end
    Handler->>DB: Log webhook event (idempotency)
```

## Background Job Execution

```mermaid
sequenceDiagram
    participant Trigger as Trigger (API/Cron/Webhook)
    participant Q as Job Queue
    participant Worker as Worker Process
    participant DB as Database
    participant Ext as External Service

    Trigger->>Q: Enqueue job {type, payload}
    Q->>Q: Store job (pending)

    Worker->>Q: Poll for jobs
    Q-->>Worker: Job {type, payload}
    Worker->>Worker: Execute job handler

    alt Success
        Worker->>DB: Persist results
        Worker->>Q: Mark job completed
    else Failure (retryable)
        Worker->>Q: Mark job failed, schedule retry
        Note over Q: Exponential backoff
    else Failure (permanent)
        Worker->>Q: Mark job dead
        Worker->>Ext: Alert monitoring service
    end
```

---

## Template: Adding a Custom Flow

Use this template when documenting a new flow:

```markdown
## {Flow Name}

**Trigger:** {What initiates this flow}
**Actors:** {Who/what is involved}
**Outcome:** {What state changes result}

\`\`\`mermaid
sequenceDiagram
    participant A as {Actor 1}
    participant B as {Actor 2}
    participant C as {Actor 3}

    A->>B: {Step 1 description}
    B->>C: {Step 2 description}
    C-->>B: {Response}
    B-->>A: {Final response}
\`\`\`

### Error Cases
- {Error scenario 1}: {How it is handled}
- {Error scenario 2}: {How it is handled}

### Side Effects
- {Side effect 1, e.g., email sent}
- {Side effect 2, e.g., audit log entry}
```

---

## Related Docs

- [Architecture](./02-architecture.md) -- The layers these flows traverse
- [Integrations](./04-integrations.md) -- External services referenced in these flows
- [Scenarios](./05-scenarios.md) -- Full end-to-end user journeys built from these flows
