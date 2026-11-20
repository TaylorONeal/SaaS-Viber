---
name: backlink-directories
description: Plan and run free directory listings for a portfolio of public sites, apps and open-source repos - pre-flight fixes (canonical, duplicate hosts, honest meta), matching each property to directories that fit, checking rel and terms before submitting, one listing copy kit, a tracking sheet, a browser-agent brief that stops for the human at every account, terms and submit, and a launch-day queue. Load for "get backlinks", "submit to directories", "list my app on Product Hunt / AlternativeTo / SaaSHub", or turning a "100 free backlink sites" list into a real plan.
---

# Backlink Directories Skill

Works for any mix of public properties: SaaS sites, mobile apps, open-source
repos, a personal site, a studio or company page. Read the whole file once,
then run the phases in order. Knowledge current as of late 2026; anything
marked **verify** changes often, so check the directory's own page before
relying on it.

This skill covers off-site listings. Getting the site itself crawled and
indexed is `skills/search-indexing-skill/SKILL.md`; do that first.

---

## 0. Ground rules

1. **Never pay.** If a step asks for a card, a fast-track fee, a paid plan or a
   "featured" upgrade, skip that directory and record why. Free tiers only,
   unless the owner says otherwise in writing.
2. **The human approves every account, terms acceptance and final submit.**
   An agent may research, draft copy, open the exact page and fill every field.
   It stops for passwords, email confirmation links, CAPTCHAs and the yes.
   Ask for one yes per batch, not per field.
3. **No secrets or logins in the repo.** Record which login each directory
   uses (for example "GitHub sign-in" or "the listings inbox"), never the
   password. Private details stay in a gitignored file or the owner's sheet.
4. **Public contact details only.** Use a dedicated listings or support inbox,
   never a personal address or phone number. City and region only, never a
   street address.
5. **One listing per directory per property.** No upvote rings, no duplicate
   listings, no paid reviews. If a listing already exists, claim or update it.
6. **Honest copy.** Describe what ships today. No category or tag the product
   doesn't fit (do not pick "AI" tags for a product that isn't AI just because
   a form suggests them). No invented user counts, ratings or awards.
7. **Evidence or it did not happen.** A row is `live` only with the live
   listing URL recorded and its link inspected (section 6).
8. **Quality over count.** A "100 free backlink sites" list is a lead list,
   not a plan. Most entries are nofollow, paid, badge-gated, dead or off-topic
   for a given property. Ten fitting listings beat a hundred spammy ones, and
   mass low-quality links can hurt.

---

## 1. Inventory and pre-flight

Build one table of every public property before matching anything.

| Field | Why |
|---|---|
| Name, type (SaaS, mobile app, OSS repo, personal, company) | Directories are type-specific |
| Canonical URL | The one address every listing should use |
| Store links (iOS, Android) and repo URL | Some directories want these instead |
| Status: live, launch-day, fix-first, skip | Only `live` goes in the first run |
| Contact email for listings | Public, never personal |

Sources: the hosting dashboard's domain list, the public repo list, the app
store developer pages. Load each URL and read its `<head>`.

**Fix before listing.** Every listing copies what it finds, so fix these
first or the links point at the wrong thing:

- **Duplicate hosts.** If a platform subdomain (for example
  `project.vercel.app` or `project.netlify.app`) serves the same site as the
  custom domain, add a permanent host redirect to the custom domain.
- **Canonical and `og:url`** must be the real public address, never
  `localhost`, a preview URL or another company's domain.
- **`noindex`** on a page you are about to list means the link is wasted.
  Either finish the site or keep it out of this run.
- **Meta description** must match the page. "Free on iPhone" on a page that
  says "Coming soon" is the snippet every directory will copy.
- **Repo About > Website** field and README links should point at the
  canonical domain, not a demo host.
- **Client-only rendering.** If the HTML a crawler gets has no text, many
  directories reject the site and search engines see little. Prerender at
  least the home page.

Ship these fixes as small reviewable changes and mark the property
`fix-first` until they're live.

---

## 2. Match properties to directories

Match by property type, then by audience. A consumer app does not belong on
developer tool lists; an OSS repo does not belong on app store alternatives.

