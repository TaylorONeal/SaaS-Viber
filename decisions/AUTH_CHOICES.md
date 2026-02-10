# Authentication: Key Decisions

> **Prompt Guide**: Use this document to understand your options. Then use `docs/architecture/PromptGuide-Architecture.md` to generate your auth implementation plan.

## Why This Matters

Authentication is the first thing users touch and the last thing you want to migrate. Choose wrong and you're either paying too much, fighting limitations, or facing a painful migration at the worst possible time (when you're scaling). Choose right and auth becomes invisible infrastructure you never think about.

---

## Decision Matrix

| Factor | Local/Custom | Supabase Auth | Auth0 | Clerk | Firebase Auth |
|--------|-------------|---------------|-------|-------|---------------|
| Cost at 0-1K MAU | Free | Free | Free | Free (5K) | Free |
| Cost at 10K MAU | Server costs | Free | ~$230/mo | ~$25/mo | Free |
| Cost at 100K MAU | Server costs | $25/mo | ~$2,300/mo | ~$100/mo | $0.06/MAU |
| Social login | DIY | Built-in | Built-in | Built-in | Built-in |
| MFA/2FA | DIY | Built-in | Built-in | Built-in | Built-in |
| SSO/SAML | DIY | Enterprise | Built-in | Built-in | DIY |
| Self-hosted option | Yes | Yes (OSS) | No | No | No |
| Vendor lock-in risk | None | Low | Medium | Medium | High |
| Implementation effort | High | Low | Low | Very Low | Low |
| RLS integration | Manual | Native | Manual | Manual | Manual |
| React SDK quality | N/A | Good | Excellent | Excellent | Good |
| Email templates | DIY | Customizable | Customizable | Customizable | Limited |
| Passwordless/magic link | DIY | Built-in | Built-in | Built-in | Built-in |
| User management UI | DIY | Dashboard | Dashboard | Dashboard + Components | Dashboard |
| Session management | DIY | JWT + refresh | JWT + refresh | Session tokens | JWT |
| Rate limiting | DIY | Built-in | Built-in | Built-in | Built-in |

---

## Option 1: Supabase Auth

### When to Choose It
- You're already using Supabase for your database (obvious synergy)
- You want native Row-Level Security integration
- Budget is tight and you want generous free tier with low scaling costs
- You prefer open-source backing with self-host escape hatch

### Tradeoffs
- **Pro**: Tightest integration with PostgreSQL RLS -- auth policies live next to data policies
- **Pro**: GoTrue-based, open source, can self-host if needed
- **Pro**: Free tier is extremely generous (50K MAU)
- **Con**: UI components are functional but less polished than Clerk
- **Con**: Advanced features (SSO/SAML) require enterprise plan
- **Con**: Email deliverability on free tier is limited (use custom SMTP)

### Implementation Pattern

```typescript
// src/lib/auth/supabase-auth.ts
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
);

// Sign up
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'secure-password',
  options: {
    data: { full_name: 'Jane Doe', org_id: 'org_123' }
  }
});

// Sign in
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'secure-password',
});

// OAuth
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: { redirectTo: `${window.location.origin}/auth/callback` }
});

// Session listener
supabase.auth.onAuthStateChange((event, session) => {
  if (event === 'SIGNED_IN') { /* handle */ }
  if (event === 'SIGNED_OUT') { /* handle */ }
});
```

### Migration Path
- Export users via Supabase management API or direct DB access
- JWT format is standard; tokens work with most systems
- If self-hosting: GoTrue can run independently

---

## Option 2: Clerk

### When to Choose It
- You want the fastest possible implementation with best-in-class UI
- Pre-built `<SignIn />`, `<SignUp />`, `<UserButton />` components matter to you
- You need organization/multi-tenant support out of the box
- Developer experience is your top priority

### Tradeoffs
- **Pro**: Drop-in React components that look professional immediately
- **Pro**: Built-in organization management (perfect for multi-tenant SaaS)
- **Pro**: Excellent webhook system for syncing user data
- **Con**: No self-hosted option; you're trusting a third party
- **Con**: Costs scale linearly with MAU (predictable but adds up)
- **Con**: Must sync user data to your DB via webhooks for queries/joins

### Implementation Pattern

```typescript
// src/main.tsx
import { ClerkProvider } from '@clerk/clerk-react';

<ClerkProvider publishableKey={import.meta.env.VITE_CLERK_KEY}>
  <App />
</ClerkProvider>

// src/components/AuthGate.tsx
import { SignIn, useUser, useOrganization } from '@clerk/clerk-react';

function Dashboard() {
  const { user, isLoaded } = useUser();
  const { organization } = useOrganization();

  if (!isLoaded) return <Spinner />;
  if (!user) return <SignIn />;

  return <div>Welcome, {user.firstName} from {organization?.name}</div>;
}
```

