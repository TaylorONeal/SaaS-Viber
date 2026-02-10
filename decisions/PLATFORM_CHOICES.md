# Platform & Delivery: Key Decisions

> **Prompt Guide**: Use this document to understand your delivery options. Then use `docs/architecture/PromptGuide-Architecture.md` to generate your platform implementation plan.

## Why This Matters

The platform decision affects everything downstream: build tooling, deployment, testing, team hiring, and user experience. Get it right and you have a clean architecture that serves users well. Get it wrong and you're maintaining multiple codebases, fighting platform-specific bugs, and shipping slower than competitors.

---

## Part 1: Web Rendering Strategy

### SPA (Single Page Application) -- Recommended for Most SaaS

**How it works**: Client-side rendering. One HTML file, JavaScript handles all routing and rendering.

**When SPA makes sense (most SaaS products)**:
- Authenticated dashboards and admin panels
- B2B tools where SEO doesn't matter (users log in, not search)
- Real-time collaborative features
- Complex interactive UIs (drag-and-drop, data visualization)
- API-first products with a web dashboard

**Stack**: React/Vite, Vue/Vite, SolidJS

| Aspect | Rating | Notes |
|--------|--------|-------|
| SEO | Poor | Search engines struggle with client-rendered content |
| Initial load | Slower | Must download JS bundle before first render |
| Subsequent navigation | Fast | No full page reloads, smooth transitions |
| Caching | Excellent | Static assets cache aggressively on CDN |
| Hosting cost | Lowest | Static files on any CDN ($0-5/mo) |
| Complexity | Lowest | No server to manage |
| Offline support | Good | Service worker integration straightforward |

### SSR (Server-Side Rendering)

**How it works**: Server renders HTML on each request. Can hydrate to SPA after initial load.

**When SSR matters**:
- SEO-heavy pages (marketing site, blog, marketplace listings)
- Content platforms where search traffic drives growth
- E-commerce product pages
- Social media preview cards (OG tags) need dynamic content

**Stack**: Next.js, Remix, Nuxt, SvelteKit, Astro

| Aspect | Rating | Notes |
|--------|--------|-------|
| SEO | Excellent | Full HTML served to crawlers |
| Initial load | Fast | HTML arrives ready to display |
| Subsequent navigation | Fast | With client-side hydration |
| Hosting cost | Medium | Needs compute (serverless or server) |
| Complexity | Medium | Server runtime, caching strategy needed |
| Offline support | Medium | More complex service worker setup |

### Hybrid Approach (Recommended if SEO Matters at All)

Most SaaS products need both: a marketing site that ranks in search and an app that feels snappy.

```
Marketing site (SSR/Static) ──── app.yourproduct.com (SPA)
   yourproduct.com                    Authenticated dashboard
   /pricing                           No SEO needed
   /blog                              Client-side rendering
   /features                          Vite + React
   Astro / Next.js
```

**Practical recommendation**: Build the app as a SPA. Use a static site generator (Astro) or SSR framework (Next.js) for marketing pages. Deploy them separately.

---

## Part 2: Mobile Strategy

This is where most SaaS teams over-invest too early or under-invest too late.

### Decision Tree

```
Do your users NEED your product on mobile?
  |
  ├── "No, it's a desktop workflow tool" ──> Responsive Web Only
  |
  ├── "Nice to have for notifications/quick actions"
  |     |
  |     v
  |   PWA (Progressive Web App) ── covers 90% of use cases
  |
  ├── "Yes, core experience is mobile"
  |     |
  |     Do you need native device APIs (camera, bluetooth, sensors)?
  |     |
  |     ├── No ──> PWA or React Native (depending on complexity)
  |     |
  |     └── Yes
  |           |
  |           Is your team mainly web developers?
  |           |
  |           ├── Yes ──> React Native / Expo
  |           |
  |           └── Mixed/Native devs ──> Native iOS + Android
  |
  └── "We need App Store presence for credibility"
        |
        v
      Capacitor/Ionic wrapper (ship fast, go native later if needed)
```

### Option 1: PWA (Progressive Web App) -- RECOMMENDED for Most SaaS

