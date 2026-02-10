# Hosting & Deployment: Key Decisions

> **Prompt Guide**: Use this document to understand your hosting options. Then use `docs/architecture/PromptGuide-Architecture.md` to generate your deployment plan.

## Why This Matters

Deployment affects your iteration speed, costs, reliability, and developer experience. The right choice depends on your architecture (SPA, SSR, containers), traffic patterns, and team size. The wrong choice means you're either overpaying for infrastructure you don't need or fighting your hosting platform instead of building features.

---

## Deployment Categories

Before comparing platforms, understand what you're deploying:

| What you're deploying | Category | Examples |
|----------------------|----------|---------|
| React/Vue SPA (client-side only) | Static hosting | Vercel, Netlify, Cloudflare Pages, S3+CloudFront |
| Next.js/Remix/SvelteKit | Edge/Serverless | Vercel, Netlify, Cloudflare |
| Express/Fastify/Hono API | Container or serverless | Railway, Render, Fly.io, AWS Lambda |
| PostgreSQL/Redis | Managed database | Supabase, Neon, PlanetScale, Railway |
| Background workers | Container | Railway, Render, Fly.io |
| Full-stack monolith | Container | Railway, Render, Fly.io, VPS |

---

## Decision Matrix: Frontend Hosting

| Factor | Vercel | Netlify | Cloudflare Pages | AWS S3+CF | Self-hosted (Caddy) |
|--------|--------|---------|-------------------|-----------|-------------------|
| Static SPA hosting | Excellent | Excellent | Excellent | Excellent | Good |
| SSR support | Excellent | Good | Good | Manual | Manual |
| Edge functions | Yes | Yes | Yes (Workers) | Lambda@Edge | No |
| Build time (free) | 6000 min/mo | 300 min/mo | 500 builds/mo | N/A | N/A |
| Bandwidth (free) | 100 GB | 100 GB | Unlimited | Pay per use | Your server |
| Custom domains | Free | Free | Free | Free | Free |
| SSL | Automatic | Automatic | Automatic | ACM (free) | Automatic (Caddy) |
| Preview deploys | Yes (per PR) | Yes (per PR) | Yes (per PR) | DIY | DIY |
| Analytics | Built-in | Built-in | Built-in | CloudWatch | DIY |
| Cost at hobby scale | Free | Free | Free | ~$1-5/mo | $5-10/mo VPS |
| Cost at production | $20/mo+ | $19/mo+ | $0 (generous free) | $10-50/mo | $10-40/mo |
| Vendor lock-in | Low-Medium | Low | Low-Medium | Low | None |
| Team features | Pro plan | Pro plan | Free | IAM | DIY |

---

## Decision Matrix: Backend/API Hosting

| Factor | Railway | Render | Fly.io | AWS (ECS/Lambda) | VPS (Hetzner/DO) |
|--------|---------|--------|--------|-------------------|-------------------|
| Container support | Yes | Yes | Yes | Yes | Yes (Docker) |
| Serverless functions | No | No | Machines API | Lambda | No |
| Auto-scaling | Yes | Yes | Yes | Yes | Manual |
| Built-in PostgreSQL | Yes | Yes | Yes (Fly Postgres) | RDS | DIY |
| Built-in Redis | Yes | Yes | Yes (Upstash) | ElastiCache | DIY |
| Deploy from Git | Yes | Yes | Yes | CodePipeline | DIY (CI/CD) |
| Dockerfile support | Yes | Yes | Yes | Yes | Yes |
| Private networking | Yes | Yes | Yes | VPC | Yes |
| Regions | US/EU | US/EU/Asia | 30+ regions | All AWS regions | Provider-specific |
| Free tier | $5 credit/mo | 750 hrs/mo | $0 (machines) | Lambda free tier | No |
| Cost at production | $5-50/mo | $7-50/mo | $5-50/mo | Variable | $5-40/mo |
| DX / simplicity | Excellent | Excellent | Good | Complex | Manual |
| Production readiness | Good | Good | Good | Excellent | Depends on you |

---

## Option 1: Vercel -- Best for Next.js/SSR

