# Setup Guide

> From clone to launch -- the complete walkthrough for building your SaaS with SaaS-Viber.

This guide walks you through every phase of turning this template into a production SaaS application. Each phase references specific files, decision frameworks, and prompt guides throughout the repository.

---

## How to Use This Guide

**Read linearly the first time.** Each phase builds on the previous one. After that, use it as a reference -- jump to whatever phase you're in.

**Follow the prompt guides.** Throughout this guide, you'll see references like:

> Use `prompts/PromptGuide-Architecture.md`

These are structured prompts designed for AI coding assistants (Claude Code, Cursor, GitHub Copilot, etc.). The pattern is:

1. Open the referenced prompt guide
2. Fill in the variables with your project's specifics
3. Feed the completed prompt to your AI assistant
4. Review and iterate on the output

This is the core SaaS-Viber workflow: **decisions guide prompts, prompts guide code, code ships product.**

---

## How to Use Prompt Guides

Prompt guides are the bridge between your decisions and your code. Each guide follows a consistent structure:

```
1. CONTEXT       -- What you're building and why
2. INPUTS        -- What the AI needs to know (your decisions, constraints)
3. PROMPT        -- The actual prompt template with [PLACEHOLDERS]
4. EXPECTED      -- What good output looks like
5. ITERATION     -- How to refine the output
```

**Best practices:**

- Fill in every placeholder before sending the prompt
- Include relevant decision documents as context (paste them in or reference them)
- Don't accept the first output -- iterate at least once
- Save good outputs to the appropriate `docs/` location
- Version your prompts alongside your code

---

## Phase 1: Foundation

**Goal:** Make the key decisions that shape everything else, and get your environment configured.

### 1.1 Clone and Orient

```bash
git clone https://github.com/[YOUR_GITHUB_USER]/[YOUR_REPO_NAME].git
cd [YOUR_REPO_NAME]
```

Read through the directory structure to understand what's here:

```bash
ls -la
cat README.md
```

### 1.2 Make Key Decisions

These four decisions affect nearly every other file in the project. Don't rush them, but don't overthink them either -- SaaS-Viber is designed so you can change your mind later.

| Decision | File | What to Decide |
|----------|------|---------------|
| **Backend** | `decisions/BACKEND_CHOICES.md` | Supabase, Firebase, or custom backend? |
| **Auth** | `decisions/AUTH_CHOICES.md` | Supabase Auth, Auth0, Clerk, or roll your own? |
| **Payments** | `decisions/PAYMENT_CHOICES.md` | Stripe, Lemon Squeezy, Paddle, or none yet? |
| **Platform** | `decisions/PLATFORM_CHOICES.md` | Vercel, Netlify, Railway, or self-hosted? |

> Use `prompts/PromptGuide-Decisions.md` to evaluate trade-offs with your AI assistant.

### 1.3 Configure Environment

```bash
cp .env.example .env
```

Open `.env` and fill in the values based on your decisions from 1.2. The file is heavily commented -- each section maps to a decision.

### 1.4 Install Dependencies

```bash
npm install
```

> See `DEPENDENCIES.md` for guidance on which packages to add based on your decisions.

### 1.5 Verify It Runs

```bash
npm run dev
```

You should see a running application at `http://localhost:8080`. In demo mode, everything works with mock data.

---

## Phase 2: Identity

**Goal:** Make it yours. Branding, design tokens, and assets.

### 2.1 Branding Basics

Define your core brand elements:

- **Product name**: Update `VITE_APP_NAME` in `.env`
- **Tagline**: Update the README and `index.html` meta description
- **Colors**: Update design tokens in `tailwind.config.ts`
- **Typography**: Choose fonts and update `index.html` / Tailwind config

> Use `prompts/PromptGuide-Branding.md` to generate a cohesive brand identity with AI assistance.

### 2.2 Design Tokens

Edit `tailwind.config.ts` to set your design system:

```typescript
// tailwind.config.ts -- theme.extend section
colors: {
  primary: { /* your primary palette */ },
  accent: { /* your accent palette */ },
},
fontFamily: {
  sans: ['[Your Font]', 'system-ui', 'sans-serif'],
},
```

> Reference `docs/design-tokens.md` for the full token specification template.

### 2.3 Assets

Replace the placeholder assets:

