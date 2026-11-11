# Frequently Asked Questions — [YOUR_APP_NAME]

> **Purpose:** Answer common questions organized by audience. Use this template to build
> your FAQ as features are developed. Each answer should be kept concise (2-4 sentences)
> with links to deeper documentation where applicable.
>
> **Last Updated:** [DATE]

---

## For Users

### General

**Q: What is [YOUR_APP_NAME]?**
A: [YOUR_APP_NAME] is a [YOUR_PRODUCT_CATEGORY] that helps [YOUR_TARGET_AUDIENCE] to [YOUR_PRIMARY_VALUE_PROPOSITION]. [One additional sentence about what makes it unique.]

**Q: Who is [YOUR_APP_NAME] for?**
A: [YOUR_APP_NAME] is designed for [PRIMARY_USER_PERSONA] who need to [PRIMARY_USE_CASE]. It also serves [SECONDARY_USER_PERSONA] who [SECONDARY_USE_CASE].

**Q: How do I get started?**
A: Visit [YOUR_SIGNUP_URL] and create a free account. Our onboarding flow will guide you through [KEY_SETUP_STEPS]. You can [REACH_VALUE_STATEMENT, e.g., "have your first project set up in under 5 minutes"].

**Q: Is there a free trial or free tier?**
A: [Describe your free offering. e.g., "Yes, we offer a [X]-day free trial of our [TIER_NAME] plan with full access to all features. No credit card required." OR "We have a free tier that includes [FEATURES] with limits of [LIMITS]."]

**Q: What platforms do you support?**
A: [YOUR_APP_NAME] is available as a [web app / mobile app / desktop app]. We support [LIST_BROWSERS] for web, and [iOS X+ / Android X+] for mobile. [Mention any platform-specific notes.]

### Account & Profile

**Q: How do I reset my password?**
A: Click "Forgot Password" on the login page and enter your email address. You will receive a password reset link within a few minutes. Check your spam folder if you do not see it.

**Q: Can I change my email address?**
A: [Yes/No]. [If yes: Navigate to Settings > Profile and update your email. You will need to verify the new email address.] [If no: Contact support at [SUPPORT_EMAIL] to request an email change.]

**Q: How do I delete my account?**
A: Navigate to Settings > Account > Delete Account. This action is [irreversible / reversible within X days]. All your data will be [permanently deleted / anonymized / retained for X days]. [Mention any data export option.]

**Q: Can I have multiple accounts?**
A: [Describe your policy. e.g., "Each email address can be associated with one account. If you need to manage multiple organizations, you can be a member of multiple organizations from a single account."]

### Features & Usage

**Q: How do I [PRIMARY_ACTION]?**
A: [Step-by-step instructions for the primary action. e.g., "Navigate to the Dashboard and click 'Create New'. Fill in the required fields and click 'Save'. Your new [ENTITY] will appear in the list."]

**Q: Can I [COMMON_FEATURE_REQUEST]?**
A: [Yes, here's how / Not yet, it's on our roadmap for [PHASE] / We don't currently support this but here's a workaround]. [Link to relevant documentation or roadmap.]

**Q: Is my data secure?**
A: Yes. We use [ENCRYPTION_DETAILS, e.g., "AES-256 encryption at rest and TLS 1.3 in transit"]. Your data is stored in [HOSTING_REGION] and we comply with [COMPLIANCE_FRAMEWORKS, e.g., "SOC 2 Type II, GDPR"]. See our [Security Page / Privacy Policy] for full details.

**Q: Can I export my data?**
A: [Yes/Coming soon]. [If yes: Navigate to Settings > Data > Export. You can export your data in [FORMATS, e.g., "CSV, JSON, PDF"] format. Exports typically complete within [TIMEFRAME].] [If no: We plan to add data export in [PHASE]. Contact support for manual export requests.]

**Q: What happens if the service goes down?**
A: We maintain [UPTIME_SLA, e.g., "99.9% uptime"]. You can check our service status at [STATUS_PAGE_URL]. In the event of an outage, we communicate updates via [CHANNELS, e.g., "our status page, email, and Twitter"].

---

