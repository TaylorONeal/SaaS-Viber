# Screenshot Requirements and Guidelines

> How to create, manage, and optimize app store screenshots for your SaaS
> mobile application.

---

## Required Sizes

### iOS Screenshot Sizes

| Device | Resolution (px) | Display Size | Required? |
|--------|-----------------|-------------|-----------|
| iPhone 6.7" (15 Pro Max, 14 Pro Max) | 1290 x 2796 | Super Retina XDR | Yes |
| iPhone 6.5" (11 Pro Max, XS Max) | 1242 x 2688 | Super Retina | Yes |
| iPhone 5.5" (8 Plus, 7 Plus) | 1242 x 2208 | Retina HD | If supporting |
| iPad Pro 12.9" (6th gen) | 2048 x 2732 | Liquid Retina XDR | If iPad app |
| iPad Pro 12.9" (2nd gen) | 2048 x 2732 | Retina | If supporting older |

**Per device size:** Minimum 3 screenshots, maximum 10.

### Android Screenshot Sizes

| Type | Min Resolution | Max Resolution | Aspect Ratio |
|------|---------------|----------------|--------------|
| Phone | 320px (short side) | 3840px (any side) | 16:9 to 9:16 |
| 7" Tablet | 320px (short side) | 3840px (any side) | 16:9 to 9:16 |
| 10" Tablet | 320px (short side) | 3840px (any side) | 16:9 to 9:16 |
| Chromebook | 320px (short side) | 3840px (any side) | 16:9 to 9:16 |

**Per device type:** Minimum 2 screenshots, maximum 8.

### Recommended Sizes for Simplicity

If maintaining many sizes is impractical, focus on these:

| Platform | Size | Covers |
|----------|------|--------|
| iOS | 1290 x 2796 | 6.7" iPhones (can be scaled for others) |
| iOS | 2048 x 2732 | iPads (if applicable) |
| Android | 1080 x 1920 | Standard phones |
| Android | 1200 x 1920 | Tablets (if applicable) |

---

## Tools for Generating Screenshots

### Design Tools

| Tool | Type | Best For | Price |
|------|------|----------|-------|
| **Figma** | Design | Custom frames, team collaboration | Free tier available |
| **Sketch** | Design | macOS users, existing templates | $120/year |
| **Canva** | Design | Quick, non-technical users | Free tier available |

### Screenshot-Specific Tools

| Tool | Platform | Features | Price |
|------|----------|----------|-------|
| **Screenshots.pro** | Web | Device frames, bulk export | Free tier |
| **LaunchMatic** | Web | AI-generated screenshots | Paid |
| **AppMockUp** | Web | Device mockups, backgrounds | Free tier |
| **Fastlane Screengrab** | CLI (Android) | Automated capture | Free (open source) |
| **Fastlane Snapshot** | CLI (iOS) | Automated capture | Free (open source) |

### Automated Screenshot Generation

For consistent, repeatable screenshots, use Fastlane:

```bash
# iOS automated screenshots
fastlane snapshot

# Android automated screenshots
fastlane screengrab
```

This runs your app in a simulator/emulator, navigates to key screens,
and captures screenshots in all required sizes and languages.

---

## Best Practices

### Content Strategy

1. **Lead with your strongest screen** -- the first screenshot gets the most views
2. **Show the value, not the login screen** -- demonstrate what users will get
3. **Use real data** -- placeholder content looks unprofessional
4. **Tell a story** -- screenshots should flow logically from left to right
5. **Highlight differentiators** -- show what makes your app unique

### Recommended Screenshot Sequence (5-6 Screenshots)

| Position | Content | Purpose |
|----------|---------|---------|
| 1 | Hero feature / main dashboard | First impression, value prop |
| 2 | Key feature A | Core functionality |
| 3 | Key feature B | Second major benefit |
| 4 | Key feature C or unique differentiator | Stand out from competitors |
| 5 | Social proof / results | Build trust |
| 6 | Settings / customization | Show flexibility (optional) |

### Visual Design

- **Add captions** -- 3-5 word text above or below the device frame
- **Use your brand colors** -- consistent with your app and website
- **Device frames are optional** -- Apple allows both framed and unframed
- **Keep backgrounds simple** -- solid color or subtle gradient
- **Ensure text is readable** -- minimum 30px font size at display resolution
- **Maintain consistency** -- same style, fonts, and colors across all screenshots

### What to Avoid

- Login or splash screens as the first screenshot
- Screens with error states or empty states
- Overly cluttered screens with too much information
- Tiny text that cannot be read at thumbnail size
- Screenshots that do not match current app version
- Fake reviews or ratings in screenshots (violates guidelines)
- Competitor names or logos

---

## File Organization

Store screenshot source files and exports in this directory:

```
docs/app-store/screenshots/
  README.md                    -- This file
  source/                      -- Figma exports or design source files
    ios-6.7/                   -- iPhone 6.7" screenshots
    ios-6.5/                   -- iPhone 6.5" screenshots
    android-phone/             -- Android phone screenshots
    android-tablet/            -- Android tablet screenshots (if applicable)
  exports/                     -- Final exported files ready for upload
    ios/
    android/
```

### Naming Convention

```
[position]-[screen-name]-[language].[extension]

Examples:
01-dashboard-en.png
02-analytics-en.png
03-settings-en.png
01-dashboard-es.png  (Spanish localization)
```

---

## Localization

If your app supports multiple languages:

- Translate all caption text in screenshots
- Show localized UI in screenshots for each language
- Fastlane can automate multi-language screenshot capture
- Prioritize languages with the most users

| Priority | Languages | Coverage |
|----------|-----------|----------|
| Tier 1 | English | Global baseline |
| Tier 2 | Spanish, Portuguese, French, German | Major Western markets |
| Tier 3 | Japanese, Korean, Chinese (Simplified) | Major Asian markets |
| Tier 4 | All others | Based on your user demographics |

---

## Update Schedule

- Update screenshots with every major UI change
- Refresh at least once per quarter to stay current
- Seasonal or promotional screenshots can boost conversions
- A/B test different screenshot sets if the store supports it (Google Play)