A PWA is your web app with superpowers: installable, works offline, push notifications, and feels native.

**Pros**:
- Single codebase for web and "mobile app"
- Instant updates (no app store review process)
- No app store fees (15-30% saved on subscriptions)
- Works offline with service workers
- Installable on home screen (Android + iOS)
- Shareable via URL (powerful for B2B viral loops)

**Cons**:
- Limited native API access (no Bluetooth, NFC, advanced camera)
- iOS still has restrictions (push notifications require iOS 16.4+)
- No App Store / Play Store discovery (but most SaaS users come from web anyway)
- Background processing is limited on iOS

**PWA Readiness Checklist**:
```
[ ] HTTPS enabled (required)
[ ] Web app manifest (manifest.json) with icons
[ ] Service worker registered
[ ] Responsive design working at all breakpoints
[ ] Offline fallback page
[ ] App shell architecture (UI loads instantly)
[ ] Push notification support (if needed)
[ ] Install prompt handling
[ ] Splash screen configured
[ ] Testing on real iOS and Android devices
```

**Implementation Essentials**:
```typescript
// vite.config.ts - Using vite-plugin-pwa
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    VitePWA({
      registerType: 'autoUpdate',
      includeAssets: ['favicon.ico', 'apple-touch-icon.png'],
      manifest: {
        name: 'Your SaaS App',
        short_name: 'YourApp',
        description: 'Your app description',
        theme_color: '#ffffff',
        background_color: '#ffffff',
        display: 'standalone',
        scope: '/',
        start_url: '/',
        icons: [
          { src: 'icon-192.png', sizes: '192x192', type: 'image/png' },
          { src: 'icon-512.png', sizes: '512x512', type: 'image/png' },
        ],
      },
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg}'],
        runtimeCaching: [
          {
            urlPattern: /^https:\/\/api\.yourapp\.com\/.*/i,
            handler: 'NetworkFirst',
            options: { cacheName: 'api-cache', expiration: { maxEntries: 100 } },
          },
        ],
      },
    }),
  ],
});
```

### Option 2: Responsive Web (No PWA)

The simplest approach. Just make your website work well on phones.

- **Best for**: B2B products that are rarely used on mobile
- **Pros**: Zero additional complexity
- **Cons**: No offline, no install, no push notifications
- **When to upgrade**: Add PWA when users start asking for mobile access

### Option 3: React Native / Expo

A full native mobile framework using React and JavaScript.

- **Best for**: Products where mobile is the primary experience
- **Pros**: Near-native performance, access to all device APIs, one team can build both platforms
- **Cons**: Separate codebase from web, native module complexity, larger team needed
- **Cost**: 2-4x the development effort vs web-only
- **Sharing code with web**: Can share business logic, API clients, and types (but NOT UI components)

### Option 4: Capacitor / Ionic Wrapper

Wrap your web app in a native shell. Ship to app stores with minimal changes.

- **Best for**: Getting into app stores quickly with an existing web app
- **Pros**: 90% code reuse from web, access to native plugins, app store presence
- **Cons**: Performance ceiling lower than native, some UI jank possible
- **When to use**: Clients or investors want "an app" and you need it fast

### Option 5: Native iOS + Android

Two separate codebases, two teams, maximum platform integration.

- **Best for**: Consumer apps where UX must be pixel-perfect and platform-native
- **Pros**: Best possible performance and UX, full platform integration
- **Cons**: 3x development cost, 3x maintenance, requires platform specialists
- **When to justify**: Revenue supports dedicated mobile teams ($5M+ ARR typically)

### Mobile Strategy Comparison Matrix

| Factor | Responsive Web | PWA | Capacitor | React Native | Native |
|--------|---------------|-----|-----------|-------------|--------|
| Dev cost | 1x | 1.1x | 1.3x | 2x | 3x+ |
| Time to market | Fastest | Fast | Fast | Medium | Slow |
| Code sharing with web | 100% | 100% | 95% | 30-50% | 0% |
| Offline support | None | Good | Good | Excellent | Excellent |
| Push notifications | No | Yes* | Yes | Yes | Yes |
| Native API access | Limited | Limited | Good | Excellent | Full |
| App Store presence | No | No | Yes | Yes | Yes |
| Performance | Web | Web | Web+ | Near-native | Native |
| Update speed | Instant | Instant | Instant** | OTA possible | Store review |

