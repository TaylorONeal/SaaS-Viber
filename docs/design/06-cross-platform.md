# Cross-Platform Design Guidelines

> How to design and build your SaaS for consistent experience across web,
> mobile web, iOS, and Android.

---

## Responsive Breakpoints Strategy

### Breakpoint Definitions

| Breakpoint | Width | Target Devices |
|------------|-------|----------------|
| `sm` | 640px | Mobile landscape, small tablets |
| `md` | 768px | Tablets (portrait) |
| `lg` | 1024px | Tablets (landscape), small laptops |
| `xl` | 1280px | Desktops, laptops |
| `2xl` | 1536px | Large desktops, ultrawide |

### Application Strategy

- **Consumer/marketing pages:** Mobile-first (start from smallest screen, enhance upward)
- **Admin dashboard:** Desktop-first (start from full desktop, adapt downward)
- **Email templates:** 600px max-width, single column for reliability

### Tailwind Usage

```tsx
// Mobile-first (consumer pages)
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

// Desktop-first (admin dashboard)
// Use default desktop layout, override for smaller screens
<aside className="w-64 lg:w-56 md:w-0 md:hidden">
```

---

## Mobile-First vs Desktop-First

### When to Use Mobile-First

- Landing pages and marketing content
- Consumer-facing product pages
- Onboarding and signup flows
- Content-heavy pages (blog, documentation)
- Any page where mobile traffic exceeds 30%

### When to Use Desktop-First

- Admin dashboards with complex data tables
- Settings pages with many form fields
- Analytics and reporting views
- Internal tools and back-office screens
- Workflow builders and visual editors

### Hybrid Approach

Most SaaS products benefit from a hybrid approach:
- Public pages are mobile-first
- Authenticated dashboard pages are desktop-first
- Both share the same design tokens and component library

---

## Touch Targets and Gestures

### Minimum Touch Targets

| Platform | Minimum Size | Recommended |
|----------|-------------|-------------|
| iOS (Apple HIG) | 44x44 pt | 48x48 pt |
| Android (Material) | 48x48 dp | 48x48 dp |
| Web (WCAG) | 24x24 CSS px | 44x44 CSS px |

### Common Touch Patterns

| Gesture | Usage | Implementation |
|---------|-------|----------------|
| Tap | Primary interaction | `onClick` / `onPress` |
| Long press | Secondary actions, context menu | Custom handler with 500ms delay |
| Swipe horizontal | Navigate between tabs, dismiss items | Gesture library or CSS scroll-snap |
| Swipe vertical | Scroll (default), pull-to-refresh | Native scroll, custom pull-to-refresh |
| Pinch | Zoom images, maps | Transform with gesture library |
| Double tap | Zoom, like/favorite | Custom handler with debounce |

### Spacing for Touch

- Minimum 8px gap between adjacent touch targets
- Interactive list items should be at least 48px tall
- Buttons in mobile views should be at least 44px tall
- Floating action buttons: 56px diameter

---

## Platform-Specific Patterns

### iOS (Human Interface Guidelines)

| Pattern | iOS Convention |
|---------|---------------|
| Navigation | Tab bar at bottom, navigation bar at top |
| Back navigation | Back button top-left, swipe from left edge |
| Destructive actions | Red text, confirmation sheet from bottom |
| Modals | Sheet style, partial-height from bottom |
| Toggles | UISwitch style with rounded track |
| Dates | Inline wheel picker or calendar |
| Search | Search bar in navigation bar |
| Loading | Activity indicator (spinner) |

### Android (Material Design 3)

| Pattern | Android Convention |
|---------|-------------------|
| Navigation | Bottom navigation bar, navigation drawer |
| Back navigation | System back button/gesture |
| Destructive actions | Dialog confirmation |
| Modals | Full-screen or bottom sheet |
| Toggles | Material switch with thumb |
| Dates | Date picker dialog |
| Search | Expanding search in app bar |
| Loading | Linear progress bar or circular indicator |

### Web

| Pattern | Web Convention |
|---------|---------------|
| Navigation | Sidebar or top nav, breadcrumbs |
| Back navigation | Browser back, breadcrumb trail |
| Destructive actions | Confirmation dialog |
| Modals | Centered dialog with overlay |
| Toggles | Checkbox or switch component |
| Dates | Calendar dropdown picker |
| Search | Search input in header or sidebar |
| Loading | Skeleton screens preferred over spinners |

---

## Adaptive vs Responsive Approaches

### Responsive Design (Preferred for Web)

Same components adapt their layout based on viewport width using CSS.

**When to use:**
- Web application (primary delivery)
- Content-focused pages
- Simple layouts that flex well

**Techniques:**
- Fluid grids with `fr` units and percentage widths
- Media queries via Tailwind breakpoints
- Flexbox `wrap` for reflowing content
- CSS `clamp()` for fluid typography

```css
/* Fluid typography */
font-size: clamp(1rem, 0.5rem + 1.5vw, 1.5rem);

/* Fluid spacing */
padding: clamp(1rem, 3vw, 3rem);
```

### Adaptive Design (When Needed)

Different component structures or layouts for different device categories.

**When to use:**
- Fundamentally different mobile vs desktop interactions
- Data tables that become card lists on mobile
- Multi-step forms that collapse to wizards on mobile
- Navigation that changes from sidebar to bottom tabs

**Implementation:**

```tsx
import { useMediaQuery } from '@/hooks/use-media-query';

function DataView({ data }) {
  const isDesktop = useMediaQuery('(min-width: 1024px)');

  if (isDesktop) {
    return <DataTable data={data} />;
  }
  return <DataCardList data={data} />;
}
```

### Choosing Between Them

| Scenario | Approach |
|----------|----------|
| Text reflows naturally | Responsive |
| Layout needs minor adjustments | Responsive |
| Component needs different structure | Adaptive |
| Interaction model changes entirely | Adaptive |
| Performance differs significantly | Adaptive (lazy-load desktop-only features) |

---

## Performance Considerations

### Mobile-Specific Optimizations

- Serve smaller images with `srcSet` and `sizes`
- Lazy-load below-the-fold content
- Minimize JavaScript for initial page load
- Use `content-visibility: auto` for long pages
- Defer non-critical CSS

### Network Awareness

```tsx
// Adapt quality based on connection
const connection = navigator.connection;
const imageQuality = connection?.effectiveType === '4g' ? 'high' : 'low';
```

### Touch Performance

- Avoid `hover`-dependent interactions on touch devices
- Use `will-change` sparingly for animated elements
- Prefer CSS transitions over JavaScript animations
- Debounce scroll and resize event handlers

---

## Testing Checklist

- [ ] Test on real devices (not just browser DevTools resize)
- [ ] Verify touch targets meet minimum sizes
- [ ] Check text readability at all breakpoints
- [ ] Test with slow network (3G throttling)
- [ ] Verify no horizontal scroll on any viewport
- [ ] Test landscape orientation on mobile
- [ ] Verify all interactive elements are reachable on small screens
- [ ] Check for overlapping elements at breakpoint boundaries
