# App Store Compliance — [YOUR_APP_NAME]

> **Purpose:** Checklist and reference for meeting the requirements of the Apple App Store
> (iOS) and Google Play Store (Android) if you plan to publish mobile apps.
>
> **Last Updated:** [DATE]
> **Status:** [Template / In Progress / Complete]
> **Platforms:** [iOS / Android / Both / N/A]

---

## iOS App Store Requirements

### App Review Guidelines Summary

| Category | Requirement | Status | Notes |
|---|---|---|---|
| **Safety** | | | |
| Objectionable Content | No offensive, insensitive, or harmful content | [ ] | Review all user-generated content moderation |
| User-Generated Content | Must include: reporting, blocking, filtering, moderation | [ ] | Required if users can post content visible to others |
| Physical Harm | No features encouraging dangerous behavior | [ ] | — |
| **Performance** | | | |
| Completeness | App must be fully functional at review time | [ ] | No "coming soon" features or broken links |
| Beta Testing | Use TestFlight, not the App Store | [ ] | — |
| Metadata | Accurate descriptions, screenshots match actual app | [ ] | Update with every version |
| Hardware Compatibility | Must work on current devices without modification | [ ] | Test on multiple screen sizes |
| **Business** | | | |
| In-App Purchases | Digital goods/services MUST use IAP (Apple takes 15-30%) | [ ] | See SaaS exemption below |
| SaaS Exemption | Multiplatform SaaS can use external billing (Reader App rules) | [ ] | Must also work on non-Apple platforms |
| Subscriptions | Auto-renewable subscriptions must follow Apple guidelines | [ ] | Clear pricing, trial terms, cancellation |
| Free Trials | Must clearly state duration and post-trial pricing | [ ] | — |
| **Design** | | | |
| Minimum Functionality | Must provide value beyond a repackaged website | [ ] | App must justify its existence as native |
| UI Design | Follow Human Interface Guidelines (HIG) | [ ] | Use native UI patterns where expected |
| App Icons | Follow size/format requirements | [ ] | 1024x1024 required for submission |
| Launch Screen | Required; must not be used as advertising | [ ] | — |
| **Legal** | | | |
| Privacy Policy | Must be accessible from App Store and within app | [ ] | Link in app and in App Store Connect |
| Data Collection Disclosure | App Privacy "nutrition labels" must be accurate | [ ] | List all data types collected |
| Tracking Transparency | Must use ATT framework if tracking users | [ ] | `AppTrackingTransparency` prompt |
| Terms of Service | Must be accessible | [ ] | — |
| EULA | Apple's standard EULA or your custom one | [ ] | Custom EULA if needed |

### SaaS / "Reader App" Exemption Details

If [YOUR_APP_NAME] qualifies as a **multiplatform SaaS**:
- You **may** use external payment processing (Stripe, etc.) instead of Apple IAP
- Your app must also be available on **non-Apple platforms** (web, Android)
- You **may** link to your website for account management and billing
- You **cannot** include in-app purchase buttons or prompts that bypass Apple IAP for non-exempt digital goods
- **Apply for the exemption** via App Store Connect if applicable

### iOS Technical Requirements

- [ ] Minimum deployment target: iOS [VERSION] (check current minimum)
- [ ] Support for current and previous iPhone screen sizes
- [ ] Support for iPad if applicable (or mark as iPhone-only)
- [ ] Dark mode support (strongly recommended)
- [ ] Dynamic Type support (accessibility)
- [ ] IPv6 networking support (required)
- [ ] HTTPS for all network connections (ATS compliance)
- [ ] No private API usage

---

## Google Play Store Requirements

### Policy Compliance

| Category | Requirement | Status | Notes |
|---|---|---|---|
| **Content** | | | |
| Content Rating | IARC rating questionnaire completed | [ ] | Required before publishing |
| User-Generated Content | Moderation, reporting, and blocking required | [ ] | If users can share content |
| Restricted Content | Comply with country-specific restrictions | [ ] | Varies by target market |
| **Privacy & Security** | | | |
| Privacy Policy | Required; accessible from Play Store and in-app | [ ] | Must detail all data collection |
| Data Safety Section | Accurate declaration of data types collected | [ ] | Play Console Data Safety form |
| Permissions | Request only necessary permissions with justification | [ ] | Explain each permission request |
| Data Encryption | Sensitive data must be encrypted | [ ] | In transit and at rest |
| **Billing** | | | |
| Google Play Billing | Digital goods/services MUST use Play Billing (15-30%) | [ ] | Similar to Apple IAP rules |
| SaaS Exemption | Multiplatform SaaS may qualify for exemption | [ ] | Check current Google policies |
| Subscriptions | Follow Google subscription policies | [ ] | Clear terms, easy cancellation |
| **Functionality** | | | |
| Core Functionality | App must work without requiring payment to function | [ ] | Free tier or trial required |
| Background Services | Declare foreground services with proper notifications | [ ] | Android-specific requirement |
| Target API Level | Must target recent Android API level | [ ] | Updated annually |
| **Store Listing** | | | |
| Screenshots | Min 2, max 8 per device type | [ ] | Accurate representation of app |
| Feature Graphic | 1024x500 required | [ ] | Used in Play Store listings |
| Short Description | Max 80 characters | [ ] | — |
| Full Description | Max 4000 characters | [ ] | — |

