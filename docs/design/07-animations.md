# Animation System

> Every animation in your app should be intentional, performant, and accessible.
> This file is your single reference for what animations exist, how to use them,
> and where to edit them.

---

## Where to Edit Animations

| What | Where | Format |
|---|---|---|
| **Duration and easing tokens** | `docs/design/tokens/tokens.json` → animation | JSON values |
| **CSS custom properties** | `src/styles/globals.css` | CSS variables |
| **Tailwind keyframes** | `tailwind.config.ts` → keyframes | TypeScript object |
| **Tailwind animation classes** | `tailwind.config.ts` → animation | TypeScript object |
| **Component-specific animations** | Individual component files | Tailwind classes or CSS |
| **This reference doc** | `docs/design/07-animations.md` | Markdown |

**Workflow**: Define the intent here → set token values in `tokens.json` → implement in `tailwind.config.ts` → apply via Tailwind classes in components.

---

## Animation Tokens

These are the base timing and easing values. Change them here to affect the entire app.

### Durations

| Token | Value | Use For |
|---|---|---|
| `--duration-instant` | `50ms` | Checkbox checks, radio selects |
| `--duration-fast` | `100ms` | Color transitions, hover states |
| `--duration-normal` | `200ms` | Most UI transitions (modals, dropdowns, tabs) |
| `--duration-slow` | `300ms` | Slide-ins, page transitions, larger elements |
| `--duration-slower` | `500ms` | Complex orchestrated animations, onboarding |

### Easing Curves

| Token | Value | Feel | Use For |
|---|---|---|---|
| `--ease-in` | `cubic-bezier(0.4, 0, 1, 1)` | Accelerating | Elements leaving the screen |
| `--ease-out` | `cubic-bezier(0, 0, 0.2, 1)` | Decelerating | Elements entering the screen |
| `--ease-in-out` | `cubic-bezier(0.4, 0, 0.2, 1)` | Smooth arc | Most UI transitions |
| `--ease-bounce` | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Playful overshoot | Success states, celebrations, toggles |
| `--ease-spring` | `cubic-bezier(0.175, 0.885, 0.32, 1.275)` | Springy | Popovers, tooltips, floating elements |

### CSS Custom Properties

```css
:root {
  /* Durations */
  --duration-instant: 50ms;
  --duration-fast:    100ms;
  --duration-normal:  200ms;
  --duration-slow:    300ms;
  --duration-slower:  500ms;

  /* Easing */
  --ease-in:      cubic-bezier(0.4, 0, 1, 1);
  --ease-out:     cubic-bezier(0, 0, 0.2, 1);
  --ease-in-out:  cubic-bezier(0.4, 0, 0.2, 1);
  --ease-bounce:  cubic-bezier(0.34, 1.56, 0.64, 1);
  --ease-spring:  cubic-bezier(0.175, 0.885, 0.32, 1.275);

  /* Composed transitions (ready to use) */
  --transition-colors:    color var(--duration-fast) var(--ease-in-out),
                          background-color var(--duration-fast) var(--ease-in-out),
                          border-color var(--duration-fast) var(--ease-in-out);
  --transition-transform: transform var(--duration-normal) var(--ease-out);
  --transition-opacity:   opacity var(--duration-normal) var(--ease-in-out);
  --transition-all:       all var(--duration-normal) var(--ease-in-out);
}
```

---

## Standard Animations

These are the keyframe animations defined in `tailwind.config.ts`. Use them via Tailwind `animate-*` classes.

### Entrances

| Animation | Class | Duration | What It Does |
|---|---|---|---|
| Fade In | `animate-fade-in` | 200ms ease-out | Opacity 0 → 1 |
| Fade In Up | `animate-fade-in-up` | 300ms ease-out | Opacity 0 → 1, translateY(8px) → 0 |
| Fade In Down | `animate-fade-in-down` | 300ms ease-out | Opacity 0 → 1, translateY(-8px) → 0 |
| Slide In From Top | `animate-slide-in-from-top` | 300ms ease-out | translateY(-100%) → 0 |
| Slide In From Bottom | `animate-slide-in-from-bottom` | 300ms ease-out | translateY(100%) → 0 |
| Slide In From Left | `animate-slide-in-from-left` | 300ms ease-out | translateX(-100%) → 0 |
| Slide In From Right | `animate-slide-in-from-right` | 300ms ease-out | translateX(100%) → 0 |
| Scale In | `animate-scale-in` | 200ms ease-out | scale(0.95) opacity(0) → scale(1) opacity(1) |
| Pop In | `animate-pop-in` | 300ms bounce | scale(0.8) → scale(1) with overshoot |