| Asset | Location | Size/Format |
|-------|----------|------------|
| Favicon | `public/favicon.ico` | 32x32, ICO |
| App Icon (192) | `public/icons/icon-192.png` | 192x192, PNG |
| App Icon (512) | `public/icons/icon-512.png` | 512x512, PNG |
| OG Image | `public/og-image.png` | 1200x630, PNG/JPG |
| Apple Touch Icon | `public/apple-touch-icon.png` | 180x180, PNG |

### 2.4 Web Manifest

Update `public/manifest.json` with your app details:

```json
{
  "name": "[YOUR_APP_NAME]",
  "short_name": "[SHORT_NAME]",
  "theme_color": "[YOUR_PRIMARY_COLOR]",
  "background_color": "#ffffff"
}
```

---

## Phase 3: Architecture

**Goal:** Define your domain model, access control, and database schema.

### 3.1 Domain Modeling

Before writing code, define what your application manages:

- **Entities**: What are the core objects? (Users, Teams, Projects, etc.)
- **Relationships**: How do they relate to each other?
- **Operations**: What can users do with each entity?

> Use `prompts/PromptGuide-Architecture.md` to generate your domain model documentation.

### 3.2 Role-Based Access Control

Define who can do what:

| Role | Description | Permissions |
|------|-------------|------------|
| [Role 1] | [Description] | [What they can access] |
| [Role 2] | [Description] | [What they can access] |
| [Role 3] | [Description] | [What they can access] |

> Document your RBAC model in `docs/architecture/access-control.md`.

### 3.3 Database Schema

Based on your domain model, define your database schema:

```sql
-- Use prompts/PromptGuide-Migration.md to generate migration files
-- Output goes to supabase/migrations/ (or your ORM's migration folder)
```

> Use `prompts/PromptGuide-Migration.md` to generate schema migrations from your domain model.

### 3.4 API Design

If you have a custom API layer, define your endpoints:

> Use `prompts/PromptGuide-Architecture.md` (API section) to generate API documentation.

### 3.5 Document It

Generate your architecture documentation:

```bash
# Fill in ARCHITECTURE.md based on decisions made in this phase
```

> Use `prompts/PromptGuide-Architecture.md` to generate `ARCHITECTURE.md` content.

---

## Phase 4: Core Features

**Goal:** Build the features that make your product valuable.

### 4.1 Write a PRD First

For every feature, start with a Product Requirements Document:

> Use `prompts/PromptGuide-PRD.md` to write a PRD before building anything.

The PRD template covers:
- Problem statement
- User stories
- Acceptance criteria
- Technical approach
- Edge cases

Save PRDs to `docs/prds/[feature-name].md`.

### 4.2 Implement with AI Assistance

With a PRD in hand, use the feature implementation prompt:

> Use `prompts/PromptGuide-Feature.md` to implement features from PRDs.

The workflow:
1. PRD defines *what*
2. Architecture docs define *where* (which files, which patterns)
3. Feature prompt guide defines *how* (step-by-step implementation)

### 4.3 Common SaaS Features

Most SaaS products need these. Build them in roughly this order:

| Priority | Feature | Notes |
|----------|---------|-------|
| 1 | Authentication | Login, signup, password reset, OAuth |
| 2 | User profile | Settings, preferences, avatar |
| 3 | Core value feature | The thing that makes your product useful |
| 4 | Billing/subscriptions | Plans, checkout, portal, webhooks |
| 5 | Team/org management | Invites, roles, permissions |
| 6 | Notifications | Email, in-app, push |
| 7 | Admin dashboard | User management, metrics, config |
| 8 | API access | For integrations and power users |

### 4.4 Testing

> Use `prompts/PromptGuide-Testing.md` to generate test suites for your features.

---

## Phase 5: Operations

**Goal:** Get your application production-ready.

### 5.1 Deployment

Follow the deployment guide for your chosen platform:

- See **[DEPLOYMENT.md](DEPLOYMENT.md)** for the full deployment walkthrough
- Platform-specific instructions for Vercel, Netlify, Railway, and self-hosted

### 5.2 Monitoring and Error Tracking

Set up observability:

| Tool | Purpose | Config |
|------|---------|--------|
| Sentry | Error tracking | `VITE_SENTRY_DSN` in `.env` |
| PostHog | Product analytics | `VITE_POSTHOG_KEY` in `.env` |
| UptimeRobot / Checkly | Uptime monitoring | External service |
| [Your logging tool] | Application logs | Platform-dependent |