## For Founders Setting Up (added Nov 8, 2026)

**Q: Should I publish as an individual or as a company?**
A: Publish as an individual if you are testing one idea and you do not mind your personal legal name showing as the seller. Publish as an organization, usually an LLC, if you want your name kept private, you plan several apps under one studio name, or you will take payments and sign contracts in the company name. Decide before your first public launch, because switching later is a new enrollment or a transfer, not a setting. See `decisions/DEVELOPER_IDENTITY_CHOICES.md`.

**Q: What email should I use for my app?**
A: Use a business address on your own domain, for example support@yourapp.com, not a personal Gmail address. Your options are free Gmail (fast, but personal and not accepted as Apple's organization work email), email bundled with your domain registrar (usually cheapest, often basic), or Google Workspace (Gmail with your domain, Business Starter $7 per user per month on the annual plan as of Oct 2026). See `docs/guides/EMAIL_AND_DOMAIN_SETUP.md`.

**Q: Do I have to use in-app purchase, or can I take payments on my website?**
A: It depends on what is being bought. Digital goods and subscriptions used inside the app normally require Apple IAP on iOS and Google Play Billing on Android. Physical goods and services used outside the app use web checkout, for example Stripe. In the US, linking out to web checkout currently carries 0% Apple commission, but that rule is in court and may change, so do not build a business that only works at 0%. See `docs/guides/PAYMENTS_IN_APP_VS_WEB.md`.

**Q: When do I create my subscription products?**
A: In the first submission, all of them, attached to the same draft as the app. Adding a product later means a new review, and your paywall cannot ship until Apple approves it. See `docs/guides/PAYMENTS_IN_APP_VS_WEB.md`.

**Q: What pages does my app need before launch?**
A: A landing page, a privacy policy, terms of service, a support page, and a data deletion page, all live on your own domain, plus a waitlist before launch and a feedback form after it. Fill-in templates are in `docs/templates/LEGAL_PAGES_TEMPLATE.md`, and the page guide is `docs/guides/LANDING_WAITLIST_FEEDBACK.md`.

**Q: What is product-led growth, in one sentence?**
A: The product sells itself: a person discovers it, signs up alone, reaches one valuable moment fast, and invites someone else because the work needs them. See `docs/guides/PLG_FRAMEWORK.md`.

**Q: Should I put GA4 in my app?**
A: No, not the web tag. GA4 is for the website: where visitors came from and what they did before they signed up. In the app, use a first-party event table or a vendor SDK chosen with the privacy label and manifest in mind, because Apple treats analytics SDKs that repurpose data as tracking under ATT. See `docs/guides/GA4_AND_WEB_ANALYTICS.md`.

**Q: What is the cheapest analytics stack that actually works?**
A: GA4 standard ($0) for acquisition, PostHog Cloud free (1M events a month) for product, and your own database for customer records. Build and validate on free, run paying customers on paid: a free Supabase project pauses after a week idle, and free PostHog drops usage over the limit instead of billing you. See `docs/guides/FREE_VS_PAID_AND_LICENSES.md`.

**Q: Where does my analytics data live?**
A: In three stores that must never be added together: customer records in your app database, analytics events in a first-party event table, and vendor copies in GA4 or PostHog. One user id joins them, from the first anonymous visit through sign-up to the first payment. See `docs/guides/ANALYTICS_DATABASES_AND_CUSTOMER_RECORDS.md`.

**Q: Can I see which ad brought a paying customer?**
A: Only partway. Web attribution joins at sign-up if you capture UTMs and store them on the customer record. Store installs do not join to in-app behavior: App Store Connect and Play Console report downloads and sources, but not per-person, and iOS gives you the install source only. See `docs/guides/ATTRIBUTION_END_TO_END.md`.

**Q: What does deslop mean here?**
A: Removing the generic AI look (purple gradients, default fonts, centered hero, three equal cards, hollow copy) by studying a pattern, extracting the principle, rebuilding it in your own voice, and adding one improvement, never lifting the original. See `docs/guides/DESIGN_DESLOP.md` and `skills/taste-skill/SKILL.md`.

---

## For Developers

### Setup & Development

**Q: How do I set up the development environment?**
A: See the developer setup guide at `docs/developer/[SETUP_GUIDE].md`. You will need [PREREQUISITES, e.g., "Node.js 18+, PostgreSQL 15+, and Docker"]. Run `[SETUP_COMMAND, e.g., "npm install && npm run dev"]` to start the development server.

**Q: What is the tech stack?**
A: [YOUR_APP_NAME] uses [FRONTEND_TECH, e.g., "Next.js with TypeScript"] on the frontend, [BACKEND_TECH, e.g., "Node.js with Express"] on the backend, [DATABASE_TECH, e.g., "PostgreSQL with Prisma ORM"] for data storage, and [HOSTING_TECH, e.g., "deployed on Vercel / AWS / GCP"]. See [ARCHITECTURE_DOC] for the full architecture overview.

**Q: How do I run tests?**
A: Run `[TEST_COMMAND, e.g., "npm test"]` for unit tests, `[INTEGRATION_TEST_COMMAND]` for integration tests, and `[E2E_TEST_COMMAND]` for end-to-end tests. See [MAINTAINABILITY.md](./architecture/MAINTAINABILITY.md) for our testing strategy.

**Q: How do I create a database migration?**
A: Run `[MIGRATION_COMMAND, e.g., "npx prisma migrate dev --name your_migration_name"]`. See [VERSION_MANAGEMENT.md](./architecture/VERSION_MANAGEMENT.md) for our migration strategy and naming conventions.

**Q: How do deployments work?**
A: [Describe your deployment pipeline. e.g., "Merging to `main` triggers an automatic deployment to staging. Production deploys are triggered by creating a release tag. See the CI/CD pipeline configuration at [CONFIG_PATH]."]

### Architecture

**Q: How is the codebase organized?**
A: [Describe your project structure. e.g., "We use a monorepo with packages for `web` (frontend), `api` (backend), and `shared` (types and utilities). Each package has its own `src/`, `tests/`, and `package.json`."] See [MAINTAINABILITY.md](./architecture/MAINTAINABILITY.md) for standards.

**Q: How does authentication work?**
A: [Describe your auth approach. e.g., "We use [AUTH_PROVIDER, e.g., Supabase Auth / Auth0 / NextAuth] for authentication. Sessions are managed via [JWT / cookies / server sessions]. See [ROLE_ACCESS_CONTROL.md](./architecture/ROLE_ACCESS_CONTROL.md) for authorization details."]

**Q: How is multi-tenancy implemented?**
A: [Describe your multi-tenancy approach. e.g., "We use row-level security with an `organization_id` column on all tenant-scoped tables. The current tenant is determined by [SESSION / SUBDOMAIN / PATH]."] See [DOMAIN_MODEL.md](./architecture/DOMAIN_MODEL.md).

**Q: How do I add a new feature?**
A: 1) Create or reference the PRD in `docs/prd/`. 2) Add the feature to [FEATURE_INDEX.md](./FEATURE_INDEX.md). 3) Create the database migration if needed. 4) Implement the API endpoints. 5) Build the UI components. 6) Write tests. 7) Submit a PR following our [review guidelines](./architecture/MAINTAINABILITY.md).

