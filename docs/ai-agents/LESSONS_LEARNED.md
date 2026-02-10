# Lessons Learned

> Hard-won knowledge from building SaaS applications. Each entry is a real
> pitfall with a concrete solution. Add your own as you encounter them.

---

## TypeScript Pitfalls

### 1. Strict Mode Is Non-Negotiable

Always enable `"strict": true` in `tsconfig.json`. Relaxing it to fix errors
creates a cascade of runtime bugs, especially around `null` and `undefined`.
If you inherit a non-strict codebase, migrate incrementally using
`// @ts-expect-error` annotations with ticket references.

### 2. Use `interface` for Object Shapes, `type` for Unions and Utilities

```typescript
// Prefer interface for extendable shapes
interface User {
  id: string;
  email: string;
}

// Prefer type for unions, intersections, mapped types
type Status = 'active' | 'paused' | 'cancelled';
type WithTimestamps<T> = T & { createdAt: Date; updatedAt: Date };
```

Interfaces give better error messages and support declaration merging.
Types are necessary for unions and conditional types.

### 3. Avoid `any` -- Use `unknown` and Narrow

```typescript
// Bad: silently breaks type safety downstream
function parse(data: any) { return data.name; }

// Good: forces you to validate
function parse(data: unknown) {
  if (typeof data === 'object' && data !== null && 'name' in data) {
    return (data as { name: string }).name;
  }
  throw new Error('Invalid data shape');
}
```

### 4. Generic Constraints Prevent Runtime Errors

```typescript
// Bad: T could be anything
function getId<T>(obj: T) { return obj.id; } // Error

// Good: constrain T to objects with an id
function getId<T extends { id: string }>(obj: T) { return obj.id; }
```

---

## Database Pitfalls

### 5. N+1 Queries Hide in Loops

Every time you fetch related data inside a `.map()` or `forEach()`, you create
an N+1 query. Use joins, batch fetches, or `IN` clauses instead.

```typescript
// Bad: 1 query per user
const posts = await getRecentPosts();
for (const post of posts) {
  post.author = await getUser(post.authorId); // N+1
}

// Good: single batch query
const authorIds = [...new Set(posts.map(p => p.authorId))];
const authors = await getUsersByIds(authorIds);
const authorMap = new Map(authors.map(a => [a.id, a]));
posts.forEach(p => { p.author = authorMap.get(p.authorId); });
```

### 6. Missing Indexes on Foreign Keys and Filtered Columns

Every `WHERE` clause column and every foreign key should have an index.
Use `EXPLAIN ANALYZE` to verify. Composite indexes must match your query
column order (leftmost prefix rule).

### 7. Row Level Security (RLS) Default-Deny

Always start with RLS enabled and no policies (default deny). Add policies
one at a time and test each. A common mistake is forgetting that `service_role`
bypasses RLS but `anon` and `authenticated` do not.

```sql
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Users can only read their own documents
CREATE POLICY "users_read_own" ON documents
  FOR SELECT USING (auth.uid() = user_id);
```

### 8. Always Store Timestamps in UTC

Store `timestamptz` (with timezone), not `timestamp`. Convert to local time
only at display time in the frontend. Server-side code should never assume
a timezone. Use `date-fns-tz` or `luxon` for timezone conversions.

### 9. Use Database Transactions for Multi-Step Operations

When creating a subscription involves inserting into `subscriptions`,
updating `users`, and creating an `audit_log` entry, wrap them in a
transaction. Partial writes cause data inconsistencies that are painful to debug.

---

## Auth Pitfalls

### 10. Token Refresh Race Conditions

When multiple tabs or API calls detect an expired token simultaneously,
they all try to refresh at once. Implement a token refresh mutex:

```typescript
let refreshPromise: Promise<Session> | null = null;

async function getValidSession() {
  if (refreshPromise) return refreshPromise;
  if (isTokenExpired(session)) {
    refreshPromise = refreshSession().finally(() => {
      refreshPromise = null;
    });
    return refreshPromise;
  }
  return session;
}
```

