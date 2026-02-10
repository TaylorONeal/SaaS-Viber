# Deployment Guide

> Getting your SaaS from localhost to production.

<!-- TEMPLATE: This guide covers deploying your application to production. -->
<!-- Fill in the sections relevant to your chosen platform and remove the rest. -->
<!-- Reference your choices from decisions/PLATFORM_CHOICES.md. -->

---

## Prerequisites

Before deploying, ensure you have:

- [ ] A production build that passes all checks (`npm run build`)
- [ ] All environment variables documented and ready (see `.env.example`)
- [ ] A domain name configured (see DNS & SSL section)
- [ ] Backend services provisioned (database, auth, etc.)
- [ ] Payment webhooks configured for production URLs
- [ ] Error monitoring set up (Sentry or equivalent)

### Pre-Deployment Checklist

```bash
# Run these locally before deploying
npm run lint          # No lint errors
npm run build         # Build succeeds
npm run preview       # Preview looks correct
npx tsc --noEmit      # No TypeScript errors
npm audit             # No critical vulnerabilities
```

---

## Backend Setup

<!-- TEMPLATE: Fill in the section that matches your backend choice. -->
<!-- Remove the sections that don't apply. -->

### Supabase

If you chose Supabase as your backend (see `decisions/BACKEND_CHOICES.md`):