### API & Integrations

**Q: Is there a public API?**
A: [Yes/Coming soon/No]. [If yes: See our API documentation at [API_DOCS_URL]. Authentication is via [API_KEYS / OAuth / Bearer tokens].] [If no: We plan to offer a public API in [PHASE].]

**Q: How do webhooks work?**
A: [Describe your webhook system. e.g., "Configure webhooks in Settings > Integrations > Webhooks. We send POST requests with a JSON payload for events including [EVENT_LIST]. Payloads are signed with [SIGNATURE_METHOD] for verification."]

---

## For Business / Stakeholders

### Pricing & Billing

**Q: How much does [YOUR_APP_NAME] cost?**
A: [Describe your pricing. e.g., "We offer three tiers: [TIER_1] at $[PRICE]/month, [TIER_2] at $[PRICE]/month, and [TIER_3] at $[PRICE]/month. Annual billing includes a [X]% discount. See our pricing page at [PRICING_URL]."]

**Q: What payment methods do you accept?**
A: [e.g., "We accept all major credit cards (Visa, Mastercard, American Express) and [OTHER_METHODS, e.g., 'ACH bank transfers for annual plans']. Payments are processed securely through [PAYMENT_PROVIDER]."]

**Q: Can I change my plan?**
A: [e.g., "Yes. You can upgrade or downgrade your plan at any time from Settings > Billing. Upgrades take effect immediately and are prorated. Downgrades take effect at the end of your current billing period."]

