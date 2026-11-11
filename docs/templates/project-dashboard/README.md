# Project dashboard template

One page for anyone running several products at once: where each product
stands on each platform, and every ask waiting on the owner, sorted by who
actually has to do it.

The operating rules for agents are in `skills/project-dashboard-skill/SKILL.md`.
This folder holds the files.

| File | What it is |
|------|------------|
| `dashboard.html` | Static page. Reads `data/projects.json`, `data/asks.json`, `data/links.json`, and falls back to the `.example.json` files. |
| `data/*.example.json` | Example rows showing every field. Copy to `*.json` (drop `.example`) and replace. |
| `COWORK_SCRIPT_TEMPLATE.md` | One paste-ready browser-agent script for the "Cowork runs" bucket. |

## Try it

```
cd docs/templates/project-dashboard
npx serve .
```

Open the printed URL. Opening the file directly from disk will not load the
JSON in most browsers; serve the folder.

## Make it yours

1. Copy `data/*.example.json` to `data/projects.json`, `data/asks.json`, `data/links.json`.
2. One `projects` row per product (`group: "core"`) and per piece of supporting work (`group: "supporting"`).
3. Rename platforms in `CONFIG.platforms` at the bottom of `dashboard.html` if you ship to something other than iOS, Android and Web.
4. Sort every open ask into a bucket (the skill, section 3). Write each as one line that a yes or no settles, with its undo cost.
5. Put the browser-only steps into one script from `COWORK_SCRIPT_TEMPLATE.md`.

## The four buckets

| Bucket | Who | Examples |
|--------|-----|----------|
| Your yes | Owner answers, agents act | Merge a PR, submit a build, approve a price |
| Only you | Owner acts | Type a secret, test on a phone, accept an agreement |
| Cowork runs | Browser agent, signed in as the owner | Console listings, uploads, inbox checks, prefilled declarations |
| Agents doing | Agents, no owner action | API updates, CI fixes, read-only checks, regressions being fixed |

## Fields

`projects`: `id`, `name`, `also`, `group`, `order`, `status`, `headline`,
`ios` / `android` / `web` plus `_note` for each, `done`, `others`, `next`,
`checked`.

`asks`: `id`, `bucket`, `product`, `ask`, `kind`, `due` (ISO date or empty),
`due_label`, `order`.

`links`: `id`, `product`, `label`, `url` (https only; others are dropped).

## What never goes on the page

Passwords, keys, tokens, signing details, personal phone numbers, home
addresses. Name the account instead.

## Hosting elsewhere

The same three tables map one to one onto a Claude Artifact Dashboard
(datasets `projects`, `asks`, `links`) or onto database tables behind an admin
page. Keep one canonical copy and have agents update only that one.
