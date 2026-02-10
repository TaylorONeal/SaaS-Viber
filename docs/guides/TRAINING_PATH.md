# SaaS Builder Training Path

A structured path from "I have an idea" to "I'm running a production SaaS." Each phase builds on the last. Do not skip phases -- the shortcuts always cost more later.

---

## How to Use This Path

1. Work through each phase sequentially
2. Complete the self-assessment before moving on
3. Reference the linked docs and prompt guides as you go
4. Expect Phase 1-2 to take 2-6 weeks, Phase 3-4 are ongoing

---

## Phase 1: Foundation

**Timeline**: 1-2 weeks

You are making decisions, setting up infrastructure, and establishing your brand. No product code yet.

### Goals
- Every major technical and business decision is documented
- Development environment is fully configured
- Brand identity is established
- You can deploy an empty app to production

### Tasks

- [ ] Define your product in one sentence (who it's for, what it does, why it's better)
- [ ] Choose your tech stack and document the reasons
- [ ] Set up your repository and CI/CD pipeline
- [ ] Configure your hosting/deployment (Vercel, Fly, Railway, etc.)
- [ ] Set up Supabase (or your backend) with auth and database
- [ ] Complete the branding quick setup (name, colors, logo, favicon)
- [ ] Set up domain, DNS, and SSL
- [ ] Create your development, staging, and production environments
- [ ] Set up error tracking (Sentry or equivalent)
- [ ] Create accounts for all third-party services you'll need

### Docs to Read
- `SUPABASE_SETUP.md` -- Backend infrastructure
- `BRANDING_GUIDE.md` -- Visual identity
- `CHECKLISTS.md` -- Pre-Development Checklist section
- `DIGITAL_PRESENCE_CHECKLIST.md` -- Accounts and profiles

### Prompt Guides to Use
- "Generate a branding guide from my brand identity"
- "Help me evaluate tech stack options for [describe your product]"

### Self-Assessment Checkpoint

Answer yes to all before proceeding:
- [ ] Can you deploy to production with one command or push?
- [ ] Is your auth flow working (sign up, sign in, sign out, password reset)?
- [ ] Does your app have a favicon, logo, and consistent brand colors?
- [ ] Are your environment variables documented and securely managed?
- [ ] Could a new developer clone the repo and run locally in under 15 minutes?

---

## Phase 2: Core Product

**Timeline**: 2-4 weeks

You are building the features that make your product useful. Focus on the smallest set of features someone would pay for.

### Goals
- Core domain model is implemented
- Key user workflows are complete end to end
- Payment integration works
- You have something you could show a real user

### Tasks

- [ ] Define your domain model (entities, relationships, key operations)
- [ ] Implement database schema with proper RLS policies
- [ ] Build the 2-3 core features that define your product
- [ ] Implement navigation and information architecture
- [ ] Add payment/subscription integration (Stripe recommended)
- [ ] Build settings/account management pages
- [ ] Implement proper error handling and loading states
- [ ] Add input validation on both client and server
- [ ] Write tests for critical paths (auth, payments, core features)
- [ ] Set up transactional emails (welcome, receipt, password reset)
- [ ] Create a basic onboarding flow for new users
- [ ] Implement proper data backup strategy

### Docs to Read
- `WORKFLOW_AUTOMATION.md` -- Event-driven architecture patterns
- `CHECKLISTS.md` -- MVP Checklist section
- `LAUNCH_CHECKLIST.md` -- Payments section (test early)

### Prompt Guides to Use
- "Help me design the database schema for [your domain]"
- "Generate workflow automations for my key user journeys"
- "Review my RLS policies for security gaps"

### Self-Assessment Checkpoint

- [ ] Can a new user sign up, do the core thing, and get value in under 5 minutes?
- [ ] Can a user pay you money (test mode is fine)?
- [ ] Do errors display helpful messages instead of crashing?
- [ ] Are your critical paths covered by tests?
- [ ] Have you shown it to at least one person who is not you?

---

## Phase 3: Growth

**Timeline**: Ongoing (start after MVP)

You are making your product discoverable, measuring what matters, and improving based on data.

### Goals
- Analytics tell you what users actually do
- Search engines can find you
- You have a basic marketing presence
- Users come back after their first visit