| Property type | Usually worth it | Usually skip |
|---|---|---|
| Open-source repo | LibHunt, a write-up on dev.to with a Hashnode cross-post (canonical to the original), relevant GitHub awesome lists (by pull request, per their rules), SourceForge import | App directories, AI directories |
| SaaS / web app | SaaSHub (verify the listing to make the link followed), AlternativeTo (as an alternative to named competitors), Crozdesk, Capterra / GetApp / Software Advice and G2 free profiles (registered business required), launch sites with a free queue | Directories that charge for the link |
| Mobile app | AlternativeTo, launch sites with a free queue, Product Hunt on launch day | SaaS review sites, developer lists |
| Person (founder, consultant) | dev.to profile, Peerlist, Gravatar, about.me, Crunchbase person, Devpost portfolio | Paid "expert" directories |
| Company / studio | Crunchbase company, Starter Story (interview), a Product Hunt maker profile | Paid business listings |
| AI product (only if it is one) | Two or three AI directories with a free tier | Everything else on AI lists |

**verify** for every directory: free tier still exists, what it requires,
whether the link is followed, and whether the category fits.

Notes that held through late 2026 (**verify** each):

- Product Hunt, AlternativeTo, Peerlist, Crunchbase: useful for discovery and
  brand searches, but their outbound links are `nofollow` or `ugc`.
- dev.to and LibHunt have historically passed followed links; SaaSHub does
  once the listing is verified.
- G2 bought Capterra, GetApp and Software Advice in early 2026. The free
  vendor listing on the Capterra side has historically covered all three.
  These sites want a registered business entity.
- Some directories list you free only if you show their badge on your site
  (section 7). Others charge for "dofollow". Read the terms page, not the
  marketing page.

---

## 3. Check before you submit

For each candidate directory, record in the sheet:

1. Submit URL (the real form, not the home page).
2. Login method: GitHub sign-in, LinkedIn, or email sign-up with the listings
   inbox. Avoid signing in with a personal Google account.
3. Free tier conditions: none, badge required, queue wait, review required.
4. Expected link: followed, nofollow, ugc, sponsored, or unknown.
5. Anything that needs a business entity, an ID check or a payment method.

Drop anything that needs payment, a payment method on file "just in case",
or an ID check the owner didn't agree to.

**Accounts.** Before planning a sign-up, check whether the owner already has
an account there (search their inbox for mail from the directory). An old
account skips new-account waiting periods and looks less like spam. Create
new accounts only while the owner is at the keyboard: confirmation links
often expire within a day, and an unconfirmed account blocks every listing
behind it.

---

## 4. Listing copy kit

Write once per property, reuse everywhere, word for word:

- Name
- Canonical URL, store links, repo URL
- Tagline (60 characters)
- Short description (160 characters)
- Long description (80 to 150 words, plain, first person plural or neutral)
- Category and 3 to 5 tags that are true
- Pricing in one line, as the product's own site states it
- "Alternative to" list: named competitors the product genuinely replaces
- Logo and OG image URLs (absolute, already live)
- Public contact email

Copy rules: specific over clever, no hype words, no claims the site doesn't
make, no category the product doesn't fit. Read the product's own page and
store listing first and use only facts from them.

Write-ups (dev.to, Hashnode, a blog) are drafts for the owner to publish.
600 to 900 words, first person, what it is, why it exists, how it works,
one or two links back. A cross-post sets its canonical URL to the original.

---

## 5. Tracking sheet

Use `references/tracker-template.csv`. One row per directory per property.
Statuses: `todo`, `submitted`, `in-queue`, `live`, `skipped-paid`,
`skipped-badge`, `rejected`, `blocked` (with the reason), `launch-day`.

Keep it in the owner's own spreadsheet, not in a public repo, because it
names their accounts and inboxes.

---

## 6. Run it in batches

Group rows into batches the owner can approve in one yes:

| Batch | What | Why first |
|---|---|---|
| 0 | Pre-flight fixes (section 1) | Every later link copies them |
| 1 | No-account submissions (for example LibHunt) | Zero risk, fast |
| 2 | Write-ups saved as drafts | Highest-value followed links |
| 3 | SaaS directories | Need verification steps |
| 4 | App and launch directories | Some have queues, start the clock |
| 5 | Person and company profiles | Slow, many confirmations |

