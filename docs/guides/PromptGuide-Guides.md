# Guides Prompt Guide

Ready-to-use prompts for generating customized versions of each guide template. Copy a prompt, fill in the bracketed placeholders with your specifics, and paste it into your AI assistant.

Each prompt references the template file it is based on. Read the template first so you know what good output looks like.

---

## 1. Generate a Branding Guide from Your Brand Identity

**Template reference**: `BRANDING_GUIDE.md`

### Prompt

```
I'm building a SaaS product and need to create a complete branding guide.

Here's my brand identity:
- Product name: [your product name]
- One-line description: [what it does and for whom]
- Target audience: [describe your ideal customer]
- Brand personality: [e.g., professional but approachable, playful, minimal, bold]
- Primary brand color: [hex code or color name, if you have one]
- Existing logo: [yes/no, describe it if yes]
- Industry/vertical: [your product's space]

Using the structure from a SaaS branding guide, generate:

1. A complete color palette (primary, secondary, neutrals, semantic colors) with specific hex values. Ensure all text colors pass WCAG 2.1 AA contrast requirements against their intended backgrounds.

2. Typography recommendations (2 font pairings that match my brand personality, with a type scale from xs to 4xl).

3. Logo usage guidelines (sizes needed, formats, versions for light/dark backgrounds).

4. Favicon and social media asset specifications with exact pixel dimensions.

5. A design token file I can paste into my project (CSS custom properties format).

6. A brand consistency checklist I can review quarterly.

Make it practical and specific. I want to copy values directly into my codebase.
```

---

## 2. Create a Launch Checklist for Your Specific SaaS

**Template reference**: `LAUNCH_CHECKLIST.md`, `CHECKLISTS.md`

### Prompt

```
I'm preparing to launch a SaaS product and need a customized launch checklist.

About my product:
- Product name: [name]
- What it does: [one paragraph description]
- Tech stack: [e.g., Next.js, Supabase, Stripe, Vercel]
- Target audience: [who are your users]
- Business model: [e.g., freemium with $29/mo pro plan, free trial, etc.]
- Handles user data: [describe what data you collect]
- Regions served: [e.g., US only, global, EU included]
- Has mobile app: [yes/no, iOS/Android/both]
- Team size: [solo, 2-5, larger]

Using comprehensive SaaS launch checklist best practices, generate a customized checklist that covers:

1. Legal requirements specific to my regions and data handling
2. Security checklist appropriate for my tech stack
3. Performance benchmarks I should hit before launch
4. Monitoring and alerting setup for my specific infrastructure
5. Analytics events I should track based on my business model
6. SEO tasks specific to my product type
7. Email setup tasks
8. Payment flow verification steps for my pricing model
9. Accessibility requirements
10. Backup and disaster recovery plan

For each item:
- Mark it as [CRITICAL] (blocks launch), [IMPORTANT] (should have), or [NICE-TO-HAVE]
- Estimate time to complete
- Note any dependencies on other items

Organize it as a timeline: what to do 2 weeks before, 1 week before, day before, day of, and week after launch.
```

---

## 3. Generate SEO Strategy for Your SaaS Product

**Template reference**: `SEO_SETUP_GUIDE.md`

### Prompt

```
I need an SEO strategy for my SaaS product.

About my product:
- Product name: [name]
- What it does: [description]
- Target keywords I think are relevant: [list 5-10 keywords]
- Competitors: [list 2-3 competitor products or websites]
- Current pages: [list your main pages: homepage, pricing, blog, docs, etc.]
- Content resources: [how much time/budget for content creation]
- Technical stack: [framework, hosting, etc.]

Generate a complete SEO implementation plan:

1. Technical SEO setup:
   - Structured data markup (JSON-LD) for my homepage, pricing page, and key pages with actual code I can paste
   - Open Graph and Twitter Card meta tags template
   - Sitemap configuration recommendations
   - robots.txt configuration
   - Page speed optimization priorities for my tech stack

2. Keyword strategy:
   - Validate or refine my target keywords
   - Suggest long-tail keywords I should target
   - Map keywords to specific pages
   - Identify content gaps vs competitors

3. Content plan:
   - 10 blog post titles targeting my keywords with search intent analysis
   - Content structure template optimized for featured snippets
   - Internal linking strategy

4. AI/LLM search optimization:
   - Recommendations for being cited by AI search tools
   - llms.txt file content for my product

5. Monthly SEO maintenance checklist specific to my product

Be specific. Include actual code snippets, actual keyword suggestions, and actual content titles -- not generic advice.
```

---

## 4. Create a Training Path for Your Team

**Template reference**: `TRAINING_PATH.md`

### Prompt