### When to Choose It
- You're using Next.js (they make it, so support is best-in-class)
- You want zero-config deployments with preview deploys per PR
- Edge functions and serverless are part of your architecture
- Your team values developer experience above all

### Tradeoffs
- **Pro**: Best-in-class Next.js support
- **Pro**: Preview deployments on every pull request
- **Pro**: Edge functions in 30+ regions
- **Pro**: Automatic image optimization, ISR, streaming SSR
- **Con**: Pro plan ($20/mo per member) adds up for teams
- **Con**: Server-side compute costs can surprise you
- **Con**: Some vendor-specific APIs (middleware, edge config)
- **Con**: Not ideal for long-running processes

### Best For
SPA or SSR frontend deployments. Pair with a separate backend host (Railway, Supabase) for API and database.

---

## Option 2: Cloudflare Pages -- Best Value

### When to Choose It
- You want the most generous free tier (unlimited bandwidth)
- Performance at the edge matters (global CDN is Cloudflare's core business)
- You want to use Workers for serverless compute
- Budget is a primary concern

### Tradeoffs
- **Pro**: Unlimited bandwidth on free tier (yes, really)
- **Pro**: Cloudflare's global network is massive and fast
- **Pro**: Workers KV and D1 (SQLite at the edge) for data at the edge
- **Pro**: Pages + Workers integration for full-stack at the edge
- **Con**: Build system is less polished than Vercel
- **Con**: Workers have different runtime constraints than Node.js
- **Con**: Debugging edge functions can be tricky

---

## Option 3: Netlify -- Great All-Rounder

### When to Choose It
- You want a polished platform with good defaults
- Static SPA or Jamstack architecture
- You value built-in form handling and identity features
- Your project fits within the free tier comfortably

### Tradeoffs
- **Pro**: Excellent developer experience
- **Pro**: Built-in forms, identity, and analytics
- **Pro**: Netlify Functions (AWS Lambda under the hood)
- **Con**: Build minutes are limited on free tier (300/mo)
- **Con**: SSR support is good but not as deep as Vercel
- **Con**: Pro plan required for team collaboration features

---

## Option 4: Railway -- Best for Backend Services

### When to Choose It
- You need to deploy backend services, databases, and workers
- You want Heroku-like simplicity with modern infrastructure
- Docker-based deployment is preferred
- You want managed PostgreSQL and Redis alongside your app

### Tradeoffs
- **Pro**: Deploy anything with a Dockerfile (or auto-detected buildpacks)
- **Pro**: Built-in PostgreSQL, MySQL, Redis, MongoDB
- **Pro**: Private networking between services
- **Pro**: Sleep/wake for hobby projects (saves money)
- **Con**: $5/mo credit on free tier goes fast
- **Con**: Limited regions (US, EU)
- **Con**: No auto-scaling to zero

### Deployment Pattern
```yaml
# railway.toml
[build]
  builder = "dockerfile"
  dockerfilePath = "Dockerfile"

[deploy]
  startCommand = "node dist/server.js"
  healthcheckPath = "/health"
  restartPolicyType = "on_failure"
  restartPolicyMaxRetries = 3
```

---

## Option 5: Render -- Solid Alternative to Railway

### When to Choose It
- Similar use case to Railway; evaluate both
- You want a managed PostgreSQL with automatic daily backups
- Free tier includes 750 hours/month of compute
- You prefer web services over containers

### Tradeoffs
- **Pro**: Free SSL, global CDN, DDoS protection
- **Pro**: Background workers as a first-class concept
- **Pro**: Managed PostgreSQL with daily backups included
- **Con**: Spin-down on free tier causes cold starts (30+ seconds)
- **Con**: Limited to US regions on free tier

---

## Option 6: Fly.io -- Best for Global Distribution

### When to Choose It
- You need your backend close to users globally (30+ regions)
- You're running containers and want Heroku-like DX
- You need persistent volumes (for SQLite, uploads, etc.)
- You want to deploy Fly Postgres with read replicas near users

### Tradeoffs
- **Pro**: Deploy to 30+ regions worldwide
- **Pro**: Machines API for fine-grained compute control
- **Pro**: Persistent volumes (unlike most serverless)
- **Pro**: Fly Postgres with read replicas
- **Con**: Steeper learning curve than Railway/Render
- **Con**: Pricing can be confusing (machines, volumes, bandwidth)
- **Con**: Fly Postgres requires more management than managed DBs

---

## Option 7: AWS S3 + CloudFront -- Most Scalable Static Hosting

### When to Choose It
- You're already in the AWS ecosystem
- You need maximum control over CDN behavior
- High traffic where Vercel/Netlify costs would be prohibitive
- You want to avoid platform-specific vendor lock-in

### Tradeoffs
- **Pro**: Nearly infinite scale
- **Pro**: Fine-grained control over caching, routing, headers
- **Pro**: Lambda@Edge for server-side logic at CDN nodes
- **Con**: Requires manual setup (S3 bucket, CloudFront distribution, Route 53)
- **Con**: No preview deploys without additional tooling
- **Con**: AWS console UX is painful

### Cost Example (SPA Hosting)
```
S3 storage: ~$0.023/GB/month (a few cents for a typical SPA)
CloudFront: $0.085/GB for first 10TB
Route 53:   $0.50/hosted zone
Total for a typical SaaS SPA: $1-5/month at moderate traffic
```

---

## Option 8: Self-Hosted (Caddy/Nginx on VPS)

### When to Choose It
- You want complete control and maximum cost efficiency
- Regulatory requirements demand specific infrastructure
- You're comfortable managing Linux servers
- Single-region deployment is acceptable

### Tradeoffs
- **Pro**: Full control over everything
- **Pro**: Fixed, predictable costs ($5-40/mo for a capable VPS)
- **Pro**: No vendor lock-in whatsoever
- **Con**: You manage SSL, security patches, monitoring, backups
- **Con**: No auto-scaling without additional infrastructure
- **Con**: No preview deploys without significant CI/CD investment

### Recommended VPS Providers
| Provider | Cheapest VPS | Location | Notes |
|----------|-------------|----------|-------|
| Hetzner | $4/mo | EU/US | Best price-to-performance |
| DigitalOcean | $6/mo | Global | Good DX, App Platform available |
| Linode (Akamai) | $5/mo | Global | Solid networking |
| Vultr | $6/mo | Global | Many locations |

---

## Database Hosting

Your database host is separate from (but related to) your app hosting.

| Option | Type | Free tier | Production cost | Managed backups | Branching |
|--------|------|-----------|-----------------|-----------------|-----------|
| Supabase | PostgreSQL | 500MB | $25/mo (8GB) | Yes | No |
| Neon | PostgreSQL | 512MB | $19/mo+ | Yes | Yes (branching!) |
| PlanetScale | MySQL (Vitess) | 5GB | $39/mo | Yes | Yes |
| Railway PostgreSQL | PostgreSQL | $5 credit | $5-20/mo | Manual | No |
| Render PostgreSQL | PostgreSQL | 1GB (90 days) | $7/mo | Daily | No |
| AWS RDS | Any | 12 months | $15-50/mo+ | Yes | No |
| Turso | SQLite (libSQL) | 9GB | $29/mo | Yes | Yes |

**Recommendation for most SaaS**: Start with Supabase (bundled with auth, storage, etc.) or Neon (if you want database branching for development).

---

## CDN Strategy

For SPA deployments, your CDN strategy is simple: deploy static files to CDN, everything is cached.

For dynamic content:
```
Static assets (JS, CSS, images)  ──>  CDN cache (max-age: 1 year, immutable)
HTML (index.html)                ──>  CDN cache (max-age: 0, must-revalidate)
API responses                    ──>  Usually no CDN (or short cache with stale-while-revalidate)
```

### Cache Headers for SPA
```
# Vite builds have content hashes in filenames, so cache forever
/assets/*           Cache-Control: public, max-age=31536000, immutable
/index.html         Cache-Control: no-cache, must-revalidate
/manifest.json      Cache-Control: no-cache, must-revalidate
/sw.js              Cache-Control: no-cache, must-revalidate
```

---

## CI/CD Pipelines

### GitHub Actions (Recommended for Most Teams)

```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20 }
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck
      - run: npm test

  deploy-preview:
    if: github.event_name == 'pull_request'
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci && npm run build
      # Deploy to preview URL (platform-specific)

  deploy-production:
    if: github.ref == 'refs/heads/main'
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci && npm run build
      # Deploy to production (platform-specific)
```

### Platform-Native CI/CD
Most platforms (Vercel, Netlify, Railway, Render) have built-in CI/CD that deploys on git push. For simple setups, this is all you need. Add GitHub Actions when you need:
- Custom test suites
- Multiple deployment targets
- Conditional deploys (only deploy when certain paths change)
- Monorepo support

---

## Monorepo vs Separate Deploys

### Monorepo (Recommended for Small Teams)
```
/
  apps/
    web/          # SPA frontend → Vercel/Cloudflare
    api/          # Backend → Railway/Render
    marketing/    # Marketing site → Vercel/Cloudflare
  packages/
    shared/       # Shared types, utils
    ui/           # Shared UI components
```
- **Tools**: Turborepo, Nx, or pnpm workspaces
- **Pro**: Shared code, atomic changes, single repo to manage
- **Con**: CI complexity, deploy orchestration

### Separate Repos
```
your-saas-web/        # Frontend → Vercel
your-saas-api/        # Backend → Railway
your-saas-marketing/  # Marketing → Cloudflare
```
- **Pro**: Simple CI, independent deploy cycles
- **Con**: Shared code is harder (publish packages or copy)

**Recommendation**: Start monorepo with Turborepo. Split repos only if team size or deploy coupling becomes a problem.

---

## Cost Comparison by Stage

### Stage 1: Pre-Launch / MVP ($0-10/mo)
```
Frontend:  Vercel Free or Cloudflare Pages Free
Backend:   Supabase Free tier (includes DB, auth, storage)
Domain:    ~$12/year
Email:     Resend free tier (100/day)
Total:     $0-10/month
```

### Stage 2: Launched, Growing (100-1K users) ($25-75/mo)
```
Frontend:  Vercel Pro ($20/mo) or Cloudflare Pages (free)
Backend:   Supabase Pro ($25/mo)
Monitoring: Sentry free tier
Email:     Resend ($20/mo)
Total:     $25-75/month
```

### Stage 3: Scaling (1K-10K users) ($100-500/mo)
```
Frontend:  Vercel Pro ($20/mo) or dedicated CDN
Backend:   Supabase Pro ($25/mo) + Railway for workers ($20-50/mo)
Cache:     Upstash Redis ($10-30/mo)
Monitoring: Sentry Team ($26/mo)
Email:     Resend or SendGrid ($30-50/mo)
Total:     $100-500/month
```

### Stage 4: Scale (10K+ users) ($500-5,000/mo)
```
Frontend:  Vercel Team or AWS CloudFront
Backend:   Supabase Team or custom infrastructure
Workers:   Railway/Fly.io ($100-500/mo)
Cache:     Redis cluster ($50-200/mo)
Monitoring: Datadog or equivalent ($100-500/mo)
Total:     $500-5,000/month depending on traffic and data
```

---

## Quick Decision Guide

```
SPA frontend only? ──> Cloudflare Pages (free, fast) or Vercel (best DX)

SSR frontend? ──> Vercel (if Next.js) or Cloudflare (if Workers-compatible)

Backend API? ──> Railway (simplest) or Render (good free tier)

Need global distribution? ──> Fly.io (backend) + Cloudflare (frontend)

Budget is $0? ──> Cloudflare Pages + Supabase free + GitHub Actions

Want maximum control? ──> Hetzner VPS + Caddy + Docker Compose
```

---

## Our Decision

**Frontend hosting**: [Platform]
**Backend hosting**: [Platform]
**Database hosting**: [Platform]
**CDN**: [Built-in / CloudFront / Cloudflare]
**CI/CD**: [GitHub Actions / Platform-native / Both]
**Repo structure**: [Monorepo / Separate repos]
**Date**: [Date]
**Decided by**: [Who]
**Rationale**: [Why this combination]
**Monthly budget ceiling**: [$X -- re-evaluate if exceeded]
**Scaling plan**: [What changes at 10x traffic]
**Review date**: [When to reassess]
