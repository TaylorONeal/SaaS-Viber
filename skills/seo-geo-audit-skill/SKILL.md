---
name: seo-geo-audit
description: Gated, evidence-only technical SEO and answer-engine (GEO) audit of a live site in four phases (crawlability, remediation diffs, external setup, decision pages), stopping for the owner's approval after each phase. Load before any launch, after a domain or hosting change, or when asked "why don't we show up in Google / ChatGPT / Perplexity", "audit our SEO", or "are AI crawlers blocked".
---

# SEO and Answer-Engine Audit Skill

This is the audit. `search-indexing-skill/SKILL.md` is the how-to for fixing
what the audit finds; read both. The audit is a **launch gate** next to the
analytics gate in `docs/guides/LAUNCH_CHECKLIST.md`.

Fill this in before Phase 1, from the repo's own docs, not by asking:

```text
Site URL:              https://www.example.com
Product, 1-2 sentences: ...
Primary competitors:   A, B, C
Repo / hosting project: ...
```

---

## 0. Operating rules (non-negotiable)

1. **Phases run in order and stop.** After each phase, present the result and
   wait for the owner's explicit go-ahead before doing anything else.
2. **Fetched evidence only.** Every status code, header, directive or schema
   finding quotes the actual response: the code, the header line, or a short
   raw snippet. If a check could not be run, the cell reads `NOT CHECKED`
   plus the reason. Never invent search volumes, click estimates, traffic,
   "SEO scores" or rankings.
3. **Read and draft freely; change nothing sensitive without a diff and a
   yes.** Reading files, fetching URLs and preparing draft changes are fine.
   Never delete files, change canonical tags, change redirects, or change
   `robots.txt` (repo or edge) without showing a unified diff and getting
   explicit approval for that diff.
4. **Schema hygiene.** Valid JSON-LD only, for `Organization`, `WebSite`,
   and `SoftwareApplication` (or `MobileApplication`) / `Product`. Do not add
   `HowTo`, do not add `FAQPage` for rich results, and never add
   `AggregateRating` or `Review` you have not earned with real, visible
   reviews. Mark up only what is true and visible on the page today (an
   unreleased app gets no price, rating or download claim).
5. **Say how you fetched.** If the agent's network blocks direct `curl` to the
   site and you used another fetcher (a hosting provider's fetch tool, a
   browser), name it. A fetcher that cannot set a User-Agent cannot run the
   bot checks: mark those `NOT CHECKED`.

---

## Phase 1: Live foundation and crawlability

Run against the **live production host**, not the repo. Repo files can differ
from what the edge serves.

```bash
SITE=https://www.example.com          # the canonical host
ALT=https://example.com               # the other host (apex or www)
UA_BROWSER='Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15'

# 1. Server-side rendering: is the value proposition in raw HTML?
curl -s -A "$UA_BROWSER" $SITE/ | grep -oiE '<title>[^<]*|<h1[^>]*>[^<]*|name="description" content="[^"]*'
curl -s -A "$UA_BROWSER" $SITE/ | grep -c '<div id="root"></div>'   # 1 = empty SPA shell

# 2. Live robots.txt (edge, not repo)
curl -s -D - $SITE/robots.txt

# 3. Answer-engine bots: same request, different User-Agent
for UA in "OAI-SearchBot" "Claude-SearchBot" "PerplexityBot" "bingbot" "$UA_BROWSER"; do
  printf '%-18s ' "${UA:0:18}"; curl -A "$UA" -s -o /dev/null -w "%{http_code}\n" $SITE/
done

# 4. Hygiene
curl -s -o /dev/null -w "%{http_code} %{redirect_url}\n" $ALT/     # expect 301/308 to $SITE in one hop
curl -s -o /dev/null -w "%{http_code} %{redirect_url}\n" http://example.com/
curl -s $SITE/ | grep -oiE '<link[^>]+rel="canonical"[^>]*>'       # self-referencing
curl -s -D - -o /dev/null $SITE/sitemap.xml | grep -iE '^HTTP|content-type'
curl -s $SITE/ | grep -A40 'application/ld+json' | head -60         # then parse it
curl -s -o /dev/null -w "%{http_code}\n" $SITE/no-such-page-$(date +%s)   # must be 404
```

The bot User-Agent test catches WAF and bot-protection rules that block
crawlers even when `robots.txt` allows them. A bot UA getting `403`, `429`, a
challenge page, or a different body from the browser UA is a **Fail**. Also
read the host's firewall or bot-protection settings (Cloudflare Bot Fight Mode
or AI Crawl Control, Vercel Firewall managed rules) and quote them. Real
crawlers come from published IP ranges, so a UA-only test can pass while the
real bot is blocked by IP rules; note that limit in the report.

### What counts as Pass

