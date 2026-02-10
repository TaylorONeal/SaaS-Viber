# Dependencies Guide

> Which packages to install based on your decisions.

<!-- TEMPLATE: This file helps you pick the right dependencies for your stack. -->
<!-- The package.json starts empty so you install only what you need. -->

---

## How to Use This Guide

1. Make your key decisions (see `decisions/` folder)
2. Find the matching section below
3. Run the install commands for your choices
4. Repeat as you add features

---

## Core (Everyone Needs These)

```bash
# React + TypeScript + Vite (framework)
npm install react react-dom react-router-dom
npm install -D typescript @types/react @types/react-dom @vitejs/plugin-react-swc

# Build tooling
npm install -D vite eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser

# Styling
npm install -D tailwindcss postcss autoprefixer
npm install tailwindcss-animate class-variance-authority clsx tailwind-merge

# UI Components (shadcn/ui)
npx shadcn@latest init
# Then add components as needed: npx shadcn@latest add button card dialog ...

# Icons
npm install lucide-react
```

---

## Backend

### Supabase
```bash
npm install @supabase/supabase-js
# Optional: Supabase Auth helpers for React
npm install @supabase/auth-helpers-react
```

### Firebase
```bash
npm install firebase
# Optional: React Firebase hooks
npm install react-firebase-hooks
```

### Custom API
```bash
# HTTP client
npm install axios
# or use built-in fetch with a wrapper
npm install ky

# React Query for server state management
npm install @tanstack/react-query @tanstack/react-query-devtools
```

---

## Authentication

### Supabase Auth
```bash
# Included with @supabase/supabase-js above
```

### Auth0
```bash
npm install @auth0/auth0-react
```

### Clerk
```bash
npm install @clerk/clerk-react
```

---

## Payments

### Stripe
```bash
npm install @stripe/stripe-js @stripe/react-stripe-js
# Server-side (if you have edge functions)
npm install stripe
```

### Lemon Squeezy
```bash
npm install @lemonsqueezy/lemonsqueezy.js
```

---

## State Management

```bash
# Zustand (lightweight, recommended for most SaaS)
npm install zustand

# or Jotai (atomic state)
npm install jotai

# or Redux Toolkit (if you prefer Redux)
npm install @reduxjs/toolkit react-redux
```

---

## Forms and Validation

```bash
npm install react-hook-form @hookform/resolvers zod
```

---

## Date Handling

```bash
npm install date-fns
# or
npm install dayjs
```

---

## Email (Server-side)

### Resend
```bash
npm install resend
```

### SendGrid
```bash
npm install @sendgrid/mail
```

---

## Monitoring

```bash
# Error tracking
npm install @sentry/react

# Analytics
npm install posthog-js
```

---

## Testing

```bash
# Unit testing
npm install -D vitest @testing-library/react @testing-library/jest-dom jsdom

# E2E testing
npm install -D playwright @playwright/test
```

---

## Optional Enhancements

```bash
# Animations
npm install framer-motion

# Markdown rendering
npm install react-markdown remark-gfm

# Charts
npm install recharts

# Internationalization
npm install i18next react-i18next

# Rich text editor
npm install @tiptap/react @tiptap/starter-kit

# File uploads
npm install react-dropzone
```

---

## Version Pinning

For production stability, consider pinning exact versions:

```bash
# Create .npmrc with:
save-exact=true
```

This ensures `npm install [package]` saves exact versions instead of ranges.

---

*Install only what you need. Every dependency is a maintenance commitment.*
