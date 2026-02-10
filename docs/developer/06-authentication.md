# Authentication Developer Guide

> Auth flows, session management, token handling, and security patterns.

## Auth Architecture Overview

```mermaid
graph TB
    subgraph Client["Client"]
        Login[Login Page]
        Social[Social Login Buttons]
        Register[Registration Form]
        Protected[Protected Routes]
    end

    subgraph Middleware["Auth Middleware"]
        TokenVerify[Token Verification]
        SessionResolve[Session Resolution]
        TenantResolve[Tenant Resolution]
        RoleCheck[Role / Permission Check]
    end

    subgraph Providers["Auth Providers (choose one)"]
        Custom[Custom JWT Auth]
        AuthZero[Auth0]
        Clerk[Clerk]
        Supabase[Supabase Auth]
    end

    Client --> Middleware
    Middleware --> Providers
```

> **Decision Reference**: See `decisions/AUTH_CHOICES.md` for the rationale behind provider selection.

---

## Auth Flow: Custom JWT

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant API as API Server
    participant DB as Database

    U->>App: Submit login form
    App->>API: POST /auth/login {email, password}
    API->>DB: Lookup user, verify password (bcrypt/argon2)
    API->>API: Generate access token (JWT, 15min) + refresh token (7d)
    API->>DB: Store refresh token hash
    API-->>App: Set httpOnly cookies
    App->>App: Redirect to dashboard

    Note over App,API: Token Refresh
    App->>API: Request with expired access token
    API->>DB: Validate refresh token
    API-->>App: New access token cookie
```

## Auth Flow: Third-Party Provider

```mermaid
sequenceDiagram
    participant U as User
    participant App as Frontend
    participant Provider as Auth Provider
    participant API as API Server
    participant DB as Database

    U->>App: Click Sign In
    App->>Provider: Redirect to provider login
    Provider-->>App: Redirect with auth code
    App->>API: GET /auth/callback {token}
    API->>Provider: Verify token
    API->>DB: Find or create user record
    API-->>App: Session established
```

---

## Session Management

```typescript
// {PROJECT_NAME}/src/types/auth.ts
interface Session {
  userId: string;
  tenantId: string;
  role: "owner" | "admin" | "member";
  permissions: string[];
  expiresAt: Date;
}
```

```mermaid
stateDiagram-v2
    [*] --> Active: Login / Register
    Active --> Refreshed: Access token expires, refresh succeeds
    Refreshed --> Active: New access token issued
    Active --> Expired: Refresh token expires
    Active --> Revoked: Logout / admin revokes
    Expired --> [*]
    Revoked --> [*]
```

---

## Token Handling

| Token | Lifetime | Storage | Contains |
|-------|----------|---------|----------|
| Access (JWT) | 15 min | httpOnly Secure SameSite=Lax cookie | userId, tenantId, role |
| Refresh | 7 days | httpOnly Secure SameSite=Strict cookie | Opaque (no claims) |

---

## Protected Route Patterns

### Server-Side
```typescript
function authenticate() {
  return async (req: Request, res: Response, next: NextFunction) => {
    const token = extractToken(req);
    if (!token) return res.status(401).json({ error: "Authentication required" });
    try {
      const payload = jwt.verify(token, config.auth.jwtSecret) as TokenPayload;
      req.user = { id: payload.sub, tenantId: payload.tid, role: payload.role };
      next();
    } catch {
      return res.status(401).json({ error: "Invalid or expired token" });
    }
  };
}

function requireRole(...roles: string[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({ error: "Insufficient permissions" });
    }
    next();
  };
}
```

### Client-Side
```typescript
function ProtectedRoute({ children, requiredRole }: Props) {
  const { user, isLoading } = useAuth();
  if (isLoading) return <LoadingSpinner />;
  if (!user) return <Navigate to="/login" />;
  if (requiredRole && user.role !== requiredRole) return <Navigate to="/unauthorized" />;
  return children;
}
```

---

## Multi-Tenant Auth

```mermaid
graph LR
    A[User authenticates] --> B{How many tenants?}
    B -->|One| C[Auto-select tenant]
    B -->|Multiple| D[Show tenant picker]
    C --> F[Set tenant context]
    D --> E[User selects] --> F
```

---

## Social Login

```typescript
const socialProviders = {
  google: {
    authUrl: "https://accounts.google.com/o/oauth2/v2/auth",
    tokenUrl: "https://oauth2.googleapis.com/token",
    scopes: ["email", "profile"],
  },
  github: {
    authUrl: "https://github.com/login/oauth/authorize",
    tokenUrl: "https://github.com/login/oauth/access_token",
    scopes: ["user:email"],
  },
  // TODO: Add additional social providers
};
```

---

## Password Reset Flow

```mermaid
sequenceDiagram
    participant U as User
    participant API as API
    participant DB as Database
    participant Email as Email Service

    U->>API: POST /auth/forgot-password {email}
    API->>DB: Generate reset token (hash stored, expires 1h)
    API->>Email: Send reset link
    API-->>U: 200 OK (always, prevent email enumeration)
    U->>API: POST /auth/reset-password {token, newPassword}
    API->>DB: Verify token, update password hash
    API->>DB: Invalidate all existing sessions
```

## Email Verification Flow

```mermaid
sequenceDiagram
    participant U as User
    participant API as API
    participant DB as Database
    participant Email as Email Service

    API->>DB: Create user (email_verified: false)
    API->>Email: Send verification email
    U->>API: GET /auth/verify?token=xxx
    API->>DB: Validate token, set email_verified: true
```

---

## Security Checklist

- [ ] Passwords hashed with bcrypt (cost 12+) or argon2
- [ ] Tokens stored in HTTP-only, Secure, SameSite cookies
- [ ] CSRF protection enabled for cookie-based auth
- [ ] Rate limiting on login / registration / password reset
- [ ] Account lockout after N failed attempts
- [ ] Refresh token rotation on each use
- [ ] All sessions invalidated on password change
- [ ] Email enumeration prevented (consistent responses)

---

## Related Docs

- [Architecture](./02-architecture.md) -- How auth middleware fits in the system layers
- [Key Flows](./03-key-flows.md) -- Auth-related sequence diagrams
- [Backend Flexibility](./backend-flexibility.md) -- Swapping auth providers
