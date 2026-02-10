# Comprehensive Launch Checklist

This is the master launch checklist. Everything here should be verified before you go live with real users and real money. Items are grouped by domain. Work through each section methodically.

---

## Legal

Do not launch without these. Legal issues can shut you down.

### Required Documents

- [ ] **Terms of Service** published at `/terms`
  - Covers acceptable use, limitations of liability, dispute resolution
  - Includes termination clause
  - Specifies governing jurisdiction
- [ ] **Privacy Policy** published at `/privacy`
  - Lists all data collected and why
  - Explains data retention and deletion
  - Names third parties who receive data (analytics, payments, etc.)
  - Provides contact method for data requests
  - GDPR compliant if serving EU users (lawful basis, DPO contact)
  - CCPA compliant if serving California users (opt-out rights)
- [ ] **Cookie Policy** (can be part of Privacy Policy or separate)
  - Lists all cookies and their purpose
  - Cookie consent banner implemented (required for EU)
  - Users can reject non-essential cookies
- [ ] **DPA (Data Processing Agreement)** -- if B2B
  - Required when your customers trust you with their users' data
  - Template available or custom per customer

### Additional Legal Items

- [ ] Company entity formed (LLC, Inc., etc.) or operating as sole proprietor with awareness of liability
- [ ] Business insurance considered (cyber liability, E&O)
- [ ] DMCA/takedown process defined if users can post content
- [ ] Refund policy clearly stated (in terms and on pricing page)
- [ ] Compliance with industry-specific regulations (HIPAA, SOC2, PCI) if applicable

---

## Security

### SSL and Transport

