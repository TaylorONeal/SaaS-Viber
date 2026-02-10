# Backend / BaaS: Key Decisions

> **Prompt Guide**: Use this document to understand your backend options. Then use `docs/architecture/PromptGuide-Architecture.md` to generate your backend implementation plan.

## Why This Matters

Your backend choice determines your data model flexibility, scaling characteristics, operational overhead, and (most importantly) your ability to iterate fast. BaaS (Backend-as-a-Service) platforms let you ship in days what used to take months. But they come with tradeoffs in flexibility and portability. Understanding these tradeoffs upfront saves months of pain later.

---

## Decision Matrix

| Factor | Supabase | Firebase | AWS Amplify | PocketBase | Custom Server | Convex | Appwrite |
|--------|----------|----------|-------------|------------|---------------|--------|----------|
| Database type | PostgreSQL | Firestore (NoSQL) | DynamoDB (NoSQL) | SQLite | Your choice | Document-relational | MariaDB |
| Auth built-in | Yes | Yes | Yes (Cognito) | Yes | No (add lib) | Yes | Yes |
| Real-time | Yes (subscriptions) | Yes (listeners) | Yes (AppSync) | Yes (SSE) | DIY (WebSocket) | Yes (reactive) | Yes (WebSocket) |
| Edge functions | Yes (Deno) | Yes (Cloud Functions) | Yes (Lambda) | No | DIY | Cloud functions | Yes (serverless) |
| File storage | Yes | Yes | Yes (S3) | Yes | DIY (S3/R2) | Yes | Yes |
| Row-level security | Yes (native) | Security rules | IAM + VTL | No | Manual | Built-in | Permissions API |
| Self-host option | Yes (Docker) | No | No | Yes (single binary) | Yes | No | Yes (Docker) |
| Vendor lock-in | Low | High | High | None | None | Medium | Low |
| Free tier | Generous | Generous | Generous | Free (self-host) | N/A | Generous | Free (self-host) |
| Cost at scale | Low-Medium | Medium-High | Variable | Hosting costs | Hosting costs | Medium | Hosting costs |
| Learning curve | Low (SQL) | Medium (NoSQL) | High (AWS) | Very Low | Depends | Medium | Low |
| Community/ecosystem | Large, growing | Largest | Large | Small, growing | Massive | Growing | Growing |
| Offline support | Limited | Excellent | Good | Limited | DIY | Built-in | Limited |

---

## Option 1: Supabase

**What it is**: Open-source Firebase alternative built on PostgreSQL. Gives you a database, auth, edge functions, storage, and real-time subscriptions in one platform.

### When to Choose It
- You think in SQL and want relational data modeling
- Row-Level Security (RLS) for multi-tenant isolation is important
- You want an open-source stack you could self-host if needed
- Your team has PostgreSQL experience
- Budget-conscious but need a full-featured backend

### Tradeoffs
- **Pro**: PostgreSQL is incredibly powerful and well-understood
- **Pro**: RLS means your security policies live at the database layer
- **Pro**: Edge Functions (Deno-based) handle server-side logic
- **Pro**: Open source; can self-host with Docker if you outgrow the hosted version
- **Pro**: Direct database access means you can always use raw SQL
- **Con**: Real-time subscriptions are less mature than Firebase
- **Con**: Edge Functions have cold start latency
- **Con**: Offline-first patterns aren't built in (no client-side persistence like Firestore)
- **Con**: Schema migrations need careful management (use their CLI or Prisma/Drizzle)

### Cost Progression
| Tier | Price | Includes |
|------|-------|----------|
| Free | $0 | 500MB DB, 1GB storage, 50K MAU |
| Pro | $25/mo | 8GB DB, 100GB storage, 100K MAU |
| Team | $599/mo | Priority support, SOC2, SSO |
| Enterprise | Custom | Dedicated infrastructure |

---

## Option 2: Firebase

**What it is**: Google's BaaS platform. NoSQL (Firestore), auth, cloud functions, hosting, and the best offline sync in the business.

### When to Choose It
- Mobile-first product where offline sync is critical
- Your data model is document-oriented (nested, hierarchical)
- You want the most mature real-time sync engine
- Google Cloud is your infrastructure home
- Rapid prototyping where speed-to-market trumps everything

### Tradeoffs
- **Pro**: Firestore offline sync is best-in-class
- **Pro**: Real-time listeners are incredibly smooth
- **Pro**: Massive ecosystem, community, and documentation
- **Pro**: Free tier is generous (Spark plan)
- **Con**: NoSQL means no JOINs; denormalization is required
- **Con**: Complex queries are limited (no full-text search without extensions)
- **Con**: Vendor lock-in is the highest of any option here
- **Con**: Costs can spike unpredictably with read/write-heavy workloads
- **Con**: Security rules syntax has a learning curve

### Cost Warning
Firebase bills per read/write/delete operation. A poorly optimized app can generate surprise bills. Always set budget alerts. Example: a dashboard that re-fetches on every mount without caching can cost 10x what you expect.

---

## Option 3: AWS Amplify

