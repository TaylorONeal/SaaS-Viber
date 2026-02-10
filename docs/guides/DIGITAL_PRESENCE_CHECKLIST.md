# Digital Presence Checklist

Every place your product exists online. If someone searches for your product name, these are the results you want them to find -- and you want them all to say the same thing.

---

## 1. Domain and Hosting

### Domain Setup

- [ ] Primary domain purchased (e.g., `yourproduct.com`)
- [ ] Consider also purchasing `.co`, `.io`, or `.app` variants to prevent squatters
- [ ] DNS configured with your hosting provider
- [ ] SSL certificate active and auto-renewing
- [ ] `www` redirects to non-www (or vice versa -- pick one and be consistent)
- [ ] Old/alternate domains redirect to primary

### DNS Records

- [ ] A/CNAME records pointing to your hosting
- [ ] MX records for email
- [ ] TXT records for email verification (SPF, DKIM, DMARC)
- [ ] TXT record for Google Search Console verification
- [ ] TXT record for Bing Webmaster verification (if not importing from GSC)

### Hosting Verification

- [ ] Production site loads on primary domain
- [ ] HTTPS enforced everywhere
- [ ] CDN configured for static assets
- [ ] Response times are acceptable from target geographic regions

---

## 2. Google Business Profile

**Applicable if**: You have a physical location, serve local customers, or want to appear in Google's business knowledge panel.

- [ ] Claim your Google Business Profile at https://business.google.com
- [ ] Complete all profile fields (name, category, description, URL)
- [ ] Upload logo and cover photo
- [ ] Set business hours (or mark as "online only")
- [ ] Add products/services listing
- [ ] Verify ownership (postcard, phone, or instant verification)
- [ ] Monitor and respond to reviews

**Not applicable?** Skip this section. Most pure SaaS products do not need a Google Business Profile unless they have a local component.

---

## 3. Social Media Accounts

### Essential (claim these even if you do not post regularly)

- [ ] **X / Twitter**: `@yourproduct` -- Best for product updates, community
- [ ] **LinkedIn Company Page** -- Best for B2B credibility, hiring
- [ ] **GitHub** -- If your product is developer-facing or has open-source components

### Recommended (based on your audience)

- [ ] **YouTube** -- Product demos, tutorials, thought leadership
- [ ] **Instagram** -- If your product is visual or consumer-facing
- [ ] **TikTok** -- If your audience skews younger or you can create short-form content
- [ ] **Reddit** -- Participate in relevant subreddits (do not spam)
- [ ] **Discord / Slack Community** -- For community-driven products
- [ ] **Bluesky** -- Growing alternative, worth claiming handle

### Profile Consistency

For every social account:
- [ ] Same display name (your product name)
- [ ] Same profile picture (your logo icon mark)
- [ ] Same bio/description (one sentence value proposition)
- [ ] Link to your website
- [ ] Branded cover/banner image where applicable

---

## 4. App Store Listings

**Applicable if**: You have a mobile app or PWA listed in stores.

### Apple App Store
- [ ] Developer account created ($99/year)
- [ ] App listing with screenshots, description, keywords
- [ ] Privacy policy URL linked
- [ ] App icon meets Apple's requirements
- [ ] See `IOS_READINESS_CHECKLIST.md` for full details

### Google Play Store
- [ ] Developer account created ($25 one-time)
- [ ] Store listing with screenshots, description, feature graphic
- [ ] Privacy policy URL linked
- [ ] Content rating questionnaire completed
- [ ] See `ANDROID_READINESS_CHECKLIST.md` for full details

### Web App Directories
- [ ] Product Hunt listing (time your launch)
- [ ] AlternativeTo.net listing
- [ ] G2 profile (for B2B)
- [ ] Capterra listing (for B2B)

---

## 5. Review Platforms

People will look for reviews before buying. Control the narrative by being present.

- [ ] **G2** -- Primary for B2B SaaS
- [ ] **Capterra** -- Secondary B2B review site
- [ ] **Trustpilot** -- More consumer-facing
- [ ] **Product Hunt** -- Launch reviews and ongoing upvotes
- [ ] **App Store / Play Store** -- If you have mobile apps

### Review Strategy

- [ ] Ask happy users for reviews (after a positive interaction, not randomly)
- [ ] Respond to every negative review professionally and promptly
- [ ] Never fake reviews -- it destroys trust and platforms detect it
- [ ] Add review links to your post-purchase email flow

---

## 6. Directory Listings