| Check | Pass |
|---|---|
| SSR copy | `<title>`, one `<h1>` and the value-proposition copy are in raw HTML. An empty `#root` with copy only in `<head>` is a Fail for answer engines, most of which do not run JavaScript |
| robots.txt | `200 text/plain`; `OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`, `bingbot` allowed, by name or by `User-agent: *`; sitemap line present |
| Named-group trap | If any bot has its own `User-agent:` group, that group must repeat the `Disallow` lines it should obey. A crawler that matches a named group ignores the `*` group entirely, so `User-agent: GPTBot` + `Allow: /` silently un-blocks every private path |
| Bot UA status | Each bot UA returns the same `200` as a browser UA |
| One host | The other host and `http://` return 301/308 to the canonical origin in one hop. Both hosts returning `200` is a Fail even if the canonical tag points to one |
| Canonical | Self-referencing absolute URL on the canonical host |
| Sitemap | `200`, XML content type, every `<loc>` on the canonical host, real pages only |
| Schema | Parses as JSON; `Organization` + `WebSite` site-wide, `SoftwareApplication`/`MobileApplication` on the product page; no restricted types (rule 4) |
| Real 404 | Unknown path returns `404`, not `200` |

**STOP. Present one table** (rows = sites, columns = the checks above), each
cell `Pass`, `Fail` or `NOT CHECKED` plus the evidence in a few words. Then
wait.

---

## Phase 2: Prioritized remediation plan

Group fixes:

- **Critical**: broken crawlability, indexation blocks (noindex, empty SPA
  shell, bot UA blocked), invalid robots directives, missing or wrong
  canonicals, duplicate hosts serving `200`.
- **Structural**: schema fixes, sitemap corrections, redirect normalization,
  `llms.txt`, real 404s.

For each fix give: target file or route, the exact unified diff (or exact
hosting setting), and the verification command to run after deploy. Example:

```text
Fix:    www serves duplicate 200
Target: hosting domain settings (www -> apex, 308)
Change: Domains > www.example.com > Redirect to example.com (permanent)
Verify: curl -s -o /dev/null -w "%{http_code} %{redirect_url}\n" https://www.example.com/
        expect: 308 https://example.com/
```

Open fixes as draft pull requests (one per repo) so the diff is reviewable.
Anything touching robots.txt, canonicals, redirects or deletions stays
unmerged until the owner approves that diff. **STOP and wait.**

---

## Phase 3: External setup (needs the owner's logins)

The owner should not do rote work. Write each step as a **self-contained
prompt for a browser-capable agent** that the owner pastes into it: every URL,
property name, sitemap URL and expected result written out, and the agent
stops only where a password or 2FA prompt appears. Order:

1. Google Search Console: Domain property per site, sitemap submitted, URL
   Inspection "Test live URL" on the home and main product page, linked to
   the analytics property.
2. Bing Webmaster Tools: import from Search Console, confirm the sitemap,
   host an IndexNow key file and confirm the first `200`/`202`, review the AI
   performance (citations) report.
3. Listings: one positioning line, one title and one canonical URL, used
   word for word across 20 to 30 directories that fit the product (app
   stores, Product Hunt, G2/Capterra-type directories where the category
   exists, niche directories, GitHub topics for open source, social bios).
   Keep a private sheet: directory, URL submitted, date, status. Never buy
   links or reviews.

Record ownership in a private, gitignored accounts file, never secrets.

---

## Phase 4: High-intent decision pages

1. Propose 5 decision-stage pages, for example `[Brand] vs [Competitor]`,
   `[Competitor] alternatives`, `Best [category] for [niche]`,
   `[category] free vs paid`, `How to choose a [category]`.
2. For each page: the query intent and who the reader is choosing between;
   a 40 to 80 word direct-answer opening block that names the answer in the
   first sentence; and one **first-party** differentiator a roundup site
   cannot copy (your own test, a real limit you measured, a pricing or
   privacy trade-off you can document). If you have no first-party data yet,
   say so and name the test that would produce it.
3. Draft 20 real buyer questions from support tickets, store reviews,
   community threads and pricing questions. Label each with its source; if
   there are no tickets yet, say which public source it came from. Use them
   to benchmark answer engines: ask each engine, log whether you are named
   and which page is cited, and re-run monthly. Record answers verbatim with
   the date; do not summarize them into a score.

Pages must be honest comparisons: name where the competitor is better.
Do not publish competitor claims you have not checked on their own site.

---

## Report template (Phase 1)

| Site | SSR copy | robots.txt bots | Bot UA status | Host redirect | Canonical | Sitemap | Schema |
|---|---|---|---|---|---|---|---|
| example.com | Pass: h1 "..." in raw HTML | Pass: `*` Allow / | NOT CHECKED: fetcher cannot set UA | Fail: www 200, no redirect | Pass: self | Pass: 24 locs | Fail: FAQPage on /pricing |