**What it is**: AWS's developer experience layer on top of AppSync (GraphQL), DynamoDB, Cognito, S3, and Lambda.

### When to Choose It
- You're already invested in AWS infrastructure
- GraphQL API is preferred (AppSync is GraphQL-native)
- Enterprise compliance requirements (AWS certifications)
- Your team knows AWS services

### Tradeoffs
- **Pro**: Full power of AWS underneath
- **Pro**: GraphQL subscriptions for real-time
- **Pro**: Enterprise-grade security and compliance
- **Con**: Highest learning curve; AWS complexity leaks through
- **Con**: Amplify CLI generates a lot of CloudFormation you can't easily modify
- **Con**: Debugging requires understanding multiple AWS services
- **Con**: Vendor lock-in to AWS-specific patterns (VTL resolvers, etc.)

---

## Option 4: PocketBase

**What it is**: A single-binary backend (Go) with SQLite, auth, real-time, file storage, and an admin UI. Self-host anywhere.

### When to Choose It
- Side project or internal tool where simplicity is king
- You want zero cloud dependencies
- Single-server deployment is acceptable
- Budget is literally $0 (runs on a $5/mo VPS)

### Tradeoffs
- **Pro**: One binary, one file (SQLite), dead simple
- **Pro**: Admin UI built in
- **Pro**: Zero vendor lock-in
- **Pro**: Incredibly fast for single-server workloads
- **Con**: SQLite doesn't scale horizontally (single writer)
- **Con**: No edge functions or serverless compute
- **Con**: Smaller ecosystem and community
- **Con**: Not suitable for high-traffic production (thousands of concurrent writes)

---

## Option 5: Custom Server

**What it is**: Build it yourself. Express, Fastify, Hono, or NestJS on Node.js. Django or FastAPI on Python. Go, Rust, whatever you want.

### When to Choose It
- Complex business logic that doesn't fit BaaS patterns
- You need full control over data layer and API design
- Team has strong backend engineering experience
- Performance requirements exceed BaaS capabilities
- Regulatory requirements demand full infrastructure control

### Tradeoffs
- **Pro**: Total control over architecture, performance, and data
- **Pro**: No vendor lock-in whatsoever
- **Pro**: Can optimize for your specific workload
- **Con**: You build and maintain everything (auth, storage, real-time, etc.)
- **Con**: Slower time to market
- **Con**: Operational burden (deployment, monitoring, scaling, security)

### Recommended Stack (if going custom)
```
API Framework:  Hono (lightweight, edge-ready) or Fastify (Node.js, fast)
Database:       PostgreSQL + Drizzle ORM (type-safe, lightweight)
Auth:           Lucia Auth or better-auth
Cache:          Redis or Upstash (serverless Redis)
Storage:        S3-compatible (AWS S3, Cloudflare R2, MinIO)
Real-time:      WebSocket (ws) or Server-Sent Events
Deployment:     Docker on Railway/Render/Fly.io
```

---

## Option 6: Convex

**What it is**: A reactive backend platform where your database queries automatically update the UI when data changes. TypeScript-native.

### When to Choose It
- Real-time collaborative features are central to your product
- You want end-to-end TypeScript with full type safety
- Reactive data (UI auto-updates when data changes) is a core requirement
- You're building something like Notion, Figma, or a multiplayer tool

### Tradeoffs
- **Pro**: Reactive queries are magical; UI always reflects latest state
- **Pro**: Full TypeScript stack with excellent DX
- **Pro**: Built-in scheduling, cron jobs, file storage
- **Con**: Newer platform; smaller community
- **Con**: Proprietary; no self-host option
- **Con**: Different mental model; queries and mutations are server functions

---

## Option 7: Appwrite

**What it is**: Open-source BaaS with auth, database (MariaDB), storage, functions, and messaging. Self-hostable.

### When to Choose It
- You want an open-source BaaS alternative to Firebase
- Self-hosting is important to you
- You prefer REST APIs over Firebase's SDK approach
- Your team wants more control than Supabase but less work than custom

### Tradeoffs
- **Pro**: Open source, self-hostable via Docker
- **Pro**: Clean REST API and SDKs for many languages
- **Pro**: Built-in messaging (email, SMS, push)
- **Con**: MariaDB backend is less powerful than PostgreSQL
- **Con**: Smaller community than Supabase or Firebase
- **Con**: Cloud offering is less mature

---

## The Backend Abstraction Pattern

Regardless of which backend you choose, wrapping it behind an interface is one of the highest-value architectural decisions you can make. This pattern allows you to:

1. **Swap backends** without rewriting your app
2. **Test with mocks** without hitting real services
3. **Migrate incrementally** (use two backends during transition)
4. **Keep UI code clean** (components never know about Supabase, Firebase, etc.)

### The Interface