### Google Play Technical Requirements

- [ ] Target SDK version: API level [X]+ (check current requirement)
- [ ] 64-bit architecture support required
- [ ] Android App Bundle format (not APK) for new apps
- [ ] Adaptive icons supported
- [ ] Material Design guidelines followed (recommended)
- [ ] Splash screen API used (Android 12+)
- [ ] Foreground service types declared (if applicable)
- [ ] Backup rules configured

---

## Privacy Policy Requirements (Both Platforms)

Your privacy policy must address:

- [ ] **What data is collected** (enumerate specific types)
- [ ] **How data is used** (processing purposes)
- [ ] **Who data is shared with** (third parties, analytics, etc.)
- [ ] **How data is stored** (encryption, location, retention)
- [ ] **User rights** (access, deletion, portability, opt-out)
- [ ] **Children's data** (COPPA compliance if applicable)
- [ ] **Contact information** for privacy inquiries
- [ ] **Last updated date**
- [ ] **Cookie/tracking policy** (if using web views)

### Privacy Policy Locations

| Platform | Location | Requirement |
|---|---|---|
| iOS | App Store Connect metadata | Required URL |
| iOS | In-app (Settings or About) | Must be accessible |
| Android | Google Play Console | Required URL |
| Android | In-app (Settings or About) | Must be accessible |
| Web | Footer of marketing site | Required |
| Web | Footer of application | Required |

---

## Content Rating

### IARC (International Age Rating Coalition)

Both App Store and Play Store use IARC-based questionnaires.

| Factor | Your App | Notes |
|---|---|---|
| Violence | [None / Mild / Moderate / Intense] | [Describe if applicable] |
| Sexuality | [None / Mild / Suggestive] | [Describe if applicable] |
| Language | [None / Mild / Strong] | [User-generated content may elevate this] |
| Drugs / Alcohol / Tobacco | [None / Reference / Use] | — |
| Gambling | [None / Simulated / Real Money] | — |
| User Interaction | [None / Unrestricted] | [If users can communicate] |
| Data Sharing | [None / Personal Info Shared] | [Based on privacy policy] |

**Expected Rating:** [Everyone / Teen / Mature / etc.]

---

## Accessibility Requirements

> Both platforms strongly recommend accessibility support.

### iOS Accessibility
- [ ] VoiceOver support (all UI elements have accessibility labels)
- [ ] Dynamic Type support (text scales with system settings)
- [ ] Sufficient color contrast (4.5:1 minimum)
- [ ] Touch targets minimum 44x44 points
- [ ] Reduce Motion support (`UIAccessibility.isReduceMotionEnabled`)
- [ ] Bold Text support

### Android Accessibility
- [ ] TalkBack support (content descriptions on all UI elements)
- [ ] Font scaling support (sp units for text)
- [ ] Sufficient color contrast (4.5:1 minimum)
- [ ] Touch targets minimum 48x48 dp
- [ ] Navigation without gestures (keyboard/switch access)
- [ ] Screen reader traversal order logical

### Cross-Platform Accessibility (React Native / Flutter)
- [ ] All interactive elements have `accessibilityLabel` / `semanticsLabel`
- [ ] Images have alt text
- [ ] Forms have associated labels
- [ ] Error messages announced to screen readers
- [ ] Focus management on navigation
- [ ] Tested with native screen readers (VoiceOver and TalkBack)

---

## Submission Checklist

### Pre-Submission (Both Platforms)
- [ ] Privacy policy URL live and accessible
- [ ] All features functional (no placeholder screens)
- [ ] App tested on multiple device sizes
- [ ] Accessibility audit completed
- [ ] Content rating questionnaire completed
- [ ] Screenshots captured and uploaded
- [ ] App description written and reviewed
- [ ] Version number and release notes prepared

### iOS-Specific
- [ ] App Store Connect entry created
- [ ] App icons (all sizes) uploaded
- [ ] App Privacy details completed
- [ ] In-App Purchase products configured (if applicable)
- [ ] TestFlight testing completed
- [ ] Review notes provided (login credentials, special instructions)

### Android-Specific
- [ ] Google Play Console entry created
- [ ] Data Safety form completed
- [ ] App signing configured (Play App Signing)
- [ ] Internal/closed testing track used before production
- [ ] Target API level meets current requirement
- [ ] App bundle uploaded (not APK)

---

## Common Rejection Reasons

| Reason | Platform | How to Avoid |
|---|---|---|
| Incomplete functionality | Both | Remove or hide unfinished features |
| Inaccurate screenshots | Both | Retake screenshots before every submission |
| Missing privacy policy | Both | Ensure URL is live and linked in app |
| Using external payments for digital goods | Both | Use IAP / Play Billing unless exemption applies |
| Requesting unnecessary permissions | Android | Audit permissions; justify each one |
| Crash during review | Both | Test thoroughly on clean install |
| Login issues | Both | Provide demo credentials in review notes |
| WebView wrapper (no native value) | iOS | Add native features beyond web content |

---

## Prompt Guide Reference

See [PromptGuide-Architecture.md](./PromptGuide-Architecture.md) for prompts related to mobile architecture and compliance review.

---

*Status: Template*
*Next review: [DATE]*