### Migration Path
- Export via Clerk Backend API
- Standard JWT claims; can map to other providers
- User metadata is portable via API export

---

## Option 3: Auth0

### When to Choose It
- Enterprise sales are core to your business (SSO/SAML is essential)
- You need the most mature, battle-tested solution
- Compliance requirements demand specific certifications (SOC2, HIPAA)
- Complex authorization rules (RBAC, ABAC) are needed

### Tradeoffs
- **Pro**: Most feature-complete auth platform available
- **Pro**: Actions/Rules system for custom auth logic
- **Pro**: Excellent enterprise features (SSO, directory sync, breached password detection)
- **Con**: Pricing jumps dramatically at scale
- **Con**: Configuration complexity can slow down initial development
- **Con**: Free tier is limited to 7,500 MAU with restrictions

### Implementation Pattern

```typescript
// src/lib/auth/auth0-provider.tsx
import { Auth0Provider, useAuth0 } from '@auth0/auth0-react';

<Auth0Provider
  domain={import.meta.env.VITE_AUTH0_DOMAIN}
  clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
  authorizationParams={{
    redirect_uri: window.location.origin,
    audience: import.meta.env.VITE_AUTH0_AUDIENCE,
  }}
>
  <App />
</Auth0Provider>

// Usage
function Profile() {
  const { user, loginWithRedirect, logout, getAccessTokenSilently } = useAuth0();

  const callApi = async () => {
    const token = await getAccessTokenSilently();
    // Use token for API calls
  };
}
```

### Migration Path
- Bulk user export available
- Standard OIDC; compatible with most providers
- Can run Auth0 alongside new provider during migration

---

## Option 4: Firebase Auth

### When to Choose It
- You're already in the Google Cloud/Firebase ecosystem
- You want the largest free tier (no limit on email/password users)
- Mobile-first product where Firebase SDKs shine
- You need phone authentication as a primary method

### Tradeoffs
- **Pro**: Unlimited free tier for most auth methods
- **Pro**: Best phone/SMS authentication
- **Pro**: Deep integration with Firebase ecosystem
- **Con**: Highest vendor lock-in; deeply tied to Google infrastructure
- **Con**: No native SQL/RLS integration (Firestore security rules instead)
- **Con**: Limited customization of auth flows compared to Auth0/Clerk

### Implementation Pattern

```typescript
// src/lib/auth/firebase-auth.ts
import { initializeApp } from 'firebase/app';
import { getAuth, signInWithPopup, GoogleAuthProvider } from 'firebase/auth';

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);

// Google sign-in
const provider = new GoogleAuthProvider();
const result = await signInWithPopup(auth, provider);
const user = result.user;

// Auth state listener
auth.onAuthStateChanged((user) => {
  if (user) { /* signed in */ }
  else { /* signed out */ }
});
```

### Migration Path
- Firebase Admin SDK allows bulk user export (including password hashes)
- Password hashes use scrypt; can be imported to some providers
- Significant effort to migrate away; plan carefully

---

## Option 5: Local/Custom Auth

### When to Choose It
- Regulatory requirements mandate full data control
- You have deep auth expertise on the team
- Your auth requirements are truly unique
- You're building auth as a product feature itself

### Tradeoffs
- **Pro**: Complete control over every aspect
- **Pro**: Zero vendor dependency
- **Pro**: No per-user costs beyond your infrastructure
- **Con**: Security responsibility is entirely on you (this is serious)
- **Con**: Every feature (MFA, social login, email verification) is DIY
- **Con**: Ongoing maintenance burden for security patches

### Implementation Pattern

```typescript
// Only do this if you really know what you're doing
// Use battle-tested libraries: passport.js, lucia-auth, arctic

// src/lib/auth/custom-auth.ts
import { Lucia } from 'lucia';
import { DrizzlePostgreSQLAdapter } from '@lucia-auth/adapter-drizzle';

const adapter = new DrizzlePostgreSQLAdapter(db, sessionTable, userTable);
const lucia = new Lucia(adapter, {
  sessionCookie: { attributes: { secure: process.env.NODE_ENV === 'production' } },
  getUserAttributes: (attributes) => ({
    email: attributes.email,
    orgId: attributes.org_id,
    role: attributes.role,
  }),
});
```

### Migration Path
- You own everything, so migration is on your terms
- Standard bcrypt/argon2 hashes are portable
- Build your user export tooling from the start

