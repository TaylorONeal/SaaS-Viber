# Android Launch Readiness Checklist

Everything required to publish your app on the Google Play Store. Google's review process is generally faster and less strict than Apple's, but there are still requirements you must meet.

---

## 1. Google Play Developer Account

- [ ] Create account at https://play.google.com/console ($25 one-time fee)
- [ ] Use an organizational account if possible (not a personal Gmail)
- [ ] Complete identity verification (government ID, required since 2023)
- [ ] Set up a Google Cloud project for Play Developer API access (optional, for CI/CD)
- [ ] Add team members with appropriate roles (if applicable)

**Note**: New developer accounts have a "testing period" -- you must run a closed test with at least 20 testers for 14+ days before you can publish to production. Plan for this.

---

## 2. App Signing

### Play App Signing (Required)

Google manages your app signing key. You upload an upload key; Google re-signs with the production key.

- [ ] Generate an upload key (or let Android Studio create one)
- [ ] Enroll in Play App Signing when creating your app in Play Console
- [ ] Store your upload keystore file securely (if lost, you can request a reset but it takes time)
- [ ] Document your keystore password and alias in a secure vault
- [ ] Set up signing configuration in your build system (Gradle, Fastlane, etc.)

### For CI/CD

- [ ] Store keystore and credentials as encrypted secrets in your CI system
- [ ] Never commit keystores to version control
- [ ] Automate the signing and upload process

---

## 3. Privacy Policy

Required for all apps that access user data (which is essentially all apps).

- [ ] Privacy policy hosted on your website (publicly accessible URL)
- [ ] Must cover:
  - Types of data collected
  - How data is used
  - Data sharing practices
  - Data retention and deletion
  - How users can contact you
- [ ] URL added in Play Console under "App content > Privacy policy"
- [ ] Policy must be accessible without login
- [ ] Keep updated when data practices change

---

## 4. Store Listing

### App Details

- [ ] **App name**: Up to 30 characters (make it searchable)
- [ ] **Short description**: Up to 80 characters (appears in search results)
- [ ] **Full description**: Up to 4000 characters (detailed feature list, value prop)
- [ ] **App category**: Choose the most accurate primary category
- [ ] **Contact email**: Required, publicly visible
- [ ] **Website URL**: Your marketing site

### Screenshots

| Type | Size | Required |
|---|---|---|
| Phone screenshots | 16:9 or 9:16, min 320px, max 3840px | Yes (2-8) |
| 7" tablet screenshots | Same range | If targeting tablets |
| 10" tablet screenshots | Same range | If targeting tablets |

- [ ] Minimum 2 phone screenshots, maximum 8
- [ ] Show actual app functionality (not just marketing graphics)
- [ ] First 2-3 screenshots are most visible -- make them count
- [ ] Localize screenshots per language if supporting multiple locales

### Feature Graphic

- [ ] **Required**: 1024 x 500 pixels
- [ ] Used as the banner at the top of your listing
- [ ] Should communicate what your app does at a glance
- [ ] No excessive text (it will be small on some screens)

### App Icon

- [ ] 512 x 512 pixels, PNG, 32-bit with alpha
- [ ] No badges or overlaid text
- [ ] Should be recognizable at small sizes
- [ ] Follows Google's adaptive icon guidelines for in-app icon

### Optional Assets

- [ ] Promo video (YouTube URL, auto-plays in listing)
- [ ] TV banner (if targeting Android TV)
- [ ] Wear OS screenshots (if targeting Wear OS)

---

## 5. Content Rating Questionnaire

Required before you can publish. Google uses the IARC system.

- [ ] Complete the content rating questionnaire in Play Console
- [ ] Answer honestly about:
  - Violence (none, cartoon, realistic)
  - Sexual content
  - Language (profanity)
  - Controlled substances
  - User-generated content
  - Data sharing
- [ ] Ratings are generated automatically based on your answers
- [ ] Update ratings if your content changes significantly

**Tip**: Most SaaS apps end up with an "Everyone" or "Everyone 10+" rating. If you allow user-generated content, your rating may be higher.

---

## 6. Target API Level Requirements

Google requires targeting recent Android API levels. This changes yearly.

- [ ] Check current requirement at https://developer.android.com/google/play/requirements/target-sdk
- [ ] As of 2025: new apps must target API level 34+ (Android 14)
- [ ] Updates to existing apps must also meet the current target requirement
- [ ] Set `targetSdkVersion` in your `build.gradle`
- [ ] Test your app on the target API level before submission
- [ ] Review behavior changes for the target API level

### Minimum SDK

- [ ] Set a reasonable `minSdkVersion` (API 24 / Android 7.0 covers 95%+ of active devices)
- [ ] Test on the minimum SDK version you declare

---

## 7. In-App Billing Setup

### If Your App Has Purchases

- [ ] Set up Google Play Billing Library (version 6+ recommended)
- [ ] Create products in Play Console:
  - Subscriptions (auto-renewable)
  - One-time products (consumable or non-consumable)
