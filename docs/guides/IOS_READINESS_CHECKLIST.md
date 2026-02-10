# iOS Launch Readiness Checklist

Everything required to get your app from development to the App Store. This guide covers the bureaucratic and technical requirements that Apple enforces -- miss any of them and your submission will be rejected.

---

## 1. Apple Developer Account

- [ ] Enroll in the Apple Developer Program ($99/year)
- [ ] Use a company/organization enrollment if possible (requires D-U-N-S number)
- [ ] Individual enrollment is fine for solo developers but limits some features
- [ ] Enable two-factor authentication on your Apple ID (required)
- [ ] Enrollment approval can take 24-48 hours, sometimes longer for organizations

---

## 2. App ID and Certificates

### App ID

- [ ] Create an App ID in Apple Developer portal (Certificates, Identifiers & Profiles)
- [ ] Choose explicit App ID (not wildcard) for production
- [ ] Bundle ID format: `com.yourcompany.yourapp`
- [ ] Enable capabilities you need (Push Notifications, Sign in with Apple, etc.)

### Certificates

- [ ] Create a Distribution certificate (for App Store submissions)
- [ ] Create an APNs certificate or key if using push notifications
- [ ] Store certificates and keys securely (do not commit to git)
- [ ] Note certificate expiration dates and set renewal reminders

### Provisioning Profiles

- [ ] Create App Store distribution provisioning profile
- [ ] Create Development provisioning profile (for testing)
- [ ] Add test devices to your developer account for ad-hoc builds

---

## 3. Privacy Policy

Apple requires a privacy policy URL for every app. Non-negotiable.

- [ ] Privacy policy hosted on your website (not a Google Doc)
- [ ] Must be accessible without authentication
- [ ] Must clearly state:
  - What data you collect
  - How you use it
  - Who you share it with
  - How users can request deletion
  - How to contact you
- [ ] URL entered in App Store Connect under "App Privacy"
- [ ] Keep it updated when your data practices change

---

## 4. App Store Screenshots

### Required Sizes

| Device | Size (pixels) | Required |
|---|---|---|
| iPhone 6.7" (iPhone 15 Pro Max) | 1290 x 2796 | Yes |
| iPhone 6.5" (iPhone 14 Plus) | 1284 x 2778 | Yes (or 6.7") |
| iPhone 5.5" (iPhone 8 Plus) | 1242 x 2208 | If supporting older devices |
| iPad Pro 12.9" (6th gen) | 2048 x 2732 | If iPad app |
| iPad Pro 12.9" (2nd gen) | 2048 x 2732 | If supporting older iPads |

### Screenshot Guidelines

- [ ] Minimum 3 screenshots, maximum 10 per device size
- [ ] First 3 screenshots are most important (visible without scrolling)
- [ ] Show actual app UI, not just marketing graphics
- [ ] You can overlay text captions to highlight features
- [ ] No iPhone bezels required (Apple adds them in the listing)
- [ ] Screenshots must reflect current app functionality
- [ ] Do not include status bar content that could confuse (fake carrier names, etc.)

### Tips

- Use a tool like Fastlane Frameit, Previewed.app, or AppMockUp for consistent framing
- Create a screenshot template so you can regenerate quickly when your UI changes
- Localize screenshots for each language you support

---

## 5. App Store Description

### Structure Template

```
[One-line hook: what the app does and for whom]

[2-3 sentences expanding on the core value proposition]

KEY FEATURES:
- Feature 1: Brief description
- Feature 2: Brief description
- Feature 3: Brief description
- Feature 4: Brief description
- Feature 5: Brief description

[Social proof or awards if applicable]

[Subscription/pricing information if applicable - required by Apple]

[Link to terms and privacy policy]
```

### Requirements

- [ ] Maximum 4000 characters
- [ ] No competitor names
- [ ] No pricing that could become stale (or keep it updated)
- [ ] Include subscription details if auto-renewable
- [ ] Plain text only (no HTML, markdown, or special formatting)
- [ ] Proofread. Typos are a bad look.

---

## 6. Keywords Strategy

You get 100 characters for keywords in App Store Connect. Make them count.

- [ ] Research keywords using App Store search suggestions
- [ ] Use tools like AppTweak, Sensor Tower, or AppFollow for keyword research
- [ ] Separate keywords with commas, no spaces after commas
- [ ] Do not repeat words already in your app name or subtitle
- [ ] Use singular forms (Apple handles plural matching)
- [ ] Mix broad and specific terms
- [ ] Update keywords based on performance data quarterly

---

## 7. In-App Purchase Configuration

### If Your App Has Purchases

- [ ] Configure products in App Store Connect (subscriptions, consumables, non-consumables)
- [ ] Implement StoreKit 2 (recommended) or original StoreKit
- [ ] Handle purchase verification server-side
- [ ] Implement restore purchases functionality (required)
- [ ] Test in sandbox environment before submission
- [ ] Create subscription group if offering multiple tiers

### If Your App Does NOT Have In-App Purchases

- [ ] If your SaaS has a web-based subscription, you can link to your website for payment
- [ ] Apple currently allows "reader" apps and certain categories to bypass IAP
- [ ] Document your exemption reasoning in case of review questions
- [ ] Do not mention pricing or purchases in-app if not going through IAP
- [ ] Stay current on Apple's External Purchase Link entitlement rules (evolving)

