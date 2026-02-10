# System Architecture Developer Guide

> How the system is structured in layers, how data flows, and how components interact.

## System Layers

```mermaid
graph TB
    subgraph Client["Client Layer"]
        UI[UI Components]
        Pages[Pages / Routes]
        Hooks[Custom Hooks]
        ClientState[Client State]
    end

    subgraph API["API Layer"]
        Router[Router / Route Handlers]
        Middleware[Middleware Stack]
        Validation[Input Validation]
    end

    subgraph Service["Service Layer"]
        AuthService[Auth Service]
        TenantService[Tenant Service]
        BillingService[Billing Service]
        NotificationService[Notification Service]
        FeatureService[Feature Gate Service]
    end

    subgraph Provider["Provider Abstraction Layer"]
        AuthProvider[Auth Provider]
        DBProvider[Database Provider]
        StorageProvider[Storage Provider]
        EmailProvider[Email Provider]
        PaymentProvider[Payment Provider]
    end

    subgraph External["External Services"]
        DB[(Database)]
        Cache[(Cache)]
        FileStore[(File Storage)]
        PaymentAPI[Payment API]
        EmailAPI[Email Service]
    end

    Client --> API
    API --> Service
    Service --> Provider
    Provider --> External
```

## Request Lifecycle

```mermaid
sequenceDiagram
    participant C as Client
    participant R as Router
    participant MW as Middleware
    participant V as Validation
    participant S as Service
    participant P as Provider
    participant DB as Database

    C->>R: HTTP Request
    R->>MW: Pass through middleware stack
    MW->>MW: Auth check
    MW->>MW: Rate limiting
    MW->>MW: Tenant resolution
    MW->>V: Validate input
    V->>S: Call service method
    S->>P: Use provider abstraction
    P->>DB: Query / mutate
    DB-->>P: Result
    P-->>S: Typed response
    S-->>R: Service result
    R-->>C: HTTP Response
```

## Data Flow Patterns

### Read Path (Query)
```mermaid
graph LR
    A[Component] -->|hook call| B[Custom Hook]
    B -->|fetch| C[API Route]
    C -->|validate| D[Service]
    D -->|query| E[Database]
    E -->|rows| D
    D -->|transform| C
    C -->|JSON| B
    B -->|state update| A
```

### Write Path (Mutation)
```mermaid
graph LR
    A[Form Submit] -->|action| B[API Route]
    B -->|validate & sanitize| C[Service]
    C -->|transaction| D[Database]
    C -->|side effect| E[Email / Webhook]
    D -->|confirm| C
    C -->|result| B
    B -->|response| A
    A -->|invalidate cache| F[Refetch Queries]
```

---

## Component Interaction Patterns

### Service-to-Service Communication
Services communicate through direct method calls, never through HTTP internally.

```typescript
// {PROJECT_NAME}/src/services/billing.service.ts
class BillingService {
  constructor(
    private tenantService: TenantService,
    private notificationService: NotificationService,
    private paymentProvider: PaymentProvider,
  ) {}

  async upgradePlan(tenantId: string, newPlanId: string) {
    const tenant = await this.tenantService.getById(tenantId);
    const result = await this.paymentProvider.updateSubscription(/* ... */);
    await this.notificationService.sendPlanChanged(tenant, newPlanId);
    return result;
  }
}
```

### Middleware Stack

```typescript
// {PROJECT_NAME}/src/middleware/stack.ts
const protectedRoute = [
  rateLimiter({ windowMs: 60_000, max: 100 }),
  authenticate(),        // Verify token, attach user to context
  resolveTenant(),       // Resolve tenant from user or header
  checkSubscription(),   // Verify active subscription
  // Route handler runs here
];

const adminRoute = [
  ...protectedRoute,
  requireRole("admin"),  // Verify user role
];
```

---

## State Management Architecture

```mermaid
graph TB
    subgraph Server["Server State (async)"]
        API_Cache[Query Cache]
        Optimistic[Optimistic Updates]
    end

    subgraph Client_State["Client State (sync)"]
        UI_State[UI State - modals, forms]
        Auth_State[Auth State - session, user]
        Theme[Theme / Preferences]
    end

    subgraph Persistent["Persistent State"]
        LocalStorage[Local Storage]
        Cookies[HTTP-Only Cookies]
    end

    Server --> |hydrate| Client_State
    Client_State --> |persist| Persistent
    Persistent --> |restore| Client_State
```

### State Categories

| Category | Examples | Storage | Tool |
|----------|----------|---------|------|
| Server state | Entities, lists, counts | Query cache | React Query / SWR / tRPC |
| Auth state | Session, user, permissions | Cookie + context | Auth provider SDK |
| UI state | Modals, sidebar, form drafts | Component / context | React state / Zustand |
| Preferences | Theme, locale, layout | Local storage | Custom hook |

---

## Error Handling Patterns

### Error Hierarchy
```typescript
// {PROJECT_NAME}/src/lib/errors.ts
class AppError extends Error {
  constructor(message: string, public code: string, public statusCode: number) {
    super(message);
  }
}

class NotFoundError extends AppError {
  constructor(resource: string, id: string) {
    super(`${resource} not found: ${id}`, "NOT_FOUND", 404);
  }
}

class ForbiddenError extends AppError {
  constructor(msg = "Insufficient permissions") { super(msg, "FORBIDDEN", 403); }
}

class ValidationError extends AppError {
  constructor(public details: Record<string, string[]>) {
    super("Validation failed", "VALIDATION_ERROR", 400);
  }
}
```

### Global Error Handler
```typescript
function errorHandler(err: Error, req: Request, res: Response) {
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({ error: { code: err.code, message: err.message } });
  }
  logger.error("Unhandled error", { error: err, path: req.path });
  return res.status(500).json({ error: { code: "INTERNAL_ERROR", message: "An unexpected error occurred" } });
}
```

---

## Key Architectural Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| API style | REST / tRPC / GraphQL | {FILL_IN} |
| State management | {TOOL} | {FILL_IN} |
| Database | {DATABASE} | {FILL_IN} |
| Auth | {PROVIDER} | {FILL_IN} |
| Deployment | {PLATFORM} | {FILL_IN} |

---

## Related Docs

- [Domain Model](./01-domain-model.md) -- The entities these layers operate on
- [Key Flows](./03-key-flows.md) -- How these layers collaborate in real operations
- [Backend Flexibility](./backend-flexibility.md) -- Deep dive on the provider abstraction layer
