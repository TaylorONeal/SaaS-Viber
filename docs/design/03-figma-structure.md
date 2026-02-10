# Figma File Organization

> Template for structuring your Figma design files for a SaaS project.
> A well-organized Figma file speeds up design-to-code handoff significantly.

---

## Recommended Figma Structure

### File Organization

```
[PROJECT_NAME] Design System
  |-- Cover Page
  |-- Getting Started
  |-- Tokens & Styles
  |-- Components
  |-- Icons
  |-- Patterns

[PROJECT_NAME] Product
  |-- Cover Page
  |-- Flows & Wireframes
  |-- Marketing Pages
  |-- Auth Pages
  |-- Dashboard
  |-- Settings
  |-- [Feature Pages]
  |-- Mobile Screens
```

### Two-File Approach

Keep your **Design System** and **Product Designs** in separate files:
- The design system file is your component library (published as a Figma library)
- The product file consumes the library and contains actual page designs

This separation lets you update tokens and components in one place and have
changes propagate to all product screens.

---

## Page Organization

### Design System File Pages

| Page | Contents |
|------|----------|
| **Cover** | File name, last updated date, team, status |
| **Getting Started** | How to use this library, contribution guide |
| **Colors** | All color swatches organized by category |
| **Typography** | Font samples at all sizes, weights, line heights |
| **Spacing & Grid** | Spacing scale visualization, grid system |
| **Icons** | Full icon set with names and sizes |
| **Components** | All components organized by category |
| **Patterns** | Common UI patterns (forms, tables, cards, navigation) |

### Product File Pages

| Page | Contents |
|------|----------|
| **Cover** | Project name, links, status |
| **Sitemap** | Visual sitemap with page hierarchy |
| **User Flows** | Flow diagrams for key journeys |
| **Marketing** | Landing, pricing, about, blog pages |
| **Auth** | Login, signup, password reset, email verification |
| **Dashboard** | Main dashboard views and states |
| **Settings** | Account, billing, team, notification settings |
| **[Feature]** | One page per major feature area |
| **Mobile** | Mobile-specific screens and adaptations |
| **Archive** | Old versions kept for reference |

---

## Component Naming Conventions

### Naming Structure

```
Category / Component Name / Variant
```

Examples:
```
Navigation / Navbar / Default
Navigation / Navbar / Compact
Navigation / Sidebar / Expanded
Navigation / Sidebar / Collapsed
Data Display / Card / Default
Data Display / Card / With Image
Data Display / Card / Compact
Data Input / Input / Default
Data Input / Input / With Icon
Data Input / Input / Error
Feedback / Toast / Success
Feedback / Toast / Error
Feedback / Toast / Warning
```

### Naming Rules

1. Use **Title Case** for component names
2. Use **/** as the separator (creates Figma's nested menu structure)
3. Group by function, not by visual similarity
4. Name variants descriptively (not "Variant 1", "Variant 2")
5. Prefix private/internal components with `.` (e.g., `.Helper / Badge`)

---

## Auto-Layout Guidelines

### General Rules

- **Always use auto-layout** for components that contain text or variable content
- Set **padding** using your spacing tokens (8, 12, 16, 24, etc.)
- Set **gap** between elements using spacing tokens
- Use **Fill** width for elements that should stretch (inputs, buttons in forms)
- Use **Hug** for elements that size to their content (badges, tags)

### Common Patterns

| Pattern | Direction | Alignment | Gap |
|---------|-----------|-----------|-----|
| Button content | Horizontal | Center | 8px |
| Form field (label + input) | Vertical | Left | 4px |
| Card content | Vertical | Left | 16px |
| Navigation items | Vertical | Stretch | 4px |
| Toolbar actions | Horizontal | Center | 8px |
| Page section | Vertical | Stretch | 32-48px |

### Responsive Frames

- Set **min/max width** on frames for responsive behavior
- Use **Fill** on the main content area, **Fixed** on sidebars
- Use **Wrap** for grid layouts that reflow

---

## Design-to-Code Workflow

### Step 1: Design in Figma

1. Use components from the design system library
2. Follow spacing tokens exactly (no arbitrary values)
3. Use named styles for colors, typography, and shadows
4. Apply auto-layout with consistent settings
5. Name all layers meaningfully (not "Frame 47")

### Step 2: Annotate for Development

Add annotations for:
- Interactive states (hover, focus, active, disabled)
- Animation/transition behavior
- Responsive breakpoint behavior
- Edge cases (empty states, error states, loading states)
- Data constraints (max character counts, number ranges)

### Step 3: Developer Handoff

1. Mark the design as ready for development (use a status label)
2. Ensure all components use library instances (not detached copies)
3. Verify spacing uses token values
4. Add a comment linking to the ticket/issue
5. Walk through the design with the developer if complex

### Step 4: Implementation

- Developer inspects Figma for measurements, colors, spacing
- Reference `docs/design/02-design-tokens.md` for token names
- Use shadcn/ui components as the base
- Add Tailwind classes matching the Figma design tokens
- Compare implementation to Figma side-by-side

### Step 5: Design Review

- Developer shares a preview link
- Designer verifies against the Figma design
- Check responsive behavior at all breakpoints
- Verify interactive states match annotations
- Approve or request changes

---

## Handoff Checklist

Before marking a design as ready for development:

- [ ] All layers are named descriptively
- [ ] Auto-layout is applied to all dynamic containers
- [ ] Colors use named styles (not hardcoded hex values)
- [ ] Typography uses named text styles
- [ ] Spacing follows the token scale
- [ ] Components are library instances (not detached)
- [ ] All states are designed (default, hover, focus, disabled, error, loading, empty)
- [ ] Responsive behavior is specified or demonstrated
- [ ] Edge cases are annotated (long text, missing data, permissions)
- [ ] Linked to the relevant ticket or issue