*iOS push requires 16.4+
**Web content updates are instant; native shell updates need store review

---

## Part 3: iOS Specific Considerations

If you're shipping to the Apple App Store:

### App Store Guidelines for SaaS
- **B2B exemption**: If your app is exclusively B2B, you may qualify for exemption from in-app purchase requirements. Users can subscribe on web and use the app.
- **Reader app rule**: Apps that provide access to previously purchased content (like Kindle, Netflix) don't need IAP.
- **"Multiplatform" apps**: Apple allows linking to web for account creation if the experience exists on other platforms too.
- **Commission**: 30% first year, 15% after (Small Business Program) for IAP if required.

### Privacy Labels
- Required for all App Store submissions
- Must accurately describe all data collection (analytics, crash reporting, etc.)
- Update when adding new SDKs or tracking

### Review Process
- First submission: 1-7 days (plan for a week)
- Updates: 1-3 days typically
- Rejection appeals: Add 3-5 days
- Expedited review: Available for critical fixes

**Link to detailed checklist**: `docs/guides/IOS_READINESS_CHECKLIST.md`

---

## Part 4: Android Specific Considerations

### Play Store Requirements
- Target SDK requirements (Google updates annually)
- Data safety section (similar to Apple's privacy labels)
- 15% commission for subscriptions (first $1M at reduced rate)
- Review process: Usually 1-3 days, occasionally instant

**Link to detailed checklist**: `docs/guides/ANDROID_READINESS_CHECKLIST.md`

---

## Part 5: Recommendations by SaaS Type

### B2B Dashboard / Admin Tool
```
Primary:   Web SPA (React + Vite)
Mobile:    PWA (add when users request it)
Marketing: Static site (Astro) or landing page builder
Timeline:  Ship web MVP first, add PWA in month 2-3
```

### Consumer Marketplace
```
Primary:   Web SPA or SSR (if SEO matters for listings)
Mobile:    React Native or PWA depending on complexity
Marketing: SSR integrated (SEO is critical for discovery)
Timeline:  Web + mobile simultaneously (mobile is core)
```

### Content Platform (Blog, Course, Publishing)
```
Primary:   SSR (Next.js/Astro) -- SEO is everything
Mobile:    PWA (content consumption works great as PWA)
Marketing: Integrated with main site
Timeline:  SSR from day one, PWA as enhancement
```

### API-First / Developer Tool
```
Primary:   Web SPA for dashboard + docs site (static)
Mobile:    Responsive web only (developers don't use mobile dashboards)
Marketing: Static docs site (Docusaurus, Starlight, Mintlify)
Timeline:  Dashboard + docs + SDK simultaneously
```

### Collaboration / Productivity Tool
```
Primary:   Web SPA with real-time features
Mobile:    PWA initially, React Native if usage warrants
Marketing: Static landing page
Timeline:  Web MVP, PWA month 2, evaluate native at 10K users
```

---

## Quick Decision Checklist

Before committing to a platform strategy, answer these:

1. **Where do your users currently spend time?** (Desktop browser? Phone? Both?)
2. **What's your team's expertise?** (Web only? Mobile experience?)
3. **What's your budget for the first 6 months?**
4. **Do you need App Store presence for sales/credibility?**
5. **Do you need offline functionality?**
6. **How important is SEO for user acquisition?**
7. **What native device features do you need?** (Camera? GPS? Bluetooth? None?)

---

## Our Decision

**Web rendering**: [SPA / SSR / Hybrid]
**Mobile strategy**: [PWA / React Native / Capacitor / Native / Responsive only]
**Date**: [Date]
**Decided by**: [Who]
**Rationale**: [Why this approach]
**Review trigger**: [When to re-evaluate -- e.g., "when mobile traffic exceeds 30%"]
**Migration path**: [How we'd shift strategy if needed]
