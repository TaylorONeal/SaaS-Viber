# Quick Start

> From zero to running in 2 minutes.

<!-- TEMPLATE: This guide gets a developer from clone to seeing your app run locally -->
<!-- as fast as possible. Save the details for SETUP_GUIDE.md -- this is the speed run. -->

---

## Prerequisites

<!-- TEMPLATE: List the minimum requirements. Keep this short. -->

Before you start, make sure you have:

| Requirement | Version | Check Command |
|-------------|---------|---------------|
| **Node.js** | 20.x or later | `node --version` |
| **npm** | 10.x or later | `npm --version` |
| **Git** | 2.x or later | `git --version` |

<!-- TEMPLATE: Add any other prerequisites your specific project needs: -->
<!-- | **Docker** | 24.x or later | `docker --version` | -->
<!-- | **Supabase CLI** | Latest | `supabase --version` | -->

Optional but recommended:

- A code editor with TypeScript support (VS Code, Cursor, etc.)
- An AI coding assistant (Claude Code, Cursor AI, GitHub Copilot)

---

## 1. Clone and Install

```bash
# Clone the repository
git clone https://github.com/[YOUR_GITHUB_USER]/[YOUR_REPO_NAME].git
cd [YOUR_REPO_NAME]

# Install dependencies
npm install
```

<!-- TEMPLATE: If your project uses a monorepo or has additional install steps, -->
<!-- document them here. Keep it to copy-pasteable commands. -->

---

## 2. Configure Environment

```bash
# Copy the environment template
cp .env.example .env
```

For the quick start, the defaults work out of the box with **demo mode enabled**. The app runs with mock data and no external services required.

<!-- TEMPLATE: If there are ANY required values even for demo mode, list them here: -->
<!-- Open `.env` and fill in these required values: -->
<!-- - `VITE_APP_NAME` -- Your application name -->
<!-- - `[OTHER_REQUIRED_KEY]` -- [What it's for and where to get it] -->

To connect real services (database, auth, payments), see the full **[SETUP_GUIDE.md](SETUP_GUIDE.md)**.

---

## 3. Start Development Server

```bash
npm run dev
```

You should see output like:

```
  VITE v5.x.x  ready in XXX ms

  ➜  Local:   http://localhost:8080/
  ➜  Network: http://192.168.x.x:8080/
  ➜  press h + enter to show help
```

---

## 4. Open Your App

Navigate to **[http://localhost:8080](http://localhost:8080)** in your browser.

### What You'll See

<!-- TEMPLATE: Describe what the user sees when they first open the app. -->
<!-- Include a screenshot if possible. This sets expectations and confirms things work. -->

| Page | What It Shows |
|------|--------------|
| **Landing page** | [Description of your landing/home page] |
| **Login** | [Description -- demo credentials if applicable] |
| **Dashboard** | [Description of the main authenticated view] |

<!-- TEMPLATE: If you have demo credentials, list them clearly: -->
<!--
**Demo Credentials:**
- Email: `demo@example.com`
- Password: `demo1234`
-->

<!-- TEMPLATE: Add a screenshot here: -->
<!-- ![Quick Start Screenshot](docs/assets/quickstart-screenshot.png) -->

---

## 5. Demo Mode

When `VITE_DEMO_MODE="true"` (the default), the app runs entirely in the browser with mock data:

- **Authentication** simulates login/signup without a real auth provider
- **Data** comes from local fixtures, not a database
- **Payments** shows UI flows without hitting Stripe
- **Email** logs to the console instead of sending

This lets you explore the full UI and user flows without configuring any external services.

To switch to real services, set `VITE_DEMO_MODE="false"` and configure the relevant environment variables. See **[SETUP_GUIDE.md](SETUP_GUIDE.md)** Phase 1.

---

## Common Issues

<!-- TEMPLATE: List the most common problems new developers hit and how to fix them. -->

| Issue | Solution |
|-------|----------|
| `Port 8080 already in use` | Kill the process on that port or change `VITE_APP_URL` in `.env` |
| `npm install` fails | Try deleting `node_modules` and `package-lock.json`, then `npm install` again |
| Blank page in browser | Check the browser console for errors. Usually a missing env variable. |
| TypeScript errors | Run `npx tsc --noEmit` to see the full error list |

<!-- TEMPLATE: Add project-specific issues as you discover them. -->

---

## Next Steps

Now that you're running locally:

1. **Explore the codebase** -- Start with `src/App.tsx` and follow the component tree
2. **Read the Setup Guide** -- [SETUP_GUIDE.md](SETUP_GUIDE.md) walks through each phase
3. **Make key decisions** -- Check the `decisions/` folder for backend, auth, and payment choices
4. **Build your first feature** -- Use `prompts/PromptGuide-Feature.md` with your AI assistant

---

## Available Scripts

| Command | What It Does |
|---------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Build for production |
| `npm run preview` | Preview production build locally |
| `npm run lint` | Run ESLint across the project |

<!-- TEMPLATE: Add any additional scripts your project has. -->

---

*For the full setup walkthrough, see [SETUP_GUIDE.md](SETUP_GUIDE.md). For deployment, see [DEPLOYMENT.md](DEPLOYMENT.md).*