### 5.3 Backups and Recovery

- Database backups: [Configure based on your backend choice]
- File storage backups: [Configure based on your storage choice]
- Recovery runbook: Document in `docs/operations/recovery.md`

### 5.4 CI/CD

Set up continuous integration:

```yaml
# .github/workflows/ci.yml -- or your CI platform of choice
# See prompts/PromptGuide-CI.md for generating CI configs
```

---

## Phase 6: Growth

**Goal:** Make your product discoverable and measurable.

### 6.1 SEO

- Meta tags in `index.html`
- Sitemap generation (`scripts/generate-sitemap.js`)
- Open Graph and Twitter Card meta tags
- Structured data (JSON-LD) for your domain

> Reference `docs/seo-checklist.md` for the complete SEO checklist.

### 6.2 Analytics

Configure analytics based on your needs:

| Tool | What It Measures | Setup |
|------|-----------------|-------|
| Google Analytics | Traffic and acquisition | `VITE_GA_MEASUREMENT_ID` |
| PostHog | Product usage and funnels | `VITE_POSTHOG_KEY` |
| Stripe Dashboard | Revenue and churn | Automatic with Stripe |

### 6.3 Localization (i18n)

If you plan to support multiple languages:

> Use `prompts/PromptGuide-i18n.md` to set up internationalization.

### 6.4 Marketing Pages

- Landing page with clear value proposition
- Pricing page with plan comparison
- About/team page
- Blog (optional, but great for SEO)

---

## Phase 7: Launch Prep

**Goal:** Everything that needs to happen before you go live.

### 7.1 Security Audit

Run through the security checklist:

- [ ] Environment variables are not exposed in client bundle
- [ ] API keys use minimum required permissions
- [ ] CORS is configured correctly
- [ ] Rate limiting is in place
- [ ] Input validation on all user inputs
- [ ] SQL injection protection (parameterized queries)
- [ ] XSS protection (output encoding)
- [ ] CSRF protection
- [ ] Authentication flows are tested
- [ ] Password requirements meet standards
- [ ] Session management is secure
- [ ] File upload validation (if applicable)
- [ ] Dependency audit (`npm audit`)

### 7.2 Performance Checklist

- [ ] Lighthouse score > 90 on all categories
- [ ] Images are optimized and lazy-loaded
- [ ] Bundle size is reasonable (< 200KB gzipped for initial load)
- [ ] Fonts are preloaded
- [ ] Critical CSS is inlined
- [ ] API responses are cached appropriately

### 7.3 Legal and Compliance

- [ ] Privacy Policy is published
- [ ] Terms of Service are published
- [ ] Cookie consent banner (if required)
- [ ] GDPR compliance (if serving EU users)
- [ ] CCPA compliance (if serving California users)
- [ ] Data processing agreements with vendors

> See `DATA_INTEROPERABILITY.md` for data ownership and portability requirements.

### 7.4 Mobile / PWA Readiness

If targeting mobile app stores:

- [ ] PWA manifest is configured
- [ ] Service worker is registered
- [ ] App icons in all required sizes
- [ ] Splash screens configured
- [ ] iOS-specific meta tags
- [ ] Android TWA configuration (if applicable)

### 7.5 Launch Day Checklist

- [ ] DNS is configured and propagated
- [ ] SSL certificate is active
- [ ] Monitoring and alerting is live
- [ ] Error tracking is capturing events
- [ ] Analytics is recording
- [ ] Backup system is running
- [ ] Support channel is ready (email, chat, etc.)
- [ ] Social media announcements are drafted
- [ ] Product Hunt / Hacker News post is ready (if applicable)

---

## What's Next

After launch, the work continues:

- **Iterate on features** using the PRD workflow (Phase 4)
- **Monitor and respond** using your operations setup (Phase 5)
- **Grow** using your analytics and marketing (Phase 6)
- **Document decisions** in the `decisions/` folder as you make them

The SaaS-Viber structure scales with you. The prompt guides work just as well for feature #50 as they do for feature #1.

---

*Built with [SaaS-Viber](https://github.com/craftled/SaaS-Viber) -- the integrated SaaS shell for agentic coding and vibe coders.*
