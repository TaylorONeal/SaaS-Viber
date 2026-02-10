# Development Environment Setup

> Everything you need to clone, configure, and run the project locally.

## Prerequisites

| Requirement | Minimum Version | Check Command |
|-------------|-----------------|---------------|
| Node.js | v18.x (LTS) | `node --version` |
| npm / pnpm / yarn | npm 9+ / pnpm 8+ | `npm --version` |
| Git | 2.30+ | `git --version` |
| Docker (optional) | 20.x | `docker --version` |

---

## Clone and Install

```bash
git clone {REPO_URL}
cd {PROJECT_NAME}
npm install    # or: pnpm install / yarn install
```

---

## Environment Configuration

```bash
cp .env.example .env.local
```

```bash
# .env.local
APP_NAME="{YOUR_APP_NAME}"
APP_URL=http://localhost:3000
NODE_ENV=development

BACKEND_PROVIDER=mock              # mock | supabase | firebase | custom
DATABASE_URL=postgresql://{USER}:{PASSWORD}@localhost:5432/{DB_NAME}

AUTH_SECRET={RANDOM_32_CHAR_STRING}
AUTH_PROVIDER=custom               # custom | auth0 | clerk

STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

EMAIL_PROVIDER=console             # console | resend | sendgrid | smtp
EMAIL_FROM="Dev <noreply@localhost>"

STORAGE_PROVIDER=local             # local | s3 | r2
```

> **Security**: Never commit `.env.local`. It is listed in `.gitignore`.

---

## Backend Setup

### Option A: Mock Backend (fastest start)
No setup required. In-memory data resets on restart.

### Option B: Local Database with Docker
```bash
docker compose up -d postgres
npm run db:migrate
npm run db:seed    # optional
```

### Option C: Supabase
```bash
npx supabase init && npx supabase start
# Set SUPABASE_URL and keys from output
```

### Option D: Firebase
```bash
npm install -g firebase-tools
firebase login && firebase init
# Set FIREBASE_PROJECT_ID and keys
```

---

## Running Locally

```bash
npm run dev    # App at http://localhost:3000
```

| Command | Description |
|---------|-------------|
| `npm run dev` | Development server with hot reload |
| `npm run build` | Production build |
| `npm run lint` | Run ESLint |
| `npm run typecheck` | TypeScript compiler check |
| `npm run db:migrate` | Run database migrations |
| `npm run db:seed` | Seed sample data |

---

## Running Tests

```bash
npm run test              # Unit tests
npm run test:watch        # Watch mode
npm run test:integration  # Integration (requires backend)
npm run test:e2e          # End-to-end
npm run test:coverage     # Coverage report
```

---

## Common Issues

### Port already in use
```bash
lsof -i :3000 && kill -9 {PID}
# Or: PORT=3001 npm run dev
```

### Database connection refused
```bash
docker compose ps          # Check if running
docker compose restart postgres
```

### Node version mismatch
```bash
nvm use     # reads .nvmrc
```

### TypeScript errors after pull
```bash
npm run generate           # Regenerate types
rm -rf node_modules/.cache && npx tsc --build --clean
```

---

## IDE Setup

### VS Code Extensions
```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "bradlc.vscode-tailwindcss",
    "bierner.markdown-mermaid",
    "prisma.prisma"
  ]
}
```

### VS Code Settings
```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": { "source.fixAll.eslint": "explicit" },
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

---

## Related Docs

- [Architecture](./02-architecture.md) -- System overview before diving in
- [Backend Flexibility](./backend-flexibility.md) -- Understanding provider options
- [Payments Setup](./payments-setup.md) -- Configuring Stripe locally