### Tasks

- [ ] Set up analytics (Plausible, PostHog, Mixpanel, or similar)
- [ ] Define and implement key conversion funnels
- [ ] Implement SEO fundamentals (meta tags, sitemap, structured data)
- [ ] Set up Google Search Console and Bing Webmaster Tools
- [ ] Create a landing page that communicates your value proposition
- [ ] Set up email marketing (drip campaigns, product updates)
- [ ] Implement user engagement features (notifications, digests)
- [ ] Add social sharing / referral mechanisms
- [ ] Set up a feedback collection mechanism (in-app, email surveys)
- [ ] Create content strategy (blog, docs, guides, changelog)
- [ ] Optimize page speed (target 90+ Lighthouse score)
- [ ] Set up social media posting cadence

### Docs to Read
- `SEO_SETUP_GUIDE.md` -- Search engine optimization
- `DIGITAL_PRESENCE_CHECKLIST.md` -- Full presence audit
- `WORKFLOW_AUTOMATION.md` -- User engagement automations
- `CHECKLISTS.md` -- Pre-Launch Checklist section

### Prompt Guides to Use
- "Generate SEO strategy for my SaaS product"
- "Create a content calendar for [your product niche]"
- "Design an onboarding email sequence for new signups"

### Self-Assessment Checkpoint

- [ ] Do you know your weekly active user count?
- [ ] Can you see where users drop off in your funnel?
- [ ] Does your product appear in search results for your primary keyword?
- [ ] Are you collecting user feedback systematically?
- [ ] Do you have at least one channel bringing in new users without manual effort?

---

## Phase 4: Scale

**Timeline**: Ongoing (start when you have paying users)

You are hardening your product for reliability, improving performance, and building team processes.

### Goals
- Product stays up when traffic spikes
- Team can ship without you being a bottleneck
- Costs are understood and manageable
- You sleep well at night

### Tasks

- [ ] Load test your critical paths (what happens at 10x current traffic?)
- [ ] Implement caching strategy (CDN, API-level, database query)
- [ ] Set up uptime monitoring with alerting
- [ ] Create incident response runbook
- [ ] Implement rate limiting on public endpoints
- [ ] Set up log aggregation and structured logging
- [ ] Audit and optimize database queries (add indexes, fix N+1s)
- [ ] Document deployment process and rollback procedures
- [ ] Create onboarding docs for new team members
- [ ] Set up code review process and PR templates
- [ ] Implement feature flags for safe rollouts
- [ ] Review and optimize infrastructure costs monthly
- [ ] Plan for multi-region if your user base demands it
- [ ] Security audit (dependency scanning, penetration testing)
- [ ] Set up automated database backups with tested restore process

### Docs to Read
- `LAUNCH_CHECKLIST.md` -- Full launch readiness review
- `CHECKLISTS.md` -- Post-Launch Checklist section
- `IOS_READINESS_CHECKLIST.md` / `ANDROID_READINESS_CHECKLIST.md` -- If going mobile

### Prompt Guides to Use
- "Create a training path for my team"
- "Help me design a caching strategy for [your architecture]"
- "Generate an incident response runbook template"

### Self-Assessment Checkpoint

- [ ] What is your current uptime percentage? (Target: 99.9%)
- [ ] How long does it take to deploy a fix to production? (Target: under 30 minutes)
- [ ] Can someone else on your team ship a feature without your involvement?
- [ ] Do you have alerts for the 3 things that would wake you up at night?
- [ ] Have you tested your backup restore process in the last 30 days?

---

## Continuous Learning

After Phase 4, the work becomes cyclical:

1. **Measure** -- Look at analytics, talk to users, review metrics
2. **Identify** -- Find the biggest bottleneck or opportunity
3. **Plan** -- Scope the work, estimate effort
4. **Build** -- Ship the improvement
5. **Validate** -- Confirm it moved the needle
6. Repeat

### Staying Current
- Follow your framework's release notes
- Review dependency updates monthly
- Watch for security advisories
- Revisit your checklists quarterly
- Update these guides as you learn

---

*This training path is a living document. Customize it for your product, your team size, and your timeline. The phases matter more than the specific tasks -- adapt the tasks to your reality.*
