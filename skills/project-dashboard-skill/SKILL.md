---
name: project-dashboard
description: Build and keep current one live dashboard for a portfolio of products -- a row per product with a stage per platform, a "Waiting on you" list sorted by deadline and split into four buckets (your yes, only you, Cowork runs, agents doing), a supporting-work section, and links. Load when someone asks for a project or portfolio dashboard, a status page across several apps, or "what's waiting on me", and whenever a status change should land on an existing dashboard.
---

# Project Dashboard Skill

One page answers two questions for the owner of several products: where does
each product stand, and what is waiting on me. Agents keep it current; the
owner only reads it and answers the asks.

Template files: `docs/templates/project-dashboard/` (static page, example data,
Cowork script template). Read its README before building.

## 1. What the page shows, in this order

1. **Lede.** One sentence: how many things wait on the owner, across how many
   products, and the nearest deadline. One line: last checked time, and that
   nothing on the page was merged, submitted or paid.
2. **Board.** Core products as rows, platforms as columns (iOS, Android, Web
   by default; rename for your stack). Each cell is a stage chip.
3. **Waiting on you.** Every open ask, grouped by bucket (section 3), deadlines
   first inside each bucket, numbered continuously so the owner can answer
   "yes 1-12, no 14".
4. **Product cards.** Status pill, one-line headline, a note per platform,
   "N waiting on you" (links to that product's first ask), Done / Waiting on
   others / Next, and link chips.
5. **Supporting work.** Same card without platform cells, for research,
   analytics, infrastructure, accounts and other non-product work.

## 2. Data model (three tables)

`projects`: id, name, also (other names the owner uses), group (`core` or
`supporting`), order, status (`Live`, `Needs you`, `Blocked`, `Paused`,
`On track`), headline, one stage + note per platform, done, others, next,
checked.

Stages: `Live`, `Ready` (store record filled, waits on test and submit),
`Build` (a build exists, no listing), `Draft` (unmerged PR), `Blocked`,
`Not started`, `n/a`. Supporting rows leave platform fields empty.

`asks`: id, bucket, product, ask, kind, due (ISO date or empty), due_label,
order.

`links`: id, product, label, url (https only).

Example rows: `docs/templates/project-dashboard/data/*.example.json`.

## 3. The four buckets (sort every ask before it goes on the page)

Work down this list and put each ask in the first bucket that fits.

1. **Agents doing.** Check first whether an agent can just do it: API, CI,
   connectors, GitHub, hosting dashboards, read-only checks. If it is
   reversible and stays inside the owner's own systems, do it and either drop
   the ask or list it here so the owner sees it moving. Nothing irreversible.
2. **Cowork runs.** Anything that needs the owner's signed-in browser but no
   judgment: console data entry, listings, uploads, inbox checks, prefilled
   declarations. Collect them into one paste-ready script grouped by site
   (`COWORK_SCRIPT_TEMPLATE.md`). The script stops at passwords, 2FA, prices,
   terms and any Save that declares or certifies.
3. **Your yes.** Decisions and approvals: merges, submits, production deploys,
   prices, design picks. Each is one yes/no line that says what it does and
   whether it can be undone ("Merge PR 12? A revert undoes it."). Agents do
   the work after the yes.
4. **Only you.** What no agent or script can do: secrets, on-device tests,
   legal clicks (agreements, certifications, signatures), files only the owner
   has. Each line gives the exact step.

Never put store data entry, screenshots or listing copy in "Only you". That is
agent or Cowork work.

## 4. Writing the rows

- Plain words the owner uses. Name things by their product name, not repo or
  ticket codes. One line per ask, under about 25 words.
- Ask lines are questions that a yes or no settles. Put the undo cost in the
  same line.
- Dates as the owner reads them ("Due Mar 3"), with the ISO date in `due`.
- Never put a password, key, token, keystore detail, personal phone number or
  home address on the page. Name the account instead ("the review account").
- No hype words, no emojis.

## 5. Keeping it current

- Every status change goes to the dashboard: change the row, bump `checked`,
  remove answered asks, add new ones. Do it in the same turn the change is
  learned.
- Before stating a stage, verify it at the source when a tool can (store
  console API, CI run, hosting dashboard, PR state). Memory and reports are
  where to look, not proof. If unverified, say so in the platform note.
- Before editing, re-read the live data. Another agent may have written since.
- When an ask is answered, drop it and record the result in the product's
  Done or Next line.
- When a check finds a regression (a site down, a build failing), add it to
  "Agents doing" with what broke, and tell whoever owns that work.

## 6. Hosting

Any of these work; pick one and stay with it.

- **Static page:** `dashboard.html` with the three JSON files beside it, on
  any static host or opened locally. Agents update the JSON.
- **Claude Artifact (Dashboard type):** the same three tables as datasets,
  the page as the dashboard file. Agents update datasets through the artifact
  database; the page reads them live.
- **A database table set** behind an internal page, if the product already
  has an admin area.

## 7. Report back

After building or updating: one line with the link, the count waiting on the
owner, the nearest deadline, and anything that changed state. Then the "Your
yes" list as numbered yes/no lines and the "Only you" list with exact steps.