---

## 8. Privacy Nutrition Labels

Apple requires you to declare your data practices upfront. Users see this on your App Store listing before downloading.

### Data Categories to Review

For each type of data, declare whether you collect it and for what purpose:

- [ ] **Contact Info**: Name, email, phone, address
- [ ] **Health & Fitness**: If applicable
- [ ] **Financial Info**: Payment info, credit score
- [ ] **Location**: Precise or coarse location
- [ ] **Sensitive Info**: Religious, political, sexual orientation data
- [ ] **Contacts**: Address book data
- [ ] **User Content**: Photos, videos, documents, files
- [ ] **Browsing History**: Web browsing in your app
- [ ] **Search History**: In-app search queries
- [ ] **Identifiers**: User ID, device ID
- [ ] **Usage Data**: Product interaction, advertising data
- [ ] **Diagnostics**: Crash data, performance data

### For Each Collected Data Type

Specify:
- [ ] Whether it is linked to the user's identity
- [ ] Whether it is used for tracking (cross-company)
- [ ] Purpose: Analytics, product personalization, app functionality, etc.

**Be accurate.** Apple audits these declarations and rejects apps with mismatches.

---

## 9. App Review Guidelines Compliance

The most common reasons for rejection. Check these before submitting.

- [ ] App provides value beyond a wrapper around a website
- [ ] Login works reliably (provide demo account for reviewers if needed)
- [ ] No crashes on launch or during core flows
- [ ] All links in the app work (no dead links)
- [ ] "Sign in with Apple" implemented if you offer other social logins
- [ ] Camera, microphone, location permissions have clear usage descriptions
- [ ] No placeholder content or "coming soon" sections
- [ ] No references to other mobile platforms ("also available on Android")
- [ ] Subscription terms clearly displayed before purchase
- [ ] Metadata matches app functionality (do not oversell in description)

### Provide Review Notes

- [ ] Include a demo account (email + password) in App Review notes
- [ ] Explain any features that require special setup to test
- [ ] If your app requires hardware or specific conditions, explain how to test
- [ ] Be polite and thorough in your review notes -- reviewers are human

---

## 10. TestFlight Beta Testing

### Setup

- [ ] Archive your app in Xcode and upload to App Store Connect
- [ ] Create a beta group in TestFlight
- [ ] Add internal testers (up to 100, your team, no review needed)
- [ ] Add external testers (up to 10,000, requires Beta App Review)
- [ ] Write TestFlight description and "What to Test" notes

### Beta Testing Process

- [ ] Test on multiple device sizes (iPhone SE through Pro Max)
- [ ] Test on oldest supported iOS version
- [ ] Test with poor network connectivity
- [ ] Test push notifications
- [ ] Test all IAP flows in sandbox
- [ ] Collect crash reports from TestFlight
- [ ] Fix all critical issues before App Store submission

---

## 11. Launch Day Submission

### Pre-Submission Checklist

- [ ] All screenshots uploaded for all required device sizes
- [ ] App description, keywords, and metadata finalized
- [ ] Privacy policy URL is live and accessible
- [ ] Privacy nutrition labels completed accurately
- [ ] App icon meets specifications (1024x1024, no alpha channel)
- [ ] Build uploaded via Xcode or CI/CD
- [ ] Build selected in App Store Connect
- [ ] Review notes and demo credentials provided
- [ ] Contact info for App Review team is current
- [ ] Support URL is live and accessible
- [ ] Marketing URL is live (optional but recommended)

### Submission

- [ ] Click "Submit for Review" in App Store Connect
- [ ] Typical review time: 24-48 hours (can be longer)
- [ ] Monitor for "Rejected" status or "Developer Action Needed"
- [ ] If rejected, read the resolution center feedback carefully before responding
- [ ] You can request an expedited review if you have a critical bug fix

---

## 12. Post-Launch Monitoring

- [ ] Monitor crash reports in App Store Connect and your error tracking tool
- [ ] Monitor App Store reviews and ratings daily for the first week
- [ ] Respond to negative reviews constructively and promptly
- [ ] Watch for any App Review follow-ups or compliance issues
- [ ] Monitor download and revenue metrics
- [ ] Plan your first update (bug fixes based on real-world usage)

---

## 13. Common Rejection Reasons and How to Avoid Them

| Rejection Reason | How to Avoid |
|---|---|
| Crashes during review | Test on a clean install, multiple devices |
| Broken login | Provide working demo credentials in review notes |
| Missing "Sign in with Apple" | Required if you offer any social login |
| Incomplete metadata | Fill every field, upload all screenshot sizes |
| App is a glorified website | Add native features: push, offline, haptics |
| Privacy policy missing or inaccessible | Host it on your domain, test the URL |
| Misleading description | Only describe features that exist right now |
| Guideline 4.3 (spam/copycat) | Make your app clearly distinct and valuable |
| IAP issues | Test restore, handle all StoreKit states |
| Performance (slow, unresponsive) | Profile and optimize before submission |

---

*Apple's review process is strict but predictable. Follow their guidelines, be thorough in your submission, and be responsive if they have questions. Most rejections are fixable within a day.*
