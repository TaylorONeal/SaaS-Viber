# Supabase Setup Guide

Everything you need to go from zero to a production-ready Supabase backend. This guide assumes you are using Supabase as your primary backend (auth, database, storage, edge functions).

---

## 1. Create Your Project

### On Supabase Dashboard

1. Go to https://supabase.com/dashboard
2. Click "New Project"
3. Choose your organization (create one if needed)
4. Set a **strong database password** -- save it in your password manager immediately
5. Choose the region closest to your users
6. Wait for provisioning (usually 1-2 minutes)

### Save These Values

After creation, go to Settings > API and record:

```
NEXT_PUBLIC_SUPABASE_URL=https://yourproject.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_ROLE_KEY=eyJ...    # NEVER expose this client-side
```

Put them in your `.env.local` for development. Put them in your hosting platform's environment variables for production.

**Critical**: The service role key bypasses Row Level Security. It goes in server-side code only. If it leaks, rotate it immediately in the Supabase dashboard.

---

## 2. Configure Authentication

### Enable Providers

Go to Authentication > Providers and enable what you need:

- [ ] **Email/Password** -- Enable by default. Consider requiring email confirmation.
- [ ] **Magic Link** -- Passwordless email login. Good UX, enable alongside password.
- [ ] **Google OAuth** -- Highest adoption. Set up in Google Cloud Console first.
- [ ] **GitHub OAuth** -- Good for developer-focused products.
- [ ] **Apple OAuth** -- Required if you ship an iOS app with social login.

### Email Templates

Go to Authentication > Email Templates and customize:

- [ ] **Confirmation email** -- Sent on signup. Brand it, make the CTA clear.
- [ ] **Magic link email** -- Should look intentional, not like spam.
- [ ] **Password reset** -- Clear subject line, obvious reset button.
- [ ] **Email change confirmation** -- Often forgotten. Customize it.

Tips:
- Keep email templates simple. Complex HTML breaks in Outlook.
- Set the sender name to your product name, not "Supabase".
- Test every template by triggering it manually.

### Redirect URLs

Go to Authentication > URL Configuration:

- [ ] Set **Site URL** to your production URL (`https://yourapp.com`)
- [ ] Add **Redirect URLs** for all environments:
  - `http://localhost:3000/**` (local dev)
  - `https://your-staging-url.com/**` (staging)
  - `https://yourapp.com/**` (production)

The `/**` wildcard allows deep-link redirects after auth.

### Auth Settings

- [ ] Set JWT expiry (default 3600s is fine for most apps)
- [ ] Enable/disable user signups based on your launch stage
- [ ] Configure rate limits if you expect abuse

---

## 3. Database Setup

### Running Migrations

If your project uses a migrations folder:

```bash
# Apply all pending migrations
supabase db push

# Or if using a migration tool
supabase migration up
```

### Schema Best Practices

- [ ] Create a `public` schema for app data (default)
- [ ] Never modify the `auth` schema directly -- use Supabase's auth APIs
- [ ] Use UUIDs as primary keys (`gen_random_uuid()`)
- [ ] Add `created_at` and `updated_at` timestamps to every table
- [ ] Create indexes on columns you query frequently
- [ ] Use foreign keys to enforce data integrity

### Example Base Table Pattern

```sql
create table public.profiles (
  id uuid references auth.users(id) on delete cascade primary key,
  display_name text,
  avatar_url text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

-- Auto-update updated_at
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger set_updated_at
  before update on public.profiles
  for each row execute function public.handle_updated_at();
```

---

## 4. Storage Buckets

### Create Buckets

Go to Storage in the dashboard or use SQL:

```sql
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true);

insert into storage.buckets (id, name, public)
values ('documents', 'documents', false);
```

### Common Buckets

| Bucket | Public | Use Case |
|---|---|---|
| `avatars` | Yes | User profile pictures |
| `uploads` | No | User-uploaded files |
| `assets` | Yes | App assets (images, icons) |

### Storage Policies

Every bucket needs RLS policies:

```sql
-- Users can upload their own avatar
create policy "Users can upload avatars"
  on storage.objects for insert
  with check (
    bucket_id = 'avatars'
    and auth.uid()::text = (storage.foldername(name))[1]
  );

-- Anyone can view avatars (public bucket)
create policy "Public avatar access"
  on storage.objects for select
  using (bucket_id = 'avatars');
```

- [ ] Set file size limits per bucket
- [ ] Restrict allowed MIME types if possible
- [ ] Set up a cleanup job for orphaned files

---

## 5. Edge Functions

### When to Use Edge Functions