---

## Multi-Tenant Auth Patterns

Multi-tenancy is the defining characteristic of SaaS. Your auth system must support it natively or you'll fight it forever.

### Tenant Isolation Strategies

**Strategy 1: Shared Database, Row-Level Isolation (Most Common)**
```sql
-- Every table has an org_id column
CREATE POLICY "tenant_isolation" ON documents
  USING (org_id = (auth.jwt() -> 'app_metadata' ->> 'org_id')::uuid);
```
- Best for: Most SaaS applications
- Pros: Simple, cost-effective, easy to manage
- Cons: Must be disciplined about always filtering by org_id

**Strategy 2: Schema-per-Tenant**
```sql
-- Each tenant gets their own schema
CREATE SCHEMA tenant_abc123;
CREATE TABLE tenant_abc123.documents (...);
```
- Best for: Regulated industries, enterprise clients demanding isolation
- Pros: Strong isolation, per-tenant backup/restore
- Cons: Schema migrations are painful at scale, connection pooling complexity

**Strategy 3: Database-per-Tenant**
- Best for: Enterprise-only products with <100 tenants
- Pros: Maximum isolation, per-tenant performance tuning
- Cons: Expensive, complex routing, hard to do cross-tenant analytics

### Role Hierarchy

Design your roles as a clear hierarchy from the start:

```typescript
// src/lib/auth/roles.ts
export const ROLES = {
  PLATFORM_ADMIN: 'platform_admin',  // You, the SaaS operator
  ORG_OWNER: 'org_owner',            // Customer who created the org
  ORG_ADMIN: 'org_admin',            // Customer's admin users
  ORG_MEMBER: 'org_member',          // Regular team members
  ORG_VIEWER: 'org_viewer',          // Read-only access
  PUBLIC: 'public',                  // Unauthenticated
} as const;

export type Role = typeof ROLES[keyof typeof ROLES];

// Permission check helper
export function hasPermission(userRole: Role, requiredRole: Role): boolean {
  const hierarchy: Role[] = [
    ROLES.PLATFORM_ADMIN,
    ROLES.ORG_OWNER,
    ROLES.ORG_ADMIN,
    ROLES.ORG_MEMBER,
    ROLES.ORG_VIEWER,
    ROLES.PUBLIC,
  ];
  return hierarchy.indexOf(userRole) <= hierarchy.indexOf(requiredRole);
}
```

### API Key Authentication (B2B Essential)

If you're building B2B SaaS, your customers will need API access:

```typescript
// src/lib/auth/api-keys.ts
interface ApiKey {
  id: string;
  org_id: string;
  key_hash: string;       // Never store plaintext
  prefix: string;         // e.g., "sk_live_abc..." for identification
  scopes: string[];       // ['read:documents', 'write:documents']
  rate_limit: number;     // Requests per minute
  expires_at: Date | null;
  created_by: string;     // User who created the key
}

// Middleware pattern
async function authenticateApiKey(req: Request): Promise<OrgContext> {
  const key = req.headers.get('Authorization')?.replace('Bearer ', '');
  if (!key) throw new AuthError('Missing API key');

  const prefix = key.substring(0, 12);
  const keyRecord = await db.apiKeys.findByPrefix(prefix);

  if (!keyRecord || !await verify(key, keyRecord.key_hash)) {
    throw new AuthError('Invalid API key');
  }

  if (keyRecord.expires_at && keyRecord.expires_at < new Date()) {
    throw new AuthError('Expired API key');
  }

  return { orgId: keyRecord.org_id, scopes: keyRecord.scopes };
}
```

---

## Quick Decision Guide

```
Start here:
  |
  v
Using Supabase for DB? ──Yes──> Supabase Auth (native RLS is too good to pass up)
  |
  No
  v
Need enterprise SSO now? ──Yes──> Auth0 (most mature enterprise features)
  |
  No
  v
Want fastest implementation? ──Yes──> Clerk (best DX, pre-built components)
  |
  No
  v
Already in Firebase/GCP? ──Yes──> Firebase Auth (ecosystem synergy)
  |
  No
  v
Need full control / regulatory? ──Yes──> Custom (lucia-auth or similar)
  |
  No
  v
Default recommendation ──> Supabase Auth (best balance of cost, features, flexibility)
```

---

## Our Decision

**Chosen**: [Auth provider]
**Date**: [Date]
**Decided by**: [Who]
**Rationale**: [Why this provider over the alternatives]
**Key factors**: [Top 3 factors that drove the decision]
**Migration plan if needed**: [How we'd move away if this doesn't work out]
**Review date**: [When to re-evaluate this decision]
