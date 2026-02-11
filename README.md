# SaaS-Viber

**The integrated SaaS shell for agentic coding and vibe coders.**

Just ask your Openclaw to integrate this, so you incorporate a really well-organized set of files that covers all bases and asks you the questions to fill in what you need to.  Let it document but let it document well! So that it may do it well for you and you will thrive! :)

SaaS-Viber is a comprehensive template repository that gives you the file structure, documentation templates, prompt guides, and decision frameworks to launch a SaaS product quickly using AI-assisted development. It is not a boilerplate with pre-built UI components or a starter kit tied to a specific stack. It is the *layer beneath that* -- the thinking, planning, and organizational scaffolding that turns a vibe-coded prototype into a shippable product.

### What You Get

- **Decision frameworks** for the choices that matter (auth, payments, backend, hosting)
- **Prompt guides** tuned for agentic coding workflows (Cursor, Claude Code, Copilot)
- **Documentation templates** that scale from solo founder to team
- **Architecture patterns** for the most common SaaS shapes
- **Launch checklists** so nothing slips through the cracks

### Who This Is For

- Solo founders building with AI-assisted development tools
- Small teams that move fast and need structure without ceremony
- Anyone who has ever said "I'll document this later" and never did

### First Time Here?

**[START_HERE.md](START_HERE.md)** -- Beginner and expert paths, your first AI prompt, and a complete file map.

Agent config files are ready to go:
- **Claude Code** users: `CLAUDE.md` auto-loads at session start
- **Cursor** users: `.cursorrules` auto-loads project context

---

<!-- TEMPLATE: Everything below this line is YOUR product's README. -->
<!-- Replace the SaaS-Viber header above with your own once you've filled in the sections. -->
<!-- You can keep the SaaS-Viber attribution at the bottom if you'd like. -->

## [Your Product Name]

<!-- TEMPLATE: Replace with your product name and a one-line tagline. -->
<!-- Example: "Acme Analytics -- Real-time insights for teams that ship." -->

> [One-line tagline that captures the value proposition]

<!-- TEMPLATE: Add 1-2 sentences expanding on the tagline. What does your product do, -->
<!-- who is it for, and why should they care? Keep it under 50 words. -->

[Brief description of your product. What problem does it solve? For whom?]

---

## Features

<!-- TEMPLATE: List your core features. Aim for 4-8 items. Use this structure: -->
<!-- Each feature gets an emoji (optional), a short name, and a one-liner. -->
<!-- Organize by user value, not by technical component. -->

| Feature | Description |
|---------|-------------|
| [Feature 1] | [What it does and why it matters] |
| [Feature 2] | [What it does and why it matters] |
| [Feature 3] | [What it does and why it matters] |
| [Feature 4] | [What it does and why it matters] |

