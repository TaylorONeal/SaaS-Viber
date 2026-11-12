# Screenshot Requirements and Guidelines

> How to create, manage, and optimize app store screenshots for your SaaS
> mobile application.

---

## Required Sizes

### iOS Screenshot Sizes

| Device | Resolution (px) | Display Size | Required? |
|--------|-----------------|-------------|-----------|
| iPhone 6.9" (16 Pro Max and later) | 1320 x 2868 | Super Retina XDR | Largest current size |
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

### Content Strategy: one job per frame

People scroll a listing in a second or two. They are asking "is this for me, and
will it fix my problem?", not "what features does it have?". Write each frame
from the user's side, as a job they want done and how it feels once it is done.

1. **Say who it is for first** -- if the app only helps a certain person (owners of
   a device, members of a service, a role at work), frame 1 says so in plain words.
   A listing that pulls in the wrong people earns installs that end in one-star
   reviews.
2. **One job per frame** -- the headline is the user's own words for the job
   ("Out of cards?") and the second line is the payoff ("Brewing again."). Name the
   situation and the feeling, not the screen ("Analytics dashboard").
3. **Show the solution, not the setting** -- the screen in the frame is the moment
   the job gets done: the result, the confirmation, the one tap.
4. **Show real data** -- placeholder content looks unprofessional.
5. **Read every headline at 30 percent size** -- that is roughly how big the frames
   are in search results.

### Recommended Screenshot Sequence (5-8 Screenshots)

| Position | Job it answers | Example headline |
|----------|----------------|------------------|
| 1 | Is this for me? | "Own a [device]? Keep it running." |
| 2 | The problem that brought them here, solved | "Out of X? Back to Y." (before and after) |
| 3 | The everyday job, made effortless | "Your usual. One tap." |
| 4 | The question that blocks them from starting | "Know exactly what to buy." |
| 5 | A job they did not know the app could do | "Set it tonight. Ready by morning." |
| 6 | Why to trust it | "Made by people like you." / "No account. No ads." |

### Visual Design: vary the layout, keep the palette

A set where every frame is the same tilted phone on a new colour reads as one
screenshot eight times. Keep the palette, fonts and voice consistent, and change the
composition from frame to frame:

- **Before and after split** -- the problem in muted colour above, the result in brand colour below
- **Straight phone with a giant breakout** -- the one control that does the job, enlarged
- **Object close-up, no phone** -- the physical thing, document or result the job is about
- **Scene** -- a time of day, a place, the moment of use
- **Type first** -- a short manifesto or a value the brand stands for, phone small or absent
- **Phone peeking in** -- off the edge, at an angle, as a supporting detail

Check the set as a strip: if two neighbouring frames share a composition, change one.
Captions stay large (30px at display resolution at the very least) and short.
Device frames are optional; Apple allows both framed and unframed.

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