### Exits

| Animation | Class | Duration | What It Does |
|---|---|---|---|
| Fade Out | `animate-fade-out` | 200ms ease-in | Opacity 1 → 0 |
| Slide Out To Top | `animate-slide-out-to-top` | 200ms ease-in | translateY(0) → translateY(-100%) |
| Slide Out To Bottom | `animate-slide-out-to-bottom` | 200ms ease-in | translateY(0) → translateY(100%) |
| Scale Out | `animate-scale-out` | 150ms ease-in | scale(1) → scale(0.95) opacity(0) |

### Continuous

| Animation | Class | Duration | What It Does |
|---|---|---|---|
| Spin | `animate-spin` | 1s linear infinite | 360° rotation (loading spinners) |
| Pulse | `animate-pulse` | 2s ease-in-out infinite | Opacity 1 → 0.5 → 1 (skeleton loading) |
| Bounce | `animate-bounce` | 1s infinite | Vertical bounce (attention) |
| Ping | `animate-ping` | 1s ease-out infinite | Scale + fade (notification dot) |

### Component-Specific

| Animation | Class | Used By | What It Does |
|---|---|---|---|
| Accordion Down | `animate-accordion-down` | Accordion | height: 0 → auto with Radix |
| Accordion Up | `animate-accordion-up` | Accordion | height: auto → 0 with Radix |
| Toast Enter | `animate-toast-enter` | Toast | Slide in from right + fade |
| Toast Exit | `animate-toast-exit` | Toast | Slide out to right + fade |
| Sheet Overlay | `animate-sheet-overlay` | Sheet/Dialog | Background overlay fade in |

---

## Tailwind Keyframes Reference

Add these to `tailwind.config.ts` under `theme.extend.keyframes`:

```typescript
keyframes: {
  // -- Entrances --
  "fade-in": {
    from: { opacity: "0" },
    to: { opacity: "1" },
  },
  "fade-in-up": {
    from: { opacity: "0", transform: "translateY(8px)" },
    to: { opacity: "1", transform: "translateY(0)" },
  },
  "fade-in-down": {
    from: { opacity: "0", transform: "translateY(-8px)" },
    to: { opacity: "1", transform: "translateY(0)" },
  },
  "slide-in-from-top": {
    from: { transform: "translateY(-100%)" },
    to: { transform: "translateY(0)" },
  },
  "slide-in-from-bottom": {
    from: { transform: "translateY(100%)" },
    to: { transform: "translateY(0)" },
  },
  "slide-in-from-left": {
    from: { transform: "translateX(-100%)" },
    to: { transform: "translateX(0)" },
  },
  "slide-in-from-right": {
    from: { transform: "translateX(100%)" },
    to: { transform: "translateX(0)" },
  },
  "scale-in": {
    from: { opacity: "0", transform: "scale(0.95)" },
    to: { opacity: "1", transform: "scale(1)" },
  },
  "pop-in": {
    "0%": { opacity: "0", transform: "scale(0.8)" },
    "70%": { opacity: "1", transform: "scale(1.05)" },
    "100%": { opacity: "1", transform: "scale(1)" },
  },

  // -- Exits --
  "fade-out": {
    from: { opacity: "1" },
    to: { opacity: "0" },
  },
  "slide-out-to-top": {
    from: { transform: "translateY(0)" },
    to: { transform: "translateY(-100%)" },
  },
  "slide-out-to-bottom": {
    from: { transform: "translateY(0)" },
    to: { transform: "translateY(100%)" },
  },
  "scale-out": {
    from: { opacity: "1", transform: "scale(1)" },
    to: { opacity: "0", transform: "scale(0.95)" },
  },

  // -- Component-specific --
  "accordion-down": {
    from: { height: "0" },
    to: { height: "var(--radix-accordion-content-height)" },
  },
  "accordion-up": {
    from: { height: "var(--radix-accordion-content-height)" },
    to: { height: "0" },
  },
  "toast-enter": {
    from: { opacity: "0", transform: "translateX(100%)" },
    to: { opacity: "1", transform: "translateX(0)" },
  },
  "toast-exit": {
    from: { opacity: "1", transform: "translateX(0)" },
    to: { opacity: "0", transform: "translateX(100%)" },
  },
  "sheet-overlay": {
    from: { opacity: "0" },
    to: { opacity: "1" },
  },
},
```

And the corresponding `animation` entries:

```typescript
animation: {
  "fade-in":              "fade-in 0.2s ease-out",
  "fade-in-up":           "fade-in-up 0.3s ease-out",
  "fade-in-down":         "fade-in-down 0.3s ease-out",
  "slide-in-from-top":    "slide-in-from-top 0.3s ease-out",
  "slide-in-from-bottom": "slide-in-from-bottom 0.3s ease-out",
  "slide-in-from-left":   "slide-in-from-left 0.3s ease-out",
  "slide-in-from-right":  "slide-in-from-right 0.3s ease-out",
  "scale-in":             "scale-in 0.2s ease-out",
  "pop-in":               "pop-in 0.3s cubic-bezier(0.34, 1.56, 0.64, 1)",
  "fade-out":             "fade-out 0.2s ease-in",
  "slide-out-to-top":     "slide-out-to-top 0.2s ease-in",
  "slide-out-to-bottom":  "slide-out-to-bottom 0.2s ease-in",
  "scale-out":            "scale-out 0.15s ease-in",
  "accordion-down":       "accordion-down 0.2s ease-out",
  "accordion-up":         "accordion-up 0.2s ease-out",
  "toast-enter":          "toast-enter 0.3s ease-out",
  "toast-exit":           "toast-exit 0.2s ease-in",
  "sheet-overlay":        "sheet-overlay 0.15s ease-out",
},
```

---

## Accessibility: Reduced Motion

**Every animation must be disabled when the user has `prefers-reduced-motion: reduce` set.**

### Global CSS approach

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### Tailwind approach

Use `motion-safe:` and `motion-reduce:` variants:

```html
<!-- Only animate when user allows motion -->
<div class="motion-safe:animate-fade-in-up motion-reduce:opacity-100">
  Content appears instantly for reduced-motion users
</div>
```

### React hook for programmatic checks

```tsx
function useReducedMotion(): boolean {
  const [reduced, setReduced] = useState(false);

  useEffect(() => {
    const mq = window.matchMedia("(prefers-reduced-motion: reduce)");
    setReduced(mq.matches);
    const handler = (e: MediaQueryListEvent) => setReduced(e.matches);
    mq.addEventListener("change", handler);
    return () => mq.removeEventListener("change", handler);
  }, []);

  return reduced;
}
```

---

## Animation Decision Guide

Use this to decide which animation fits your use case:

| Scenario | Recommended Animation | Why |
|---|---|---|
| Modal/dialog opening | `scale-in` + overlay `fade-in` | Feels natural, draws focus |
| Modal/dialog closing | `scale-out` + overlay `fade-out` | Quick exit, doesn't delay |
| Toast notification | `toast-enter` / `toast-exit` | Slides from notification area |
| Dropdown menu opening | `scale-in` or `fade-in-down` | Appears from trigger |
| Sidebar opening (mobile) | `slide-in-from-left` | Follows drawer pattern |
| Sheet/panel opening | `slide-in-from-right` | Side panel convention |
| Page content loading | `fade-in-up` (staggered) | Progressive reveal |
| Tab content switching | `fade-in` | Clean, no spatial confusion |
| Success confirmation | `pop-in` | Celebratory, noticeable |
| Skeleton → real content | `fade-in` | Smooth replacement |
| Accordion expand | `accordion-down` | Native height animation |
| Button hover | CSS `transition-colors` | Instant feel, no animation class needed |
| List item appearing | `fade-in-up` with staggered delay | Natural flow |
| Error shake | custom 3-frame translateX | Draws attention without being annoying |

---

## Staggered Animations

For lists and grids where items should appear sequentially:

```tsx
// Apply increasing delay to child elements
{items.map((item, i) => (
  <div
    key={item.id}
    className="animate-fade-in-up"
    style={{ animationDelay: `${i * 50}ms`, animationFillMode: "backwards" }}
  >
    {item.content}
  </div>
))}
```

**Guidelines:**
- Max stagger delay: 500ms total (10 items × 50ms, or 5 items × 100ms)
- If more than 10 items, only stagger the first 10, rest appear at once
- Use `animationFillMode: "backwards"` so items start invisible

---

## Performance Rules

1. **Only animate `transform` and `opacity`** -- these are GPU-accelerated and don't trigger layout recalculations
2. **Avoid animating**: `width`, `height`, `top`, `left`, `margin`, `padding`, `box-shadow` -- these cause layout thrashing
3. **Use `will-change` sparingly** -- only on elements that are about to animate, remove after
4. **Keep durations under 500ms** for UI transitions -- users perceive anything longer as slow
5. **No animation on page load** unless it serves onboarding or first-run experience
6. **Test on low-end devices** -- animations that stutter are worse than no animation