```typescript
// src/lib/backend/types.ts

export interface BackendProvider {
  auth: AuthProvider;
  db: DatabaseProvider;
  storage: StorageProvider;
  realtime: RealtimeProvider;
}

export interface AuthProvider {
  signIn(email: string, password: string): Promise<AuthResult>;
  signUp(email: string, password: string, metadata?: Record<string, unknown>): Promise<AuthResult>;
  signOut(): Promise<void>;
  signInWithOAuth(provider: OAuthProvider): Promise<void>;
  getSession(): Promise<Session | null>;
  onAuthStateChange(callback: (event: AuthEvent, session: Session | null) => void): Unsubscribe;
  resetPassword(email: string): Promise<void>;
  updateUser(attributes: Partial<UserAttributes>): Promise<User>;
}

export interface DatabaseProvider {
  from<T>(table: string): QueryBuilder<T>;
  rpc<T>(functionName: string, params?: Record<string, unknown>): Promise<T>;
}

export interface QueryBuilder<T> {
  select(columns?: string): QueryBuilder<T>;
  insert(data: Partial<T> | Partial<T>[]): QueryBuilder<T>;
  update(data: Partial<T>): QueryBuilder<T>;
  delete(): QueryBuilder<T>;
  eq(column: string, value: unknown): QueryBuilder<T>;
  neq(column: string, value: unknown): QueryBuilder<T>;
  in(column: string, values: unknown[]): QueryBuilder<T>;
  order(column: string, options?: { ascending?: boolean }): QueryBuilder<T>;
  limit(count: number): QueryBuilder<T>;
  single(): Promise<{ data: T | null; error: Error | null }>;
  execute(): Promise<{ data: T[]; error: Error | null }>;
}

export interface StorageProvider {
  upload(bucket: string, path: string, file: File): Promise<StorageResult>;
  download(bucket: string, path: string): Promise<Blob>;
  getPublicUrl(bucket: string, path: string): string;
  remove(bucket: string, paths: string[]): Promise<void>;
  list(bucket: string, path?: string): Promise<StorageObject[]>;
}

export interface RealtimeProvider {
  subscribe<T>(
    table: string,
    filter: RealtimeFilter,
    callback: (payload: RealtimePayload<T>) => void
  ): Unsubscribe;
}

type Unsubscribe = () => void;
```

### Supabase Implementation

```typescript
// src/lib/backend/supabase-provider.ts
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import type { BackendProvider, AuthProvider, DatabaseProvider } from './types';

export function createSupabaseProvider(url: string, anonKey: string): BackendProvider {
  const client = createClient(url, anonKey);

  return {
    auth: createSupabaseAuth(client),
    db: createSupabaseDB(client),
    storage: createSupabaseStorage(client),
    realtime: createSupabaseRealtime(client),
  };
}
```

### Using the Abstraction in Your App

```typescript
// src/lib/backend/index.ts
import { createSupabaseProvider } from './supabase-provider';
// import { createFirebaseProvider } from './firebase-provider';  // swap later

export const backend = createSupabaseProvider(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
);

// In your components -- no Supabase imports, just the interface
// src/features/documents/api.ts
import { backend } from '@/lib/backend';

export async function getDocuments(orgId: string) {
  const { data, error } = await backend.db
    .from('documents')
    .select('*')
    .eq('org_id', orgId)
    .order('created_at', { ascending: false })
    .execute();

  if (error) throw error;
  return data;
}
```

### Why This Matters

This isn't over-engineering. It's the difference between "we need to rewrite everything to switch backends" and "we need to write one new adapter file." Teams that skip this abstraction and import Supabase/Firebase directly in 200 files learn this lesson the hard way.

---

## Quick Decision Guide

```
Start here:
  |
  v
Do you need offline-first sync? ──Yes──> Firebase or Convex
  |
  No
  v
Do you prefer SQL? ──Yes──> Supabase or Custom (PostgreSQL)
  |
  No (or no preference)
  v
Real-time collaboration is core? ──Yes──> Convex or Supabase
  |
  No
  v
Need to self-host? ──Yes──> PocketBase (simple) or Appwrite (full BaaS) or Supabase (Docker)
  |
  No
  v
Already on AWS? ──Yes──> Amplify (if you can handle the complexity)
  |
  No
  v
Want fastest time-to-market with SQL? ──> Supabase (default recommendation)
```

---

## Cost Comparison at Scale

| Monthly active users | Supabase | Firebase | Convex | Custom (Railway) |
|---------------------|----------|----------|--------|-----------------|
| 1K users, 100K reads/day | Free | Free | Free | ~$10/mo |
| 10K users, 1M reads/day | $25/mo | ~$50-100/mo | ~$25/mo | ~$30-50/mo |
| 100K users, 10M reads/day | $25-100/mo | ~$500-2,000/mo | ~$100/mo | ~$100-300/mo |
| 1M users, 100M reads/day | Enterprise | $5,000+/mo | Enterprise | ~$500-2,000/mo |

*Firebase costs vary wildly based on read/write patterns. These are estimates.*

---

## Our Decision

**Chosen**: [Backend/BaaS provider]
**Date**: [Date]
**Decided by**: [Who]
**Rationale**: [Why this over alternatives]
**Abstraction layer**: [Yes/No -- using the backend provider interface?]
**Migration plan if needed**: [How we'd switch providers]
**Cost ceiling**: [At what monthly cost do we re-evaluate?]
**Review date**: [When to reassess]