- Webhook handlers (Stripe, third-party integrations)
- Server-side logic that needs the service role key
- API endpoints that cannot run client-side
- Scheduled tasks (via pg_cron + edge function trigger)

### Creating a Function

```bash
supabase functions new my-function
```

### Deploying

```bash
supabase functions deploy my-function
```

### Setting Secrets

```bash
supabase secrets set STRIPE_SECRET_KEY=sk_live_...
```

- [ ] Never hardcode secrets in function code
- [ ] Test functions locally with `supabase functions serve`
- [ ] Set proper CORS headers for browser-callable functions

---

## 6. Row Level Security (RLS)

**RLS is mandatory.** Every table in `public` schema must have RLS enabled with appropriate policies. A table with RLS enabled but no policies allows zero access -- this is the safe default.

### Enable RLS

```sql
alter table public.profiles enable row level security;
```

### Common Policy Patterns

**Users can read their own data:**
```sql
create policy "Users read own data"
  on public.profiles for select
  using (auth.uid() = id);
```

**Users can update their own data:**
```sql
create policy "Users update own data"
  on public.profiles for update
  using (auth.uid() = id);
```

**Public read, authenticated write:**
```sql
create policy "Public read"
  on public.posts for select
  using (true);

create policy "Authenticated insert"
  on public.posts for insert
  with check (auth.uid() is not null);
```

### RLS Checklist

- [ ] RLS enabled on every table in public schema
- [ ] Every table has at least a SELECT policy
- [ ] Test policies by querying as different users
- [ ] Service role key bypasses RLS -- use it sparingly and only server-side
- [ ] Review policies when you add new tables or columns

---

## 7. Environment Variables

### Required Variables

```bash
# Public (safe for client-side)
NEXT_PUBLIC_SUPABASE_URL=https://yourproject.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...

# Private (server-side only)
SUPABASE_SERVICE_ROLE_KEY=eyJ...
DATABASE_URL=postgresql://postgres:password@db.yourproject.supabase.co:5432/postgres
```

### Per-Environment Setup

| Variable | Local | Staging | Production |
|---|---|---|---|
| `SUPABASE_URL` | Local or dev project | Staging project | Production project |
| `ANON_KEY` | From dev project | From staging | From production |
| `SERVICE_ROLE_KEY` | From dev project | From staging | From production |

- [ ] Use separate Supabase projects for staging and production
- [ ] Never commit `.env` files to version control
- [ ] Document all required variables in `.env.example`

---

## 8. Local Development with Supabase CLI

### Install the CLI

```bash
# macOS
brew install supabase/tap/supabase

# npm (any platform)
npx supabase init
```

### Start Local Supabase

```bash
supabase start
```

This spins up a local Postgres, Auth, Storage, and Studio. The CLI prints local URLs and keys.

### Local Development Workflow

1. Make schema changes in migration files
2. Apply with `supabase db push` (local) or `supabase migration up`
3. Test locally against the local Supabase instance
4. Commit migration files to version control
5. Apply to staging/production via CI or `supabase db push --linked`

### Useful Commands

```bash
supabase status          # Show local service URLs and keys
supabase db diff         # Generate migration from schema changes
supabase db reset        # Reset local database to clean state
supabase gen types       # Generate TypeScript types from schema
```

- [ ] Run `supabase gen types` after every schema change and commit the output
- [ ] Add `supabase start` to your project's setup instructions

---

## 9. Production vs Staging

### Use Separate Projects

Do not use branching or environment tricks on a single project. Create distinct Supabase projects:

- **Development**: Local via CLI (free, fast, ephemeral)
- **Staging**: Separate Supabase project (free tier is fine)
- **Production**: Separate Supabase project (paid plan recommended)

### Production Hardening

- [ ] Enable Point-in-Time Recovery (requires Pro plan)
- [ ] Set up database backups (automatic on Pro, manual on Free)
- [ ] Enable network restrictions if available
- [ ] Review and tighten auth settings (disable unused providers)
- [ ] Set up monitoring/alerts for database size and connection count
- [ ] Configure connection pooling (use the pooler URL for serverless)
- [ ] Review RLS policies one final time before launch

### Migration Deployment

```bash
# Link to your production project
supabase link --project-ref your-project-ref

# Push migrations to production
supabase db push
```

- [ ] Always test migrations on staging first
- [ ] Back up production database before applying migrations
- [ ] Have a rollback plan for every migration

---

*Supabase gives you a lot for free. The key is getting RLS right and keeping your environments separate. Spend the time on security policies upfront -- retrofitting them is painful.*