<!-- TEMPLATE: If you have a demo or screenshots, add them here: -->
<!-- ![Screenshot description](docs/assets/screenshot.png) -->
<!-- [Live Demo](https://your-demo-url.com) -->

---

## Tech Stack

<!-- TEMPLATE: Fill in your actual stack. Remove rows you don't use. -->
<!-- Reference decisions/ folder for rationale behind each choice. -->

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| **Frontend** | [e.g., React + TypeScript] | [Why you chose it] |
| **Styling** | [e.g., Tailwind CSS + shadcn/ui] | [Why you chose it] |
| **Backend** | [e.g., Supabase / Firebase / Custom] | See `decisions/BACKEND_CHOICES.md` |
| **Auth** | [e.g., Supabase Auth / Auth0 / Clerk] | See `decisions/AUTH_CHOICES.md` |
| **Database** | [e.g., PostgreSQL via Supabase] | [Why you chose it] |
| **Payments** | [e.g., Stripe] | See `decisions/PAYMENT_CHOICES.md` |
| **Hosting** | [e.g., Vercel / Netlify / Railway] | See `decisions/PLATFORM_CHOICES.md` |
| **Email** | [e.g., Resend / SendGrid] | [Why you chose it] |
| **Monitoring** | [e.g., Sentry + PostHog] | [Why you chose it] |

---

## Quick Start

<!-- TEMPLATE: Keep this short. Link to QUICKSTART.md for the full version. -->
<!-- The goal is: clone, install, run, see something in under 2 minutes. -->

```bash
git clone https://github.com/[YOUR_GITHUB_USER]/[YOUR_REPO_NAME].git
cd [YOUR_REPO_NAME]
npm install
cp .env.example .env
# Fill in your .env values (see SETUP_GUIDE.md)
npm run dev
```

Open [http://localhost:8080](http://localhost:8080) to see your app.

For the full setup walkthrough, see **[QUICKSTART.md](QUICKSTART.md)**.

---

## Architecture

<!-- TEMPLATE: Provide a brief (3-5 sentence) overview of your system architecture. -->
<!-- The full details live in ARCHITECTURE.md and docs/architecture/. -->

[Brief architecture overview. What are the major components? How do they communicate?]

For the full architecture documentation, diagrams, and design decisions, see **[ARCHITECTURE.md](ARCHITECTURE.md)**.

---

## Documentation

<!-- TEMPLATE: Once you've populated the docs/ folder, this section serves as the map. -->
<!-- Reference docs/INDEX.md as the master documentation index. -->

All documentation lives in the `docs/` directory. Start with the index:

- **[docs/INDEX.md](docs/INDEX.md)** -- Master documentation index
- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** -- Phase-by-phase setup from clone to launch
- **[QUICKSTART.md](QUICKSTART.md)** -- Get running in 2 minutes
- **[ARCHITECTURE.md](ARCHITECTURE.md)** -- System architecture overview
- **[DEPLOYMENT.md](DEPLOYMENT.md)** -- Production deployment guide
- **[DATA_INTEROPERABILITY.md](DATA_INTEROPERABILITY.md)** -- Data ownership and portability

### Prompt Guides

<!-- TEMPLATE: List the prompt guides in your prompts/ directory. -->
<!-- These are designed for use with AI coding assistants. -->

| Guide | Purpose |
|-------|---------|
| `prompts/PromptGuide-PRD.md` | Writing product requirement documents |
| `prompts/PromptGuide-Architecture.md` | Generating architecture documentation |
| `prompts/PromptGuide-Feature.md` | Implementing features with AI assistance |
| `prompts/PromptGuide-Debug.md` | Structured debugging workflows |
| `prompts/PromptGuide-Migration.md` | Database migration planning |

---

## Project Structure

<!-- TEMPLATE: Update this tree to match your actual project structure. -->
<!-- Run `tree -I node_modules -L 3` to generate it, then clean up. -->

```
[YOUR_REPO_NAME]/
├── public/                  # Static assets
│   ├── favicon.ico
│   └── manifest.json
├── src/
│   ├── components/          # Reusable UI components
│   │   ├── ui/              # shadcn/ui primitives
│   │   └── [feature]/       # Feature-specific components
│   ├── hooks/               # Custom React hooks
│   ├── lib/                 # Utilities and helpers
│   ├── pages/               # Route-level components
│   ├── services/            # API and external service clients
│   ├── stores/              # State management
│   ├── types/               # TypeScript type definitions
│   └── App.tsx              # Root component
├── docs/                    # Documentation
│   ├── INDEX.md             # Documentation index
│   ├── architecture/        # Architecture docs
│   └── assets/              # Documentation images
├── prompts/                 # AI coding prompt guides
├── decisions/               # Architecture Decision Records
├── scripts/                 # Build and utility scripts
├── supabase/                # Supabase config (if applicable)
│   └── migrations/          # Database migrations
├── .env.example             # Environment variable template
├── package.json
├── vite.config.ts
├── tailwind.config.ts
├── tsconfig.json
└── README.md                # This file
```

---

## Setup Guide

<!-- TEMPLATE: Brief pointer to the full setup guide. -->

For a complete phase-by-phase walkthrough from cloning to launching your SaaS, see **[SETUP_GUIDE.md](SETUP_GUIDE.md)**.

The setup guide covers:
1. Foundation -- Key decisions and environment configuration
2. Identity -- Branding, design tokens, and assets
3. Architecture -- Domain model, roles, and database schema
4. Core Features -- Building with PRDs and prompt guides
5. Operations -- Deployment, monitoring, and error tracking
6. Growth -- SEO, analytics, and localization
7. Launch Prep -- App store readiness and security audit

---

## Key Decisions

<!-- TEMPLATE: The decisions/ folder contains Architecture Decision Records (ADRs). -->
<!-- Each file documents a choice, the alternatives considered, and the rationale. -->

Key architectural decisions are documented in the `decisions/` folder:

| Decision | File |
|----------|------|
| Backend platform | `decisions/BACKEND_CHOICES.md` |
| Authentication provider | `decisions/AUTH_CHOICES.md` |
| Payment processing | `decisions/PAYMENT_CHOICES.md` |
| Hosting platform | `decisions/PLATFORM_CHOICES.md` |

<!-- TEMPLATE: Add rows as you make more decisions. The pattern is: -->
<!-- one file per decision, with context, options, and rationale. -->

---

## Contributing

<!-- TEMPLATE: If your project is open source, flesh this section out. -->
<!-- If it's closed source, you can remove it or keep it for internal contributors. -->
<!-- See the opensource/ folder for templates (CODE_OF_CONDUCT, CONTRIBUTING guide). -->

[Contribution guidelines here. Reference `CONTRIBUTING.md` if you have one.]

<!-- TEMPLATE: Standard contribution workflow: -->
<!-- 1. Fork the repository -->
<!-- 2. Create a feature branch (`git checkout -b feature/your-feature`) -->
<!-- 3. Commit your changes (`git commit -m 'Add your feature'`) -->
<!-- 4. Push to the branch (`git push origin feature/your-feature`) -->
<!-- 5. Open a Pull Request -->

---

## License

<!-- TEMPLATE: Replace with your chosen license. See the LICENSE file for a -->
<!-- selection guide if you haven't decided yet. -->

[Your chosen license]. See [LICENSE](LICENSE) for details.

Copyright (c) [YEAR] [YOUR_COMPANY].

---

## Acknowledgments

<!-- TEMPLATE: Credit the tools, libraries, people, and communities that -->
<!-- helped make your product possible. This section is optional but classy. -->

- Built with [SaaS-Viber](https://github.com/craftled/SaaS-Viber) -- the integrated SaaS shell for agentic coding
- [List other acknowledgments: libraries, inspirations, contributors]

<!-- TEMPLATE: Remove this comment block when you're done filling in the README. -->
<!-- Your README is the front door of your project. Make it count. -->