- [ ] Implement purchase flow with proper error handling
- [ ] Implement subscription status checking
- [ ] Handle grace periods and account hold
- [ ] Implement restore/acknowledge purchases
- [ ] Test using license test accounts in Play Console
- [ ] Verify purchases server-side using Google Play Developer API

### Server-Side Verification

- [ ] Set up Real-time Developer Notifications (RTDN) via Pub/Sub
- [ ] Handle subscription state changes (renewed, canceled, paused, on hold)
- [ ] Implement dunning for payment failures

### If Using Web-Based Payments

- [ ] Google generally requires Play Billing for digital goods
- [ ] Physical goods and services can use external payment
- [ ] "Reader" apps may qualify for alternative billing (check current policy)
- [ ] Document your reasoning if not using Play Billing

---

## 8. Testing Tracks

Google Play offers multiple testing tracks. Use them.

### Internal Testing (up to 100 testers)

- [ ] Create internal test track
- [ ] Upload your first build here
- [ ] Add testers by email
- [ ] No review required, available within minutes
- [ ] Use for quick iteration and team testing

### Closed Testing (up to 10,000 testers)

- [ ] Create closed test track
- [ ] Add testers by email or Google Group
- [ ] **Required**: 20+ testers for 14+ consecutive days before first production release
- [ ] Monitor crash rates and ANR rates
- [ ] Collect feedback via Play Console or your own channels

### Open Testing

- [ ] Available to anyone who finds your listing (marked as "Early access")
- [ ] Good for wider beta testing before full launch
- [ ] Users can opt in from your Play Store listing

### Production

- [ ] Only release to production after thorough testing
- [ ] Use staged rollouts (start at 10%, increase gradually)
- [ ] Monitor crash rates and user feedback at each stage

---

## 9. Release Management

### Pre-Release Checklist

- [ ] Version code incremented (integer, must always increase)
- [ ] Version name updated (user-facing, e.g., "1.2.0")
- [ ] Release notes written (shown to users in Play Store)
- [ ] APK or AAB signed with your upload key
- [ ] **Use AAB format** (Android App Bundle) -- required for new apps, smaller downloads

### Staged Rollouts

- [ ] Start production release at 10-20%
- [ ] Monitor for 24-48 hours
- [ ] Check crash-free rate (target: 99.5%+)
- [ ] Check ANR rate (target: under 0.47%)
- [ ] Increase to 50% if metrics are healthy
- [ ] Full rollout (100%) after 3-5 days if stable

### Rollback

- [ ] If critical issues are found, halt the rollout immediately
- [ ] You cannot truly "rollback" on Play Store -- you must upload a new build with fixes
- [ ] Have a hotfix branch strategy ready before launch
- [ ] Staged rollouts are your best protection against bad releases

---

## 10. Common Rejection Reasons

| Rejection Reason | How to Avoid |
|---|---|
| **Crashes / ANR** | Test on multiple devices and API levels |
| **Deceptive behavior** | Do what your listing says, nothing more |
| **Privacy policy missing** | Add it before submission |
| **Incomplete app content declarations** | Complete all sections under "App content" |
| **Impersonation** | Do not use another brand's name or logo |
| **Permissions not justified** | Only request permissions you actually use, explain why |
| **Ad policy violations** | Ads must be appropriate and not misleading |
| **Subscription issues** | Clearly show pricing, terms, and cancellation method |
| **User data policy** | Declare data usage in Data Safety section accurately |
| **Target API too low** | Meet the current year's target API requirement |

### Data Safety Section

This is Google's equivalent of Apple's nutrition labels.

- [ ] Complete the Data Safety form in Play Console
- [ ] Declare all data types collected (name, email, location, etc.)
- [ ] Declare whether data is shared with third parties
- [ ] Declare data encryption practices
- [ ] Declare data deletion policy
- [ ] Declare whether data collection is required or optional
- [ ] Must be consistent with your privacy policy

---

## 11. Post-Launch

### First Week

- [ ] Monitor crash-free rate daily (Play Console > Android Vitals)
- [ ] Monitor ANR rate daily
- [ ] Respond to all user reviews (especially negative ones)
- [ ] Watch for policy violation emails from Google
- [ ] Check install and uninstall rates

### Ongoing

- [ ] Keep target API level current (Google enforces annually)
- [ ] Update dependencies for security patches
- [ ] Monitor Android Vitals for performance regressions
- [ ] Release updates regularly (shows the app is maintained)
- [ ] Update screenshots and descriptions when UI changes
- [ ] Monitor competitor listings for inspiration and differentiation

### ASO (App Store Optimization)

- [ ] Track keyword rankings for your target search terms
- [ ] A/B test store listing (Google offers built-in experiments)
- [ ] Optimize short description for click-through rate
- [ ] Update screenshots to highlight newest features
- [ ] Encourage ratings from satisfied users (in-app prompt, post-positive-experience)

---

*Google's process is faster than Apple's but their policies are evolving quickly, especially around data safety and billing. Stay current with Google Play policy updates and give yourself buffer time for the mandatory closed testing period.*
