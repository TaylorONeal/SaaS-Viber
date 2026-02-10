# App Store Submission Guide

> Template for preparing and submitting your SaaS mobile application to the
> iOS App Store and Google Play Store.

---

## Pre-Submission Checklist

Before starting the submission process, verify:

- [ ] App functions correctly on all target devices
- [ ] All placeholder content has been replaced with real content
- [ ] Privacy policy URL is live and accessible
- [ ] Terms of service URL is live and accessible
- [ ] Support URL or email is working
- [ ] App icons in all required sizes
- [ ] Screenshots for all required device sizes
- [ ] App description and metadata finalized
- [ ] In-app purchases configured and tested (if applicable)
- [ ] Push notification entitlements configured (if applicable)
- [ ] Deep links and universal links tested
- [ ] Analytics and crash reporting integrated
- [ ] Performance tested (startup time, memory usage)

---

## iOS App Store Submission

### 1. Apple Developer Account Setup

- Enroll in the Apple Developer Program ($99/year)
- Create an App ID in the developer portal
- Configure capabilities (push notifications, sign in with Apple, etc.)
- Create provisioning profiles for distribution

### 2. App Store Connect Configuration

| Field | Requirement | Notes |
|-------|-------------|-------|
| App name | 30 characters max | Must be unique on the App Store |
| Subtitle | 30 characters max | Brief descriptor |
| Bundle ID | Reverse domain (com.company.app) | Cannot change after submission |
| SKU | Internal reference | Your choice, not shown to users |
| Primary language | Select one | Other languages via localization |
| Category | Select primary + optional secondary | Choose carefully for discoverability |
| Content rights | Declare if using third-party content | Required disclosure |
| Age rating | Complete questionnaire | Determines age restriction |

### 3. App Information

| Field | Max Length | Tips |
|-------|-----------|------|
| Description | 4,000 chars | First 3 lines visible without "more". Lead with value prop. |
| Keywords | 100 chars | Comma-separated. No spaces after commas. No duplicates of app name. |
| What's New | 4,000 chars | Bullet point format. Highlight key changes. |
| Promotional Text | 170 chars | Can be updated without a new binary. |
| Support URL | Valid URL | Link to your help center or support page. |
| Marketing URL | Valid URL | Link to your website landing page. |
| Privacy Policy URL | Valid URL | Required for all apps. |

### 4. Screenshot Requirements (iOS)

| Device | Size (pixels) | Required |
|--------|--------------|----------|
| iPhone 6.7" (15 Pro Max) | 1290 x 2796 | Yes |
| iPhone 6.5" (11 Pro Max) | 1242 x 2688 | Yes |
| iPhone 5.5" (8 Plus) | 1242 x 2208 | If supporting |
| iPad Pro 12.9" (6th gen) | 2048 x 2732 | If iPad app |
| iPad Pro 12.9" (2nd gen) | 2048 x 2732 | If supporting older |

- Minimum 3 screenshots, maximum 10 per device size
- Can include app preview videos (15-30 seconds)
- Screenshots should show real app content (no placeholder data)

### 5. Review Guidelines to Watch

- **Subscriptions:** Must clearly display pricing, trial terms, and renewal info
- **Sign in with Apple:** Required if you offer any third-party social login
- **Privacy:** Must include a privacy nutrition label
- **Account deletion:** Must provide a way for users to delete their account
- **External payments:** Cannot direct users to external payment methods for digital goods

### 6. Submission Process

1. Archive build in Xcode (or build via CI/CD)
2. Upload to App Store Connect via Xcode or Transporter
3. Wait for build processing (15-60 minutes)
4. Select the build in App Store Connect
5. Fill in all required metadata and screenshots
6. Submit for review
7. Review typically takes 24-48 hours (can take up to 7 days)

---

## Google Play Store Submission

### 1. Google Play Console Setup

- Create a Google Play Developer account ($25 one-time fee)
- Create a new application
- Complete the app content questionnaire
- Set up a closed testing track first (recommended)

### 2. Store Listing

| Field | Max Length | Notes |
|-------|-----------|-------|
| App name | 30 chars | Shown in search results |
| Short description | 80 chars | Shown on store listing |
| Full description | 4,000 chars | Supports basic formatting |
| App icon | 512 x 512 PNG | 32-bit with alpha channel |
| Feature graphic | 1024 x 500 | Required. Shown at top of listing. |
| Phone screenshots | Min 2, max 8 | 16:9 or 9:16 aspect ratio |
| Tablet screenshots | Min 2, max 8 | Required if supporting tablets |

### 3. Screenshot Requirements (Android)

| Type | Size | Required |
|------|------|----------|
| Phone | Min 320px, max 3840px (any side) | Yes (min 2) |
| 7-inch tablet | Same constraints | If targeting tablets |
| 10-inch tablet | Same constraints | If targeting tablets |
| Chromebook | Same constraints | If targeting Chromebook |

- Aspect ratio between 16:9 and 9:16
- PNG or JPEG, max 8MB per screenshot

### 4. Content Rating

Complete the IARC content rating questionnaire:
- Answer honestly about violence, sexuality, language, etc.
- Most SaaS apps will receive "Everyone" or "Everyone 10+"
- Incorrect rating can lead to removal

### 5. Data Safety Section

Declare for each data type your app collects:
- What data is collected
- Whether it is shared with third parties
- Whether it is encrypted in transit
- Whether users can request deletion
- Whether data collection is required or optional

### 6. Release Process

1. Build signed AAB (Android App Bundle)
2. Upload to Google Play Console
3. Select a release track (internal, closed, open, production)
4. Fill in release notes
5. Review rolls out progressively (typically 1-7 days for new apps)

---

## Common Requirements (Both Platforms)

### Asset Requirements

| Asset | iOS | Android |
|-------|-----|---------|
| App icon | 1024 x 1024 PNG (no alpha) | 512 x 512 PNG (with alpha) |
| Screenshots | Device-specific sizes | Flexible aspect ratios |
| Feature graphic | Not applicable | 1024 x 500 |
| Promo video | App preview (optional) | YouTube link (optional) |

### Content Requirements

- Privacy policy (required by both)
- Terms of service (required for in-app purchases)
- Support contact (email or URL)
- COPPA compliance declaration (if any chance of child users)
- GDPR compliance (if serving EU users)

---

## Review Preparation Checklist

### Before Every Submission

- [ ] Test on physical devices (not just simulators)
- [ ] All API endpoints are pointing to production
- [ ] No debug menus or test buttons visible
- [ ] Crash reporting shows no critical crashes
- [ ] Deep links resolve correctly
- [ ] Push notifications work end-to-end
- [ ] In-app purchases complete successfully
- [ ] Login/logout/registration flows work
- [ ] Offline behavior is graceful
- [ ] Permission requests have clear explanations
- [ ] All text is properly localized (if multilingual)
- [ ] Screenshots match current app appearance
- [ ] App description accurately reflects current functionality

### Rejection Recovery

If your app is rejected:
1. Read the rejection reason carefully
2. Fix the specific issue cited
3. Respond in the Resolution Center (iOS) or appeal (Android)
4. Resubmit with detailed notes about what was fixed
5. Common reasons: metadata issues, payment guideline violations, missing privacy info
