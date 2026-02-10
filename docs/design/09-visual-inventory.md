# Visual Patterns Inventory

> A catalog of recurring visual patterns in SaaS applications. Use this as a
> reference when designing pages and as a checklist to ensure consistency.

---

## Where to Edit Visual Patterns

| Pattern Category | Where to Change It |
|---|---|
| Colors and surfaces | `docs/design/08-theming.md` → CSS variables |
| Spacing and layout | `docs/design/tokens/tokens.json` → spacing |
| Border radius and shadows | `docs/design/tokens/tokens.json` → borderRadius, shadow |
| Animations and transitions | `docs/design/07-animations.md` → keyframes |
| Component specs | `docs/design/05-components.md` → component tables |
| Typography | `docs/design/02-design-tokens.md` → Typography section |

---

## Page Layouts

### Dashboard Layout

```
┌──────────────────────────────────────────────┐
│  Header (logo, search, user menu, theme)     │
├────────┬─────────────────────────────────────┤
│        │                                     │
│ Side-  │  Main Content Area                  │
│ bar    │                                     │
│        │  ┌─────────┐ ┌─────────┐            │
│ nav    │  │ Stat    │ │ Stat    │            │
│ items  │  │ Card    │ │ Card    │            │
│        │  └─────────┘ └─────────┘            │
│        │                                     │
│        │  ┌───────────────────────┐          │
│        │  │ Data Table / Content  │          │
│        │  │                       │          │
│        │  └───────────────────────┘          │
├────────┴─────────────────────────────────────┤
│  Footer (optional in authenticated views)    │
└──────────────────────────────────────────────┘
```

**Design specs:**
- Sidebar width: 256px expanded, 64px collapsed, 0px on mobile (drawer)
- Header height: 64px (desktop), 56px (mobile)
- Main content max-width: 1200px (centered) or fluid
- Content padding: 24px (desktop), 16px (mobile)
- Stat card grid: 4-col desktop, 2-col tablet, 1-col mobile

### Settings Layout

```
┌──────────────────────────────────────────────┐
│  Header                                      │
├────────┬─────────────────────────────────────┤
│        │                                     │
│ Side-  │  Settings Section Header            │
│ bar    │  ─────────────────────              │
│        │                                     │
│ main   │  ┌───────────────────────┐          │
│ nav    │  │ Settings Card         │          │
│        │  │                       │          │
│ ────── │  │ Label         [Input] │          │
│ Sett-  │  │ Label         [Input] │          │
│ ings   │  │                       │          │
│ tabs   │  │         [Save Button] │          │
│        │  └───────────────────────┘          │
│        │                                     │
└────────┴─────────────────────────────────────┘
```

**Design specs:**
- Settings nav: vertical tabs within sidebar or separate left nav
- Settings card max-width: 640px
- Form labels: left-aligned or top-aligned (top on mobile)
- Save button: right-aligned, primary style
- Danger zone: separated at bottom, red destructive button

### Marketing / Landing Page Layout

```
┌──────────────────────────────────────────────┐
│  Navbar (logo, nav links, CTA button)        │
├──────────────────────────────────────────────┤
│                                              │
│  Hero Section                                │
│  Headline + subheading + CTA + visual        │
│                                              │
├──────────────────────────────────────────────┤
│  Social Proof (logos, testimonial, stats)     │
├──────────────────────────────────────────────┤
│  Features Grid (3-col icons + text)          │
├──────────────────────────────────────────────┤
│  How It Works (3 steps, numbered)            │
├──────────────────────────────────────────────┤
│  Pricing Table (2-3 tiers, popular marked)   │
├──────────────────────────────────────────────┤
│  FAQ (accordion)                             │
├──────────────────────────────────────────────┤
│  Final CTA                                   │
├──────────────────────────────────────────────┤
│  Footer (links, legal, social icons)         │
└──────────────────────────────────────────────┘
```

**Design specs:**
- Full-width sections with max-width 1200px inner content
- Hero: large heading (text-4xl to text-6xl), subheading (text-xl), generous whitespace
- Section padding: 80px vertical (desktop), 48px (mobile)
- Features grid: 3-col with icons, 1-col on mobile
- Pricing: highlight the recommended tier with primary border + "Popular" badge

### Auth Pages (Login / Signup)