### 11. Redirect Loop Prevention

After login, redirect to the originally requested page, not always to `/dashboard`.
Store the intended destination before redirecting to login. Add a maximum
redirect counter or check to prevent infinite loops between auth pages.

### 12. Session Management Across Tabs

Use `BroadcastChannel` or `storage` events to sync auth state across tabs.
When a user logs out in one tab, all tabs should reflect that immediately.

---

## Payment Pitfalls

### 13. Webhook Idempotency Is Mandatory

Stripe sends webhooks at least once, sometimes multiple times. Always check
if you have already processed an event before acting on it.

```typescript
async function handleWebhook(event: Stripe.Event) {
  const existing = await db.webhookEvents.findUnique({
    where: { stripeEventId: event.id }
  });
  if (existing) return; // Already processed

  await db.$transaction([
    db.webhookEvents.create({ data: { stripeEventId: event.id } }),
    processEvent(event),
  ]);
}
```

### 14. Race Condition Between Checkout and Webhook

The webhook for `checkout.session.completed` may arrive before your
checkout success page loads. Design your success page to poll or use
real-time subscriptions to wait for the webhook to be processed, rather
than assuming it has already happened.

### 15. Currency Amounts Are Integers

Stripe uses the smallest currency unit (cents for USD). `$10.00` is `1000`.
Never store or compute with floats for money. Use integer cents everywhere
and format only for display.

### 16. Always Handle Subscription Status Transitions

Do not just check `active` vs `cancelled`. Handle all states:
`trialing`, `active`, `past_due`, `paused`, `cancelled`, `unpaid`, `incomplete`.
Each requires different UI and access logic.

---

## Frontend Pitfalls

### 17. Prevent Unnecessary Re-Renders

Components re-render when any parent state changes. Use `React.memo` for
expensive pure components, `useMemo` for expensive calculations, and
`useCallback` for functions passed as props. But profile first -- premature
optimization wastes time.

### 18. State Management: Start Simple

Start with React state and context. Move to Zustand or similar only when
you have genuinely shared state across distant components. Most "state
management problems" are actually prop drilling that can be solved with
component composition.

### 19. Bundle Size Creep

Import only what you need. `import { format } from 'date-fns'` is tree-shakeable;
`import moment from 'moment'` is not. Run `npx next build` and review the
bundle analysis regularly. Lazy-load routes and heavy components.

### 20. Form State Is UI State, Not Server State

Do not sync form inputs with your global store or server cache. Use a form
library (React Hook Form) for form state, and only sync to the server on submit.
Controlled inputs re-render on every keystroke if managed incorrectly.

---

## Deployment Pitfalls

### 21. Environment Variable Checklist

- Verify all required env vars are set in every environment (dev, staging, prod)
- Use `.env.example` as the source of truth for required variables
- Never commit `.env` files -- use secrets management in CI/CD
- Prefix client-side vars with `NEXT_PUBLIC_` (Next.js) so they are bundled

### 22. CORS Misconfiguration

If your API and frontend are on different domains, configure CORS explicitly.
Common mistake: allowing `*` in development leaks into production. Set
specific origins per environment.

### 23. Build Caching Can Serve Stale Code

When using CDNs or build caches, ensure cache-busting is in place.
Static assets should have hashed filenames. API responses should use
proper `Cache-Control` headers. After deploying, verify the new version
is actually being served.

### 24. Database Connection Pooling

Serverless functions open a new database connection per invocation. Use a
connection pooler (PgBouncer, Supabase's built-in pooler) to prevent
exhausting your database connection limit. Set pool mode to `transaction`
for serverless workloads.

---

## Adding New Lessons

When you encounter a new pitfall, add it here with:

1. **A clear title** describing the problem
2. **Why it happens** (root cause)
3. **Code example** showing the wrong and right approach
4. **Category** matching one of the sections above (or create a new one)