Get listed in relevant directories for your niche. This helps with SEO (backlinks) and discovery.

### General SaaS Directories

- [ ] Product Hunt
- [ ] BetaList (for pre-launch)
- [ ] SaaSHub
- [ ] AlternativeTo
- [ ] There's An AI For That (if AI-related)

### Industry-Specific Directories

- [ ] Identify 5-10 directories specific to your niche
- [ ] Create consistent listings with your branding
- [ ] Verify all links point to your current domain
- [ ] Update listings if your product or pricing changes

### Developer Directories (if applicable)

- [ ] Awesome lists on GitHub (relevant to your category)
- [ ] Framework-specific plugin/integration directories
- [ ] API marketplaces (RapidAPI, etc.)

---

## 7. Email Setup

### Transactional Email

Emails triggered by user actions (signup, password reset, receipts).

- [ ] Transactional email provider configured (Resend, Postmark, SendGrid)
- [ ] Sending domain verified (SPF, DKIM, DMARC records)
- [ ] From address set to `noreply@yourproduct.com` or `hello@yourproduct.com`
- [ ] Reply-to set to a monitored inbox
- [ ] All transactional templates branded and tested
- [ ] Bounce handling configured
- [ ] Unsubscribe link in non-critical emails

### Marketing Email

Newsletters, product updates, promotions.

- [ ] Email marketing provider configured (ConvertKit, Mailchimp, Loops, etc.)
- [ ] Separate sending domain or subdomain for marketing (protects transactional reputation)
- [ ] Double opt-in enabled for marketing lists
- [ ] Unsubscribe works instantly and reliably
- [ ] CAN-SPAM / GDPR compliant (physical address, clear sender, easy unsubscribe)
- [ ] Welcome sequence created for new subscribers

### Email Authentication

- [ ] **SPF record**: Tells receiving servers which IPs can send for your domain
- [ ] **DKIM record**: Cryptographically signs emails to prove authenticity
- [ ] **DMARC record**: Tells receivers what to do with failed SPF/DKIM checks
- [ ] Test with https://www.mail-tester.com/ -- aim for 9/10 or higher
- [ ] Test delivery to Gmail, Outlook, and Yahoo (check spam folders)

---

## 8. Analytics Setup

### Web Analytics

- [ ] Privacy-friendly analytics installed (Plausible, Fathom, or PostHog)
- [ ] Google Analytics (if you want the full Google ecosystem integration)
- [ ] Goals/conversions defined (signup, trial start, purchase)
- [ ] UTM parameters used in all marketing links
- [ ] Analytics verified: visit your site and confirm events appear

### Product Analytics

- [ ] Key user actions tracked (feature usage, core workflows)
- [ ] Funnel defined: visitor > signup > activation > payment > retention
- [ ] User properties set (plan type, signup date, usage tier)
- [ ] Session recording enabled on key pages (Hotjar, PostHog, LogRocket)
- [ ] Dashboard created with your top 5 metrics

### Search Analytics

- [ ] Google Search Console connected (see `SEO_SETUP_GUIDE.md`)
- [ ] Bing Webmaster Tools connected
- [ ] Keyword tracking for your top 10 target keywords (Ahrefs, SEMrush, or free alternatives)

---

## 9. Brand Consistency Audit

Run this audit after initial setup and then quarterly.

### Visual Consistency

- [ ] Logo is the same everywhere (website, social, email, app stores)
- [ ] Color palette is consistent across all touchpoints
- [ ] Typography is consistent (same fonts on web, email, marketing)
- [ ] OG images are current and branded (test by sharing a link)
- [ ] Favicon is visible and correct

### Messaging Consistency

- [ ] Product name is spelled the same everywhere (capitalization matters)
- [ ] Tagline/description is consistent across profiles
- [ ] Value proposition is the same on landing page, social bios, and directories
- [ ] Pricing information is current on all pages and directories

### Link Audit

- [ ] All social profiles link to your current website
- [ ] All directory listings have correct URLs
- [ ] No broken links on your marketing pages
- [ ] Old URLs redirect properly (do not 404)

### Contact Information

- [ ] Support email is listed and monitored
- [ ] Social accounts are listed on your website
- [ ] Status page URL is accessible
- [ ] All contact forms work and deliver to a monitored inbox

---

*Your digital presence is the sum of every place someone encounters your product online. Inconsistency erodes trust. Spend an afternoon getting this right, then audit it quarterly to keep it tight.*