```
┌──────────────────────────────────────────────┐
│                                              │
│         ┌───────────────────┐                │
│         │  Logo             │                │
│         │                   │                │
│         │  Welcome back     │                │
│         │                   │                │
│         │  Email    [_____] │                │
│         │  Password [_____] │                │
│         │                   │                │
│         │  [  Sign In     ] │                │
│         │                   │                │
│         │  ── or ──         │                │
│         │  [Google] [GitHub]│                │
│         │                   │                │
│         │  No account? Sign │                │
│         │  up               │                │
│         └───────────────────┘                │
│                                              │
└──────────────────────────────────────────────┘
```

**Design specs:**
- Card max-width: 400px, centered vertically and horizontally
- Logo above the card or inside at top
- Social login buttons: full width, outlined style
- Divider with "or" text between form and social options
- Link to alternate action at bottom (login ↔ signup)

---

## Header Patterns

### Authenticated Header

```
┌───────────────────────────────────────────────────┐
│ [≡] Logo        [Search___________]  🔔  [Avatar▾]│
└───────────────────────────────────────────────────┘
```

| Element | Specs |
|---|---|
| Hamburger (mobile only) | 44x44px touch target, toggles sidebar |
| Logo | 24-32px height, links to dashboard |
| Search | Expandable on mobile, `/` shortcut on desktop |
| Notifications bell | Badge dot for unread, dropdown list |
| User avatar | 32px circle, dropdown with profile/settings/logout |

### Marketing Header

```
┌───────────────────────────────────────────────────┐
│ Logo    Features  Pricing  Docs    [Login] [CTA ▶]│
└───────────────────────────────────────────────────┘
```

| Element | Specs |
|---|---|
| Logo | Links to homepage |
| Nav links | 4-6 max, horizontal on desktop, hamburger menu on mobile |
| Login | Ghost/text button style |
| CTA | Primary button, stands out from nav |

---

## Footer Patterns

### Authenticated Footer (Minimal)

```
┌───────────────────────────────────────────────────┐
│ © 2025 YourApp · Help · Privacy · Terms    v1.2.3 │
└───────────────────────────────────────────────────┘
```

Usually omitted in dashboard views (sidebar provides navigation). If present, keep it minimal.

### Marketing Footer

```
┌───────────────────────────────────────────────────┐
│                                                   │
│  Logo + tagline      Product     Company    Legal │
│                      Features    About      Terms │
│                      Pricing     Blog       Privacy│
│                      Docs        Careers    Cookie │
│                      Changelog   Contact    GDPR  │
│                                                   │
│  ─────────────────────────────────────────────── │
│  © 2025 YourCompany  [Twitter] [GitHub] [LinkedIn]│
│                                                   │
└───────────────────────────────────────────────────┘
```

| Element | Specs |
|---|---|
| Columns | 3-4 columns, 1-col stacked on mobile |
| Logo | Smaller version, with one-line description |
| Social links | Icon-only, 24px, 44px touch target area |
| Legal links | Required: Terms of Service, Privacy Policy |
| GDPR | If serving EU users: cookie policy, data processing |
| Copyright | Current year, company legal name |

---

## Card Patterns

### Stat Card

```
┌──────────────────────┐
│  Total Users         │
│  12,847       ▲ 12%  │
│  ████████████░░░░░   │
└──────────────────────┘
```

- Label: text-sm, muted foreground
- Value: text-2xl or text-3xl, bold, foreground
- Trend: text-sm, green (up) / red (down) with arrow icon
- Optional: sparkline or mini bar chart

### Content Card

```
┌──────────────────────┐
│  ┌──┐                │
│  │🖼│ Card Title     │
│  └──┘                │
│  Description text    │
│  goes here across    │
│  multiple lines.     │
│                      │
│  Tag1  Tag2   [→]    │
└──────────────────────┘
```

- Padding: 24px (desktop), 16px (mobile)
- Border: 1px, `--border` color
- Border radius: `--radius` (0.5rem default)
- Shadow: `--shadow-sm` (subtle), `--shadow-md` on hover if clickable
- Hover: If interactive, slight shadow increase + translate -1px

### Pricing Card

```
┌──────────────────────┐
│        Pro           │
│     ★ POPULAR        │
│                      │
│  $29/mo              │
│  billed annually     │
│                      │
│  ✓ Feature one       │
│  ✓ Feature two       │
│  ✓ Feature three     │
│  ✓ Feature four      │
│                      │
│  [ Get Started     ] │
└──────────────────────┘
```