Hand a browser agent `references/browser-agent-brief.md`, filled in with the
copy kit and the batch list. After each listing goes live: open it, inspect
the link to the property, and record `rel` and the live URL.

**Order by status, then by batch.** Within every batch, do the properties
that are live and earning first. It is easy to finish the easy rows (repos,
no-account sites) and end a run with ten links for side projects and none for
the one product people can buy. Check the sheet for that before calling a
run done.

Pace: a few listings an hour, not a script. Directories ban accounts that
look automated.

**Parking and resuming.** If the owner parks the run, write down each step
that waits on them (page, account, what is already filled in) and stop
asking. When they bring it back, re-read the sheet, re-check anything that
expires (confirmation links, queues, free tiers) and start with their
shortest steps.

---

## 7. Badge-gated directories

Several launch sites list you free only if your site shows their "Featured
on" badge, usually an image link back to your listing on their site.

Decide per property, with the owner:

- **Where:** a single footer row on the marketing site, never in the app UI.
- **How many:** three or four at most. A footer stuffed with badges reads as a
  link farm to visitors and to search engines.
- **Link type:** keep the badge link as the directory requires (some check it
  is followed). It is an outbound link from your site; that's the trade.
- **Removal:** once the listing is approved and the queue has passed, ask
  whether the terms let you remove the badge. Some delist you if you do.
- **Look:** monochrome or small versions where the directory offers them, same
  height, one row, labelled "Featured on".

Never add badges to a site whose owner hasn't agreed to that specific site.

---

## 8. Launch-day queue and launch calendar

Properties not live yet (an app waiting on store review, a site still
`noindex`) go in the sheet as `launch-day` rows. On the day the store page is
live:

1. Add the store links to every existing listing of that product.
2. Submit to the launch sites that care about recency (Product Hunt, launch
   queues).
3. Launch on Product Hunt at 12:01am Pacific; have the maker profile, gallery
   and first comment ready the day before. Ask for feedback, never upvotes.

**Setting dates.** With more than one product, write a launch calendar: one
row per product with the date, the gate and the state. Fill `planned_date`
and `gate` in the sheet for each launch-day row.

- **Name the goal first.** A listing, badge and link is a different job from
  installs. If the product's buyers are not on a launch site, plan a small
  launch there and spend the effort on the channel where they are.
- **Use the owner's calendar.** Someone has to answer comments all day. Pick
  days they are at a desk: no travel days, no holidays. When they give a date
  relative to something else ("when I'm back", "same as the other one"),
  restate it as a calendar date and get a yes before writing it anywhere.
- **Every date has a gate.** The product must be public and usable on the day
  (store page live, sign-up open). Check the gate two days before. If it is
  still open, move the date. Do not launch a waitlist page to keep a date.
- **Weekday or weekend.** Weekends bring less traffic and less competition.
  Fine for a listing-and-badge goal, weak for an installs goal. **verify**
  how the site ranks and features launches before relying on this.
- **Spacing.** Two launches from one maker on one day share one supporter
  list. Space them when reach matters; the same day is fine when the owner's
  time is the limit. It is the owner's call: say the tradeoff once, then
  record the choice.
- **New accounts wait.** Product Hunt has made new personal accounts wait
  about a week before posting (**verify**). Count that into the first date.
- **Measure it.** Confirm the landing page is counted by analytics before the
  day, and give each launch site its own campaign tag.
- **Write it down once.** Put the calendar and the reasons in the project's
  decision log, and the per-directory rows in the sheet. A date that lives
  only in a chat is gone by the next session.

---

## 9. After the run

- Re-check `rel` on a sample of live listings a month later; directories
  change terms.
- Update listings when pricing, the domain or the store links change.
- Record lessons (slow queues, changed terms, dead directories) in the
  plan so the next run skips them.
- Track referral sessions per directory in analytics
  (`skills/analytics-reports-skill/SKILL.md`) and drop the ones that send
  nothing after a quarter.
