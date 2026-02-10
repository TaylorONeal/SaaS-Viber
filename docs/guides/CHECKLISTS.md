# Master Checklists

Five checklists that cover the full lifecycle of a SaaS product, from first decisions through post-launch iteration. Work through them in order. Come back and re-check them periodically.

---

## Pre-Development Checklist

Complete this before you write any product code.

### Decisions Made

- [ ] Product name chosen and domain purchased
- [ ] Target audience defined (be specific -- "small business owners" is not specific enough)
- [ ] Core value proposition written in one sentence
- [ ] Pricing model decided (free trial, freemium, paid-only)
- [ ] Tech stack chosen and documented with rationale
- [ ] Hosting/deployment platform selected
- [ ] Database and auth provider selected

### Accounts Created

- [ ] GitHub / GitLab repository
- [ ] Hosting platform (Vercel, Fly, Railway, etc.)
- [ ] Database provider (Supabase, PlanetScale, etc.)
- [ ] Payment processor (Stripe recommended)
- [ ] Error tracking (Sentry, LogRocket, etc.)
- [ ] Email service (Resend, Postmark, SendGrid, etc.)
- [ ] Domain registrar and DNS configured
- [ ] Analytics (Plausible, PostHog, etc.)

### Tools and Environment

- [ ] Repository initialized with README, .gitignore, license
- [ ] CI/CD pipeline configured (builds, tests, deploys on push)
- [ ] Development, staging, and production environments defined
- [ ] Environment variables documented in `.env.example`
- [ ] Code formatting and linting configured (Prettier, ESLint)
- [ ] Editor config shared (`.editorconfig` or VS Code settings)
- [ ] Branch protection rules set on main branch

---

## MVP Checklist

The minimum set of things needed for real users to get value from your product.

### Authentication

- [ ] User registration (email/password and/or social)
- [ ] Login / logout
- [ ] Password reset flow
- [ ] Email verification
- [ ] Session management (token refresh, expiry)
- [ ] Account deletion (required by Apple, GDPR, good practice)

### Core Features

- [ ] Primary user workflow works end to end
- [ ] Data is saved and persists across sessions
- [ ] Navigation is intuitive (user can find every feature)
- [ ] Empty states guide users on what to do
- [ ] Loading states are shown during async operations
- [ ] Success/error feedback for every user action

### Payments (if applicable)

- [ ] Pricing page with clear plan comparison
- [ ] Stripe integration (or your payment processor)
- [ ] Subscription creation and management
- [ ] Billing portal (manage payment method, view invoices)
- [ ] Webhook handling for payment events
- [ ] Dunning (failed payment retry and notifications)
- [ ] Test all payment flows with test cards

### Error Handling

- [ ] Global error boundary catches unhandled errors
- [ ] User-friendly error messages (not stack traces)
- [ ] 404 page exists and is helpful
- [ ] API errors return consistent format
- [ ] Error tracking captures errors with context
- [ ] Form validation errors are inline and specific

### Email

- [ ] Welcome email on registration
- [ ] Email verification message
- [ ] Password reset email
- [ ] Payment receipt (if applicable)
- [ ] All emails tested in major clients (Gmail, Outlook, Apple Mail)

---

## Pre-Launch Checklist

Complete before you publicly announce or share your URL.

### Security

- [ ] All environment variables are in secure storage (not in code)
- [ ] API keys and secrets are not exposed client-side
- [ ] HTTPS enforced (HTTP redirects to HTTPS)
- [ ] Security headers set (CSP, X-Frame-Options, HSTS, etc.)
- [ ] SQL injection prevention verified (parameterized queries)
- [ ] XSS prevention verified (output encoding, CSP)
- [ ] CSRF protection enabled
- [ ] Rate limiting on auth endpoints and public APIs
- [ ] Row Level Security verified on all database tables
- [ ] Dependency audit run (`npm audit`, `pnpm audit`)

### Performance

- [ ] Lighthouse score 90+ on mobile for landing page
- [ ] Images optimized (proper format, size, lazy loading)
- [ ] JavaScript bundle analyzed and minimized
- [ ] CDN configured for static assets
- [ ] Database queries have appropriate indexes
- [ ] API responses are reasonably fast (under 500ms for common operations)

### Legal

- [ ] Terms of Service published
- [ ] Privacy Policy published
- [ ] Cookie consent banner (if required for your audience)
- [ ] GDPR compliance (if serving EU users): data export, deletion, DPA
- [ ] Accessibility statement (recommended)

### Monitoring

- [ ] Error tracking is active and receiving events
- [ ] Uptime monitoring configured with alerts
- [ ] Key metrics dashboard set up
- [ ] Alert thresholds defined (error rate, response time)
- [ ] Log retention configured

---

## Launch Day Checklist

The day you go live. Most of these should be done, not started, on launch day.

### Infrastructure

- [ ] Production DNS propagated and verified
- [ ] SSL certificate active and auto-renewing
- [ ] Production environment variables all set correctly
- [ ] Database migrations applied to production
- [ ] CDN is warming / caching correctly

### Monitoring (Verify Active)

- [ ] Error tracking: trigger a test error and confirm it appears
- [ ] Uptime monitor: confirm it pings your production URL
- [ ] Alert channels: confirm alerts reach you (email, Slack, SMS)
- [ ] Check real-time logs for any startup errors

### Quick Smoke Test

- [ ] Load the homepage -- does it render correctly?
- [ ] Sign up a new account -- does the full flow work?
- [ ] Perform the core action -- does it save and display correctly?
- [ ] Process a test payment (if applicable)
- [ ] Send a test transactional email
- [ ] Check the site on mobile
- [ ] Check the site in incognito / private browsing

### Communications

- [ ] Launch announcement drafted (social, email, communities)
- [ ] Support channels ready (email, chat, help desk)
- [ ] Status page created and URL is accessible
- [ ] Team knows the launch plan and escalation process

### Backup Plan

- [ ] Database backup taken immediately before launch
- [ ] Rollback procedure documented and tested
- [ ] Previous working version tagged in git
- [ ] Team availability confirmed for the next 24-48 hours

---

## Post-Launch Checklist

The first 30 days after launch. This is where most SaaS products either gain momentum or stall.

### Week 1

- [ ] Monitor error rates daily (expect some -- fix them fast)
- [ ] Respond to every piece of user feedback within 24 hours
- [ ] Check analytics daily for unexpected patterns
- [ ] Verify payment webhooks are processing correctly
- [ ] Fix any critical bugs immediately
- [ ] Monitor server costs and resource usage

### Week 2-4

- [ ] Identify top 3 user complaints or friction points
- [ ] Ship at least one improvement based on user feedback
- [ ] Review and respond to any support tickets
- [ ] Publish a changelog entry for any updates
- [ ] Check search console for indexing status
- [ ] Run a security scan (dependency audit, header check)

### Ongoing

- [ ] Weekly analytics review (key metrics, funnel, retention)
- [ ] Monthly cost review (infrastructure, services, tools)
- [ ] Monthly security updates (dependency updates, patches)
- [ ] Quarterly review of these checklists
- [ ] Collect and publish testimonials/case studies
- [ ] Iterate on onboarding based on where users drop off

### Iteration Planning

After 30 days, you should have enough data to prioritize:

1. **What breaks** -- Fix bugs and reliability issues first
2. **What confuses** -- Improve UX where users get stuck
3. **What's missing** -- Add features users explicitly ask for
4. **What could grow** -- Invest in acquisition and retention

---

*Print these out or pin them somewhere visible. The checklists are only useful if you actually check the boxes. Be honest with yourself about what is done versus what is "good enough."*