- Popular tier: primary border, badge at top
- Other tiers: default border
- Price: text-4xl, bold
- Features: checkmark list, consistent spacing
- Button: primary for popular, secondary/outline for others

---

## Form Patterns

### Standard Form

```
Label *
┌──────────────────────┐
│ Placeholder text     │
└──────────────────────┘
Helper text or error message

Label
┌──────────────────────┐
│ Filled value         │
└──────────────────────┘

            [Cancel]  [Save Changes]
```

| Element | Specs |
|---|---|
| Labels | text-sm, font-medium, above the input |
| Required indicator | Red asterisk or "(required)" text |
| Inputs | 40px height (desktop), 44px (mobile), border, rounded |
| Focus | 2px ring in `--ring` color, border color change |
| Error | Red border, red error text below, icon optional |
| Helper text | text-sm, muted foreground, below input |
| Button alignment | Right-aligned, primary for submit, secondary for cancel |
| Spacing | 24px between fields, 32px before buttons |

### Inline Editing

```
┌───────────────────────────────────┐
│  Company Name: Acme Corp  [Edit]  │
└───────────────────────────────────┘
        ↓ (click Edit)
┌───────────────────────────────────┐
│  Company Name: [Acme Corp    ]    │
│                [Cancel] [Save]    │
└───────────────────────────────────┘
```

---

## Empty States

### No Data

```
┌──────────────────────────────────┐
│                                  │
│         ┌───────┐                │
│         │  📋   │                │
│         └───────┘                │
│                                  │
│    No projects yet               │
│    Create your first project     │
│    to get started.               │
│                                  │
│    [ + Create Project ]          │
│                                  │
└──────────────────────────────────┘
```

- Centered vertically and horizontally
- Illustration or icon: 64-96px, muted color
- Heading: text-lg, foreground
- Description: text-sm, muted foreground
- Action button: primary, clear action label

### Search No Results

```
┌──────────────────────────────────┐
│                                  │
│         ┌───────┐                │
│         │  🔍   │                │
│         └───────┘                │
│                                  │
│    No results for "query"        │
│    Try adjusting your search     │
│    or filters.                   │
│                                  │
│    [Clear Filters]               │
│                                  │
└──────────────────────────────────┘
```

### Error State

```
┌──────────────────────────────────┐
│                                  │
│         ┌───────┐                │
│         │  ⚠️    │                │
│         └───────┘                │
│                                  │
│    Something went wrong          │
│    We couldn't load your data.   │
│    Please try again.             │
│                                  │
│    [Retry]  [Contact Support]    │
│                                  │
└──────────────────────────────────┘
```

---

## Loading States

### Skeleton Screen (Preferred)

```
┌──────────────────────────────────┐
│  ████████░░░░░░                  │
│  ██████████████████░░░░░░░       │
│                                  │
│  ┌────────┐ ┌────────┐          │
│  │████████│ │████████│          │
│  │████░░░░│ │████░░░░│          │
│  └────────┘ └────────┘          │
│                                  │
│  ████████████████████████░░░░░   │
│  ██████████░░░░░░░░░░░░░░░       │
│  ████████████████░░░░░░░░        │
└──────────────────────────────────┘
```

- Match the shape and position of the content being loaded
- Use `animate-pulse` (opacity oscillation)
- Background: `--muted` color
- Foreground shimmer: slightly lighter

### Progressive Loading

1. **Instant** (0ms): Show page shell (sidebar, header)
2. **Fast** (100ms): Show skeleton for content area
3. **Normal** (200-500ms): Replace skeleton with real content via `animate-fade-in`
4. **Slow** (1s+): Show a progress indicator or "Still loading..." message

### Inline Spinner

For button actions and small areas:
```
[ Saving...  ⟳ ]
```
- Replace button text with loading text + spinner
- Disable the button during loading
- Keep the button the same width (no layout shift)

---

## Notification Patterns

### Toast (Temporary)

```
                    ┌──────────────────────────┐
                    │ ✓ Changes saved          ✕│
                    │   Your profile has been    │
                    │   updated successfully.    │
                    └──────────────────────────┘
```

- Position: top-right (desktop), top-center (mobile)
- Auto-dismiss: 5s for success/info, persistent for errors
- Animation: `toast-enter` / `toast-exit`
- Max visible: 3 stacked, newest on top

### Banner (Persistent)