```
I need to create a training path for my SaaS team.

About my situation:
- Product: [name and brief description]
- Tech stack: [list technologies]
- Team composition: [e.g., 1 frontend dev, 1 backend dev, 1 designer, 1 marketer]
- Current stage: [idea, MVP in progress, launched, growing]
- Biggest knowledge gaps: [what does your team struggle with]
- Timeline pressure: [when do you need to launch/ship next milestone]

Generate a customized training path with 4 phases:

Phase 1 - Foundation:
- Specific setup tasks for our tech stack
- Key decisions we need to make (list them with context for our product)
- Environment and tooling setup checklist

Phase 2 - Core Product:
- Domain modeling guidance specific to our product type
- Feature breakdown with priority order
- Quality bar definition (what "done" means for each feature)

Phase 3 - Growth:
- Analytics implementation plan for our business model
- Marketing channels most relevant to our audience
- Content strategy for our niche

Phase 4 - Scale:
- Performance optimization priorities for our stack
- Team process recommendations for our team size
- Technical debt management approach

For each phase:
- Estimated time to complete
- Self-assessment questions to verify readiness for next phase
- Specific tools and resources to learn
- Red flags that indicate you moved on too soon

Tailor everything to our specific product and team. Generic advice is not helpful.
```

---

## 5. Generate Workflow Automations for Key User Journeys

**Template reference**: `WORKFLOW_AUTOMATION.md`

### Prompt

```
I need to design workflow automations for my SaaS product.

About my product:
- Product name: [name]
- What it does: [description]
- Key user journeys:
  1. [Describe journey 1: e.g., "User signs up, completes onboarding, creates first project"]
  2. [Describe journey 2: e.g., "User hits usage limit, upgrades plan"]
  3. [Describe journey 3: e.g., "User invites team member, team member accepts"]
- Payment provider: [Stripe, etc.]
- Email provider: [Resend, Postmark, etc.]
- Notification channels: [email, in-app, push, Slack, etc.]
- Integration platform preference: [Zapier, Make, n8n, custom, no preference]

Generate:

1. An event catalog for my product:
   - Event name (following dot-notation convention)
   - Description
   - Trigger condition
   - Payload fields with types

2. Automation flows for each user journey:
   - Step-by-step sequence with timing
   - Branch logic (if user did X, then Y; otherwise Z)
   - Which system handles each step (email provider, in-app, webhook, etc.)

3. Critical operational automations:
   - Payment failure handling (dunning sequence)
   - Subscription lifecycle management
   - Usage monitoring and alerting

4. Webhook security implementation:
   - Signing code snippet for my tech stack
   - Verification code snippet for inbound webhooks (especially payment provider)

5. Testing plan:
   - How to test each automation end-to-end
   - What to monitor after going live

Make the event payloads specific to my product, not generic examples.
```

---

## 6. Create iOS/Android Submission Materials

**Template reference**: `IOS_READINESS_CHECKLIST.md`, `ANDROID_READINESS_CHECKLIST.md`

### Prompt

```
I need to prepare App Store and/or Google Play submission materials for my SaaS product's mobile app.

About my app:
- Product name: [name]
- What it does: [description]
- Target platform(s): [iOS, Android, or both]
- App type: [native, React Native, Flutter, PWA wrapper, etc.]
- Monetization: [free, freemium, subscription through app, subscription through web]
- Uses these permissions: [camera, location, notifications, contacts, etc.]
- Has user-generated content: [yes/no]
- Target audience age: [everyone, 13+, 17+, etc.]

Generate:

1. App Store / Play Store description:
   - App name (within character limits)
   - Subtitle/short description
   - Full description with feature bullets
   - Keywords (iOS: 100 chars, comma separated)

2. Screenshot plan:
   - What to show in each of the 5-6 key screenshots
   - Caption text for each screenshot
   - Required device sizes for each platform

3. Privacy compliance:
   - Privacy nutrition label responses (iOS) based on my app's data usage
   - Data Safety form responses (Android) based on my app's data usage
   - Privacy policy sections that need updating for mobile-specific data

4. Pre-submission review checklist:
   - Common rejection reasons that apply to my app type
   - Specific compliance items for my app's permissions and features
   - Review notes template with demo account instructions

5. Launch timeline:
   - Step-by-step submission process
   - Expected review times
   - What to prepare for each step

Be specific to my app. Do not give me generic boilerplate -- I need text I can paste directly into App Store Connect or Play Console.
```

---

## Tips for Using These Prompts

1. **Fill in every bracket.** The more specific you are, the more useful the output. "A project management tool for freelance designers" gets better results than "a SaaS product."

2. **Iterate.** These prompts generate a first draft. Follow up with "Make the color palette warmer" or "Add more detail to the subscription automation" to refine.

3. **Read the template first.** The templates in this guide set show you what good output looks like. If the AI generates something that does not match the structure, point it at the template.

4. **Combine prompts.** You can chain these: generate branding first, then reference the output in your launch checklist prompt. Context compounds.

5. **Keep outputs in your repo.** Save generated guides alongside these templates. They become living documentation for your project.

6. **Update as you ship.** Run these prompts again when your product evolves. A pre-launch checklist for an MVP is different from one for a v2 with mobile apps.

---

## Quick-Reference: Which Prompt for Which Situation

| Situation | Prompt to Use |
|---|---|
| Starting a new project | #1 Branding + #4 Training Path |
| Preparing to launch | #2 Launch Checklist + #3 SEO Strategy |
| Adding integrations | #5 Workflow Automations |
| Going mobile | #6 iOS/Android Submission |
| Onboarding a new team member | #4 Training Path |
| Quarterly review | #2 Launch Checklist (re-run against current state) |

---

*These prompts are starting points. The best results come from being specific about your product, your constraints, and your goals. Generic inputs produce generic outputs.*