1. **Create a Supabase project** at [supabase.com](https://supabase.com)
2. **Run migrations:**
   ```bash
   supabase link --project-ref [YOUR_PROJECT_REF]
   supabase db push
   ```
3. **Configure auth providers** in the Supabase dashboard
4. **Set environment variables:**
   ```
   VITE_SUPABASE_URL=https://[YOUR_PROJECT_REF].supabase.co
   VITE_SUPABASE_ANON_KEY=[YOUR_ANON_KEY]
   SUPABASE_SERVICE_ROLE_KEY=[YOUR_SERVICE_ROLE_KEY]  # Server-side only
   ```
5. **Enable Row Level Security** on all tables
6. **Configure edge functions** (if applicable):
   ```bash
   supabase functions deploy [function-name]
   ```

### Firebase

If you chose Firebase:

1. **Create a Firebase project** at [console.firebase.google.com](https://console.firebase.google.com)
2. **Enable required services** (Firestore, Auth, etc.)
3. **Deploy security rules:**
   ```bash
   firebase deploy --only firestore:rules,storage:rules
   ```
4. **Set environment variables:**
   ```
   VITE_FIREBASE_API_KEY=[YOUR_API_KEY]
   VITE_FIREBASE_AUTH_DOMAIN=[YOUR_PROJECT].firebaseapp.com
   VITE_FIREBASE_PROJECT_ID=[YOUR_PROJECT_ID]
   ```

### Custom Backend

If you're running a custom backend:

1. **Deploy your API** to your chosen hosting (Railway, Fly.io, AWS, etc.)
2. **Run database migrations**
3. **Set the API URL:**
   ```
   VITE_API_URL=https://api.[YOUR_DOMAIN]
   ```

---

## Frontend Deployment

<!-- TEMPLATE: Fill in the section that matches your hosting choice. -->

### Vercel

**Recommended for:** Most SaaS projects. Zero-config for Vite apps.

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   vercel
   ```
   Or connect your GitHub repository at [vercel.com](https://vercel.com) for automatic deploys.

3. **Configure environment variables** in the Vercel dashboard:
   - Go to Settings > Environment Variables
   - Add all variables from `.env.example` with production values
   - Set different values for Preview and Production environments

4. **Configure `vercel.json`** (already included in this template):
   ```json
   {
     "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
   }
   ```

5. **Custom domain:**
   - Go to Settings > Domains
   - Add your domain and follow DNS instructions

**Build settings:**
| Setting | Value |
|---------|-------|
| Framework Preset | Vite |
| Build Command | `npm run build` |
| Output Directory | `dist` |
| Install Command | `npm install` |

---

### Netlify

**Recommended for:** Projects that need Netlify Forms, Identity, or Functions.

1. **Install Netlify CLI:**
   ```bash
   npm i -g netlify-cli
   ```

2. **Deploy:**
   ```bash
   netlify deploy --prod
   ```
   Or connect your GitHub repository at [netlify.com](https://netlify.com).

3. **Configure `netlify.toml`:**
   ```toml
   [build]
     command = "npm run build"
     publish = "dist"

   [[redirects]]
     from = "/*"
     to = "/index.html"
     status = 200
   ```

4. **Environment variables:**
   - Go to Site Settings > Build & Deploy > Environment
   - Add all production environment variables

---

### Railway

**Recommended for:** Full-stack apps that need a backend runtime.

1. **Create a Railway project** at [railway.app](https://railway.app)

2. **Connect your repository**

3. **Configure build settings:**
   ```
   Build Command: npm run build
   Start Command: npx serve dist -s -l 3000
   ```

4. **Add environment variables** in the Railway dashboard

5. **Add a custom domain** in Settings > Domains

---

### Self-Hosted (Docker)

**Recommended for:** Teams with existing infrastructure or specific compliance requirements.

1. **Build the Docker image:**
   ```dockerfile
   # Dockerfile
   FROM node:20-alpine AS builder
   WORKDIR /app
   COPY package*.json ./
   RUN npm ci
   COPY . .
   RUN npm run build

   FROM nginx:alpine
   COPY --from=builder /app/dist /usr/share/nginx/html
   COPY nginx.conf /etc/nginx/conf.d/default.conf
   EXPOSE 80
   ```

2. **Nginx configuration:**
   ```nginx
   # nginx.conf
   server {
       listen 80;
       root /usr/share/nginx/html;
       index index.html;

       location / {
           try_files $uri $uri/ /index.html;
       }

       location /assets/ {
           expires 1y;
           add_header Cache-Control "public, immutable";
       }
   }
   ```

3. **Build and run:**
   ```bash
   docker build -t [YOUR_APP_NAME] .
   docker run -p 80:80 [YOUR_APP_NAME]
   ```

---

## DNS & SSL

### Domain Configuration

| Record Type | Name | Value | TTL |
|-------------|------|-------|-----|
| A | `@` | [Your hosting IP] | 300 |
| CNAME | `www` | [Your hosting domain] | 300 |
| CNAME | `api` | [Your API hosting domain] | 300 |

<!-- TEMPLATE: Add any additional DNS records your setup requires -->
<!-- (email verification, CDN, etc.) -->

### SSL/TLS

- **Vercel/Netlify**: SSL is automatic. No configuration needed.
- **Railway**: SSL is automatic for custom domains.
- **Self-hosted**: Use [Let's Encrypt](https://letsencrypt.org/) with Certbot or your reverse proxy's built-in ACME support.

---

## Environment Variables

### Production Environment Variables

<!-- TEMPLATE: List all environment variables needed for production. -->
<!-- Mark which are required vs optional. -->

| Variable | Required | Where to Get It |
|----------|----------|----------------|
| `VITE_APP_NAME` | Yes | Your app name |
| `VITE_APP_URL` | Yes | Your production URL |
| `VITE_APP_ENV` | Yes | Set to `production` |
| `VITE_DEMO_MODE` | Yes | Set to `false` |
| `VITE_SUPABASE_URL` | If using Supabase | Supabase Dashboard > Settings > API |
| `VITE_SUPABASE_ANON_KEY` | If using Supabase | Supabase Dashboard > Settings > API |
| `VITE_STRIPE_PUBLISHABLE_KEY` | If using Stripe | Stripe Dashboard > Developers > API Keys |
| `STRIPE_SECRET_KEY` | If using Stripe | Stripe Dashboard (server-side only) |
| `STRIPE_WEBHOOK_SECRET` | If using Stripe | Stripe Dashboard > Webhooks |
| `VITE_SENTRY_DSN` | Recommended | Sentry Dashboard > Settings > DSN |

### Security Notes

- **Never expose** `SUPABASE_SERVICE_ROLE_KEY`, `STRIPE_SECRET_KEY`, or any server-side secrets in client-side code
- Variables prefixed with `VITE_` are included in the client bundle and visible to users
- Use your platform's secret management for server-side variables
- Rotate secrets immediately if they are accidentally committed to version control

---

## Monitoring

### Error Tracking (Sentry)

```typescript
// Already configured if VITE_SENTRY_DSN is set
// Verify in Sentry dashboard that errors are being captured
```

### Uptime Monitoring

Set up external monitoring for:

| Endpoint | Check Interval | Alert After |
|----------|---------------|-------------|
| `https://[YOUR_DOMAIN]` | 1 minute | 2 failures |
| `https://[YOUR_DOMAIN]/api/health` | 1 minute | 2 failures |

Recommended tools: UptimeRobot (free tier), Checkly, Pingdom, or Better Uptime.

### Application Performance

| Metric | Target | Tool |
|--------|--------|------|
| Core Web Vitals (LCP) | < 2.5s | Google Search Console |
| Core Web Vitals (FID) | < 100ms | Google Search Console |
| Core Web Vitals (CLS) | < 0.1 | Google Search Console |
| API response time (p95) | < 500ms | [Your APM tool] |
| Error rate | < 0.1% | Sentry |

---

## Post-Deployment Verification

After deploying, run through this checklist:

### Smoke Tests

- [ ] Homepage loads correctly
- [ ] Authentication flow works (signup, login, logout)
- [ ] Core feature works end-to-end
- [ ] Payment flow works (use Stripe test mode first)
- [ ] Email delivery works
- [ ] Error tracking captures a test error
- [ ] Analytics records a test event

### Performance

- [ ] Run Lighthouse on production URL (target 90+ on all categories)
- [ ] Check bundle size is within budget
- [ ] Verify CDN caching is working (`Cache-Control` headers)
- [ ] Test on mobile devices and slow connections

### Security

- [ ] HTTPS is working (no mixed content warnings)
- [ ] Security headers are set (check with [securityheaders.com](https://securityheaders.com))
- [ ] Environment variables are not exposed in client source
- [ ] API endpoints require authentication where expected
- [ ] CORS is configured correctly for your domain

---

## Rollback Plan

If something goes wrong:

### Vercel / Netlify
```bash
# Vercel: Revert to previous deployment
vercel rollback

# Netlify: Use the deploy history in the dashboard
```

### Railway
```bash
# Use the deployment history in the Railway dashboard
```

### Self-Hosted
```bash
# If using Docker with tagged images
docker pull [YOUR_APP_NAME]:[PREVIOUS_VERSION]
docker stop [CONTAINER_ID]
docker run -p 80:80 [YOUR_APP_NAME]:[PREVIOUS_VERSION]
```

---

## Continuous Deployment

### GitHub Actions Example

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm run lint
      - run: npm run build
      # Add your deployment step here based on your platform
```

<!-- TEMPLATE: Customize the CI/CD pipeline for your platform and testing needs. -->

---

*For initial setup, see [SETUP_GUIDE.md](SETUP_GUIDE.md). For architecture details, see [ARCHITECTURE.md](ARCHITECTURE.md).*