```
┌─────────────────────────────────────────────────┐
│ ⓘ  Your trial expires in 3 days. Upgrade now →  │
└─────────────────────────────────────────────────┘
```

- Full width, above header or inline
- Background: info (blue), warning (amber), or branded
- Dismissable with ✕ (remember dismissal in localStorage)

### Inline Alert

```
┌─────────────────────────────────────────────────┐
│ ⚠ Warning                                       │
│ You're about to delete all project data. This   │
│ cannot be undone.                                │
└─────────────────────────────────────────────────┘
```

- Colored left border (4px) + tinted background
- Icon matches variant (info, warning, error, success)
- Can include action buttons inline

---

## Navigation Patterns

### Sidebar Navigation

```
┌────────────────┐
│  Logo          │
│                │
│  ◆ Dashboard   │  ← Active: primary bg, primary text
│  ○ Projects    │  ← Default: muted text, hover bg
│  ○ Team        │
│  ○ Analytics   │
│                │
│  ── SETTINGS ──│  ← Section divider with label
│  ○ Profile     │
│  ○ Billing     │
│  ○ API Keys    │
│                │
│                │
│  ○ Help        │  ← Bottom-pinned items
│  ○ Logout      │
└────────────────┘
```

| State | Background | Text | Icon |
|---|---|---|---|
| Default | transparent | muted-foreground | muted-foreground |
| Hover | accent | accent-foreground | accent-foreground |
| Active | primary (10% opacity) | primary | primary |
| Disabled | transparent | muted-foreground (50% opacity) | same |

### Breadcrumbs

```
Dashboard  /  Projects  /  Acme Website  /  Settings
```

- Separator: `/` or `>` or chevron icon
- Current page: foreground color, no link
- Parent pages: muted foreground, linked
- On mobile: show only current + back arrow

### Tabs

```
┌──────────┐┌──────────┐┌──────────┐
│ General  ││ Members  ││ Billing  │
└──────────┘└──────────┘└──────────┘
═══════════
```

- Active: primary color border-bottom (2px), foreground text
- Inactive: no border, muted foreground text
- Hover: subtle background change
- Content switches with `animate-fade-in`

---

## Onboarding Patterns

### Welcome Modal

```
┌──────────────────────────────────┐
│                                  │
│  Welcome to [AppName]! 👋       │
│                                  │
│  Let's get you set up in         │
│  3 quick steps:                  │
│                                  │
│  ● Create your workspace         │
│  ○ Invite your team              │
│  ○ Set up your first project     │
│                                  │
│           [ Let's Go → ]         │
│                                  │
└──────────────────────────────────┘
```

### Progress Indicator

```
Step 1 of 3
═══════════════════░░░░░░░░░░░░░░░
Create your workspace
```

### Tooltip Tour

Use `driver.js` or `react-joyride` for guided tours:

```
                    ┌─────────────────────┐
                    │ This is your        │
    ┌───────┐       │ dashboard where     │
    │ 📊    │ ←──── │ you'll see all      │
    └───────┘       │ your metrics.       │
                    │          [Next →]   │
                    └─────────────────────┘
```

- Max 5-8 steps per tour
- Allow skip at every step
- Remember completion (don't re-show)
- Highlight the target element with a spotlight effect

---

## Responsive Breakpoint Patterns

### Component Transformations

| Component | Desktop (1024px+) | Tablet (768px) | Mobile (<640px) |
|---|---|---|---|
| Sidebar | Expanded (256px) | Collapsed (64px icons) | Hidden (drawer overlay) |
| Header | Full nav + search | Condensed nav | Hamburger + logo only |
| Stat cards | 4-column grid | 2-column grid | Single column stack |
| Data table | Full table | Scrollable table | Card list |
| Dialog | Centered modal | Centered modal | Full-screen sheet |
| Form | 2-column layout | Single column | Single column |
| Footer | Multi-column | 2-column | Single column stack |

---

## Visual Rhythm and Spacing

### Consistent Section Spacing

| Context | Vertical Spacing |
|---|---|
| Between page sections | 64-80px |
| Between card groups | 32-48px |
| Between cards in a group | 16-24px |
| Between form fields | 20-24px |
| Between heading and content | 8-16px |
| Between paragraphs | 16px |
| Inside a card | 24px padding |

### The 4px Grid

All spacing values should be multiples of 4:
`4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96`

This creates visual harmony -- elements feel deliberately placed rather than arbitrary.