- [ ] HTTPS enforced on all pages (HTTP redirects to HTTPS)
- [ ] SSL certificate auto-renews (Let's Encrypt / your hosting provider)
- [ ] HSTS header set with reasonable max-age
- [ ] No mixed content warnings (all resources loaded over HTTPS)

### Security Headers

- [ ] `Content-Security-Policy` configured (restrict script/style sources)
- [ ] `X-Content-Type-Options: nosniff`
- [ ] `X-Frame-Options: DENY` (or `SAMEORIGIN` if you need iframes)
- [ ] `Referrer-Policy: strict-origin-when-cross-origin`
- [ ] `Permissions-Policy` set (disable unused browser features)
- [ ] Test headers at https://securityheaders.com/

### OWASP Top 10 Review

- [ ] **Injection**: Parameterized queries, input sanitization
- [ ] **Broken Authentication**: Rate limiting on login, strong password requirements
- [ ] **Sensitive Data Exposure**: Secrets not in client bundles, PII encrypted at rest
- [ ] **XML External Entities**: Not applicable for most JSON APIs, but verify
- [ ] **Broken Access Control**: RLS policies verified, authorization checked server-side
- [ ] **Security Misconfiguration**: Default credentials removed, error details not leaked
- [ ] **XSS**: Output encoding, CSP headers, no `dangerouslySetInnerHTML` with user content
- [ ] **Insecure Deserialization**: Validate and sanitize all input
- [ ] **Vulnerable Dependencies**: `npm audit` / `pnpm audit` shows no critical issues
- [ ] **Insufficient Logging**: Security events logged (failed logins, permission denied, etc.)

### Additional Security

- [ ] API rate limiting on all public endpoints
- [ ] File upload validation (type, size, content)
- [ ] Admin routes require elevated permissions
- [ ] Secrets rotated if any were ever committed to git (check git history)
- [ ] Two-factor authentication available for user accounts (recommended)

---

## Performance

### Lighthouse Scores (Target: 90+)

- [ ] Run Lighthouse on landing page (mobile and desktop)
- [ ] Run Lighthouse on app dashboard (authenticated)
- [ ] Run Lighthouse on pricing page
- [ ] Address any red or orange scores

### Load Testing

- [ ] Define expected concurrent user count
- [ ] Load test critical paths at 2-3x expected load
- [ ] Identify and fix bottlenecks (slow queries, missing indexes, unoptimized assets)
- [ ] Document maximum capacity and scaling plan

### CDN and Caching

- [ ] Static assets served from CDN
- [ ] Cache headers set correctly (static assets: long cache, HTML: no cache or short)
- [ ] CDN configured to serve from edge locations near your users
- [ ] Verify CDN is working (check response headers for CDN indicators)

### Image Optimization

- [ ] All images compressed and properly sized
- [ ] Modern formats used (WebP, AVIF) with fallbacks
- [ ] Responsive images with `srcset` for different screen sizes
- [ ] Lazy loading for below-the-fold images
- [ ] No images larger than 500KB (marketing), 200KB (app UI)

---

## Monitoring

### Error Tracking

- [ ] Error tracking service active (Sentry, LogRocket, Bugsnag)
- [ ] Source maps uploaded for meaningful stack traces
- [ ] Alert thresholds set (e.g., notify on 10+ errors in 5 minutes)
- [ ] Team notification channel configured (email, Slack)
- [ ] Test: trigger an error and verify it appears in dashboard

### Uptime Monitoring

- [ ] Uptime service monitoring production URL (Uptime Robot, Better Stack, Pingdom)
- [ ] Check interval: 1-5 minutes
- [ ] Alert channels configured (email, SMS, Slack)
- [ ] Status page created and publicly accessible
- [ ] Test: take your health check endpoint down briefly and verify alert fires

### Log Aggregation

- [ ] Structured logging in your application (JSON format)
- [ ] Logs aggregated in a central service (if not using hosting provider's built-in)
- [ ] Log retention period set (30-90 days minimum)
- [ ] Sensitive data not logged (passwords, tokens, PII)

### Alerting

- [ ] Error rate spike alert
- [ ] Response time degradation alert
- [ ] Disk/memory usage alert (if managing infrastructure)
- [ ] Failed payment webhook alert
- [ ] SSL certificate expiry alert (most monitoring tools offer this)

---

## Analytics

### Event Tracking

- [ ] Page views tracked
- [ ] Signup event tracked
- [ ] Core feature usage tracked (the thing your product does)
- [ ] Payment events tracked (trial start, conversion, churn)
- [ ] Key user actions tracked (enough to understand behavior, not everything)

### Conversion Funnels

- [ ] Visitor to signup funnel defined and tracked
- [ ] Signup to activation funnel defined (what makes a user "active"?)
- [ ] Trial to paid conversion funnel defined
- [ ] Document your activation metric (the action that predicts retention)

### User Properties

- [ ] Plan/tier stored as user property
- [ ] Signup date stored
- [ ] Key usage metrics stored (for segmentation)
- [ ] UTM parameters captured at signup (to attribute acquisition channels)

---

## SEO

- [ ] Sitemap generated and submitted to Google Search Console
- [ ] `robots.txt` configured (public pages allowed, app routes blocked)
- [ ] Meta title and description on every public page
- [ ] Open Graph tags on every public page
- [ ] Twitter Card tags on every public page
- [ ] Structured data on homepage and key pages (Organization, SoftwareApplication)
- [ ] Canonical URLs set to prevent duplicate content
- [ ] 404 page returns proper 404 status code (not 200)
- [ ] Page speed optimized (see Performance section)
- [ ] See `SEO_SETUP_GUIDE.md` for full details

---

## Email

### Deliverability

- [ ] Sending domain authenticated with DNS records
- [ ] SPF record configured
- [ ] DKIM record configured
- [ ] DMARC record configured (start with `p=none`, move to `p=quarantine`)
- [ ] Test deliverability score at https://www.mail-tester.com/
- [ ] Verify emails land in inbox (not spam) on Gmail, Outlook, Yahoo

### Templates

- [ ] All transactional templates branded and tested
- [ ] Plain text version exists for every HTML email
- [ ] Unsubscribe link works in marketing emails
- [ ] Reply-to address is monitored
- [ ] Emails render correctly on mobile

---

## Payments

- [ ] **Test transactions**: Run complete purchase flow with test cards
- [ ] **Webhook reliability**: Stripe webhooks verified with signature checking
- [ ] **Failed payment handling**: Dunning emails configured
- [ ] **Subscription lifecycle**: Create, upgrade, downgrade, cancel all work
- [ ] **Billing portal**: Users can update payment method and view invoices
- [ ] **Refund process**: Documented and tested
- [ ] **Tax handling**: Stripe Tax or manual tax configuration (varies by jurisdiction)
- [ ] **Receipt emails**: Sent automatically on successful payment
- [ ] **Pricing page**: Matches actual Stripe product/price configuration
- [ ] **Currency**: Correct currency displayed for your target market

---

## Accessibility

### WCAG 2.1 AA Compliance

- [ ] Keyboard navigation works on all interactive elements
- [ ] Focus indicators are visible
- [ ] All images have meaningful alt text (or empty alt for decorative)
- [ ] Color contrast meets minimum ratios (4.5:1 text, 3:1 UI components)
- [ ] Form inputs have associated labels
- [ ] Error messages are associated with form fields (aria-describedby)
- [ ] Page structure uses semantic HTML (headings, landmarks, lists)
- [ ] Screen reader testing performed (VoiceOver, NVDA, or JAWS)
- [ ] Animations respect `prefers-reduced-motion`
- [ ] Touch targets are at least 44x44 pixels on mobile

---

## Backup and Recovery

- [ ] **Database backups**: Automated, at least daily
- [ ] **Backup retention**: 30 days minimum
- [ ] **Restore tested**: Actually restore a backup to verify it works
- [ ] **Point-in-time recovery**: Enabled if your database supports it
- [ ] **Disaster recovery plan**: Documented procedure for total failure
- [ ] **Data export**: Users can export their data (GDPR requirement, good practice)

---

## Documentation

- [ ] **User documentation**: How to use your product (help center, docs site)
- [ ] **API documentation**: If you have a public or partner API
- [ ] **Internal runbooks**: How to deploy, rollback, handle incidents
- [ ] **Architecture overview**: For onboarding new team members
- [ ] **Decision log**: Why you chose what you chose (for future you)

---

## Support

- [ ] **Help desk**: Ticketing system or shared inbox for support requests
- [ ] **Feedback mechanism**: Way for users to suggest features or report issues
- [ ] **Status page**: Public page showing current system status
- [ ] **Response time commitment**: Define and communicate your support SLA
- [ ] **Escalation path**: Who handles what when things go wrong
- [ ] **FAQ / Knowledge base**: Answers to common questions

---

## Final Verification

Before flipping the switch:

- [ ] All checklist items above completed or consciously deferred with documented reasoning
- [ ] Full smoke test passed on production (see Launch Day Checklist in `CHECKLISTS.md`)
- [ ] Team is aligned on launch plan and availability
- [ ] Rollback plan is documented and tested
- [ ] You have slept recently and eaten food

---

*This checklist is thorough by design. Not every item applies to every product, and not every item needs to be perfect on day one. But you should have consciously decided to ship or defer each one. The worst launches are the ones where something was simply forgotten.*