**Q: What is your refund policy?**
A: [Describe your refund policy. e.g., "We offer a full refund within [X] days of your first payment. After that, you can cancel at any time and your access continues until the end of your billing period. Contact [SUPPORT_EMAIL] for refund requests."]

**Q: Do you offer discounts for nonprofits or education?**
A: [Yes/No]. [If yes: "We offer [X]% off for verified nonprofits and educational institutions. Contact [EMAIL] with proof of status to apply."]

### Security & Compliance

**Q: Where is my data stored?**
A: [e.g., "Your data is stored in [REGION, e.g., 'US-East (Virginia)'] on [PROVIDER, e.g., 'AWS']. We can offer data residency in [OTHER_REGIONS] for [TIER_NAME] plan customers."]

**Q: Are you SOC 2 / GDPR / HIPAA compliant?**
A: [Describe your compliance status. e.g., "We are SOC 2 Type II certified and GDPR compliant. HIPAA compliance is available for [TIER_NAME] plan customers with a signed BAA. See [COMPLIANCE_PAGE_URL] for our full compliance documentation."]

**Q: Do you have a DPA (Data Processing Agreement)?**
A: [e.g., "Yes. Our standard DPA is available at [DPA_URL]. For custom DPA requirements, contact [LEGAL_EMAIL]."]

**Q: What happens to my data if I cancel?**
A: [e.g., "After cancellation, your data is retained for [X] days in case you reactivate. After that, it is permanently deleted from our servers and backups within [X] additional days. You can export your data before canceling."]

### Support & SLA

**Q: How do I get support?**
A: [Describe your support channels. e.g., "Email us at [SUPPORT_EMAIL], use the in-app chat widget, or visit our help center at [HELP_URL]. [TIER_NAME] plan customers have access to priority support with a [X]-hour response time SLA."]

**Q: What is your uptime SLA?**
A: [e.g., "We guarantee [X]% uptime for [TIER_NAME] plan customers. Our historical uptime is [X]%. See our status page at [STATUS_URL] for real-time and historical availability."]

**Q: Can I request a custom feature?**
A: [e.g., "Yes. Submit feature requests via [METHOD, e.g., 'our feedback portal at [URL]']. We review all requests quarterly and prioritize based on demand and alignment with our roadmap. [TIER_NAME] plan customers can request dedicated feature development."]

---

## Prompt Guide for Generating FAQ

```
Based on the features documented in docs/FEATURE_INDEX.md and the PRDs in docs/prd/,
generate an FAQ for [YOUR_APP_NAME] following the template in docs/FAQ.md.

For each feature, generate:
1. One "How do I...?" question for users
2. One common troubleshooting question
3. One architectural question for developers

Guidelines:
- Keep answers to 2-4 sentences
- Include links to relevant documentation
- Use the same tone as the existing FAQ entries
- Replace all [PLACEHOLDER] values with specifics from the codebase
- Add any questions that real users would commonly ask based on the product domain

Product context:
- [YOUR_APP_NAME] is a [PRODUCT_DESCRIPTION]
- Target audience: [TARGET_AUDIENCE]
- Key features: [LIST_KEY_FEATURES]
```

---

## Adding New FAQ Entries

When adding new questions:

1. Place the question in the correct audience section (Users, Developers, Business)
2. Use bold `**Q:**` for the question and `A:` for the answer
3. Keep answers concise (2-4 sentences)
4. Link to deeper documentation when relevant
5. Replace any placeholders with actual values
6. Verify the answer is accurate for the current version

---

*Status: Template*
*Next review: [DATE]*
