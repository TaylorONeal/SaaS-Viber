---
name: search-indexing
description: Get any public website discovered, indexed and correctly understood by search engines and AI crawlers - webmaster console setup (Google, Bing, Yandex, Naver, Seznam), IndexNow, sitemaps, robots.txt with AI crawler policy, meta tags, structured data and verification. Load for "submit my site to Google/Bing", "why isn't my site indexed", launch-day SEO, or any sitemap/robots/schema work.
---

# Search Indexing Skill

Works for any public site: SaaS marketing site, local business, portfolio, docs,
blog. Stack-agnostic. Read the whole file once, then run the phases in order.
Knowledge current as of late 2026; anything marked **verify** changes often, so
check the official doc before relying on it.

The deeper reference is `docs/guides/SEO_SETUP_GUIDE.md`. This skill is the
operating procedure.

---

## 0. Ground rules

1. **Never store passwords, recovery codes or API secrets in the repo**, in
   docs, or in agent memory. Logins live in a password manager or a persistent
   browser profile the human controls.
2. **Agent does every step up to a password or 2FA prompt.** Open the exact
   page with everything else filled in; the human types the secret and clicks
   save. Then the agent continues.
3. **Record ownership, not secrets.** Keep a private, gitignored
   `ACCOUNTS.local.md` (or the team's password-manager notes) with, per
   console: login email, property name, property ID, verification method,
   date verified. Example row in section 9.
4. **Evidence or it did not happen.** A step is `Done` only with proof: a
   console screenshot, a 200 response, a validator result. Otherwise
   `UNVERIFIED`.
5. **Only mark up what is true and visible.** No invented reviews, ratings,
   addresses, prices or hours in structured data. Fake markup earns manual
   actions.
6. **Do not chase deprecated tricks**: sitemap ping URLs, `changefreq`,
   `priority`, meta keywords, mass "request indexing" clicks. See section 8.

---

## 1. Pre-flight: is the site crawlable at all?

Run these before touching any console. A console cannot fix a site that
returns the wrong things.

```bash
SITE=https://www.example.com
curl -sI $SITE | head -5                    # expect 200, not 3xx chain
curl -sI http://example.com | grep -i location   # http and apex 301 to ONE canonical host
curl -s  $SITE/robots.txt                   # exists, not blocking /
curl -sI $SITE/sitemap.xml                  # 200, content-type xml
curl -sI $SITE/this-page-does-not-exist     # must be 404, not 200 (soft 404)
curl -s  $SITE | grep -iE '<title>|name="description"|rel="canonical"|noindex'
```

| Check | Pass condition |
|---|---|
| One canonical host | `http`, apex and `www` all 301 to the same HTTPS origin in one hop |
| No accidental noindex | No `noindex` in meta robots or `X-Robots-Tag` header on public pages (staging configs leak) |
| Real 404s | Unknown paths return status 404. SPAs often return 200 + "not found" text: fix at host/server |
| Content in HTML | Main text appears in the raw HTML (`curl`), not only after JavaScript runs. Most AI crawlers do not execute JS; Google renders but later. SPAs need SSR, SSG or prerender for public pages |
| HTTPS valid | No mixed content, cert valid for every host variant |
| Trailing slash | Pick one form; the other 301s |
| Speed | Core Web Vitals pass on mobile: LCP < 2.5s, INP < 200ms, CLS < 0.1 |

Fix failures before moving on.

---

## 2. Files the robots read

### 2.1 sitemap.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://www.example.com/</loc>
    <lastmod>2026-11-07</lastmod>
  </url>
</urlset>
```

Rules:
- Only canonical, indexable URLs that return 200. No redirects, no 404s, no
  `noindex` pages, no login/app/admin/API routes, no query-string duplicates.
- Absolute URLs on the same host and protocol as the sitemap.
- `lastmod` = date of last **significant** change (main content, structured
  data, links). Never stamp every URL with today's date on each build; Google
  stops trusting a site's `lastmod` when it does not match reality.
- Omit `changefreq` and `priority`. Google and Bing ignore both.
- Limits per file: 50,000 URLs or 50 MB uncompressed. Above that, use a
  sitemap index (`<sitemapindex>`) pointing to child sitemaps split by type.
- Generate it at build time from the route list or CMS, never by hand.
- Optional extensions: image sitemap for image-heavy sites, `hreflang`
  alternates for multilingual sites, news sitemap only for real news
  publishers.

### 2.2 robots.txt

Purpose: tell crawlers what not to fetch and where the sitemap is. It is not a
security control; anything private needs auth.

```text
# Default: allow everything public
User-agent: *
Allow: /
Disallow: /app/
Disallow: /api/
Disallow: /admin/
Disallow: /auth/

# --- AI crawlers (see policy table below) ---
User-agent: OAI-SearchBot
Allow: /
User-agent: ChatGPT-User
Allow: /
User-agent: Claude-SearchBot
Allow: /
User-agent: Claude-User
Allow: /
User-agent: PerplexityBot
Allow: /
User-agent: Perplexity-User
Allow: /

# Training crawlers: decide per site, then set Allow or Disallow
User-agent: GPTBot
Allow: /
User-agent: ClaudeBot
Allow: /
User-agent: Google-Extended
Allow: /
User-agent: Applebot-Extended
Allow: /

Sitemap: https://www.example.com/sitemap.xml
```

A crawler obeys only the most specific group that names it, so every named
group must repeat any `Disallow` lines it needs (e.g. `/app/`).

**AI crawler policy.** Three jobs, decided separately:

| Job | Tokens (verify, list changes) | Default for a business that wants to be found |
|---|---|---|
| Search index for AI answers and citations | `OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`, `DuckAssistBot`, `Amzn-SearchBot`, `meta-webindexer` | **Allow.** Blocking removes you from those answers |
| Live fetch when a user asks about a page | `ChatGPT-User`, `Claude-User`, `Perplexity-User`, `meta-externalfetcher` | **Allow** |
| Model training | `GPTBot`, `ClaudeBot`, `Google-Extended`, `Applebot-Extended`, `CCBot` | Owner's choice. Allowing can increase how often models know your brand; blocking is a content-licensing decision |

Facts that trip people up:
- `Google-Extended` controls Gemini training and grounding use, **not** Google
  Search ranking or inclusion. Google Search and AI Overviews are governed by
  `Googlebot`. Do not block `Googlebot` to stay out of AI Overviews; that
  removes you from Search.
- Retired Anthropic tokens `anthropic-ai` and `Claude-Web` are harmless but
  unused.
- Robots rules are honored by the big operators; unknown scrapers ignore them.
  Use the host's bot management (WAF) for abuse, and check it is not blocking
  the good bots above by accident (common with "block AI bots" toggles).

### 2.3 llms.txt (optional, low priority)

A markdown file at `/llms.txt` listing key pages. As of 2026 roughly 1 in 10
sites ship one, but no major AI search product has committed to reading it,
and Google has said it does not use it. Add it only if cheap; never instead of
the items above. If added, serve it with `X-Robots-Tag: noindex` so it does not
show up as a search result.

### 2.4 IndexNow key file

See section 4. A text file at `/<key>.txt` whose content is the key.

---

## 3. Page-level tags (every public page)

```html
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Primary topic - Brand</title>                     <!-- unique, ~50-60 chars -->
  <meta name="description" content="What this page offers and for whom.">  <!-- unique, ~150-160 chars -->
  <link rel="canonical" href="https://www.example.com/page">   <!-- self-referencing, absolute -->
  <meta name="robots" content="index, follow, max-image-preview:large">
  <!-- Open Graph -->
  <meta property="og:type" content="website">
  <meta property="og:title" content="...">
  <meta property="og:description" content="...">
  <meta property="og:url" content="https://www.example.com/page">
  <meta property="og:image" content="https://www.example.com/og/page.png">  <!-- 1200x630 -->
  <meta property="og:site_name" content="Brand">
  <meta name="twitter:card" content="summary_large_image">
  <!-- Icons -->
  <link rel="icon" href="/favicon.ico" sizes="32x32">
  <link rel="icon" href="/icon.svg" type="image/svg+xml">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  <!-- Multilingual only -->
  <link rel="alternate" hreflang="es" href="https://www.example.com/es/page">
  <link rel="alternate" hreflang="x-default" href="https://www.example.com/page">
</head>
```

Rules:
- One `<h1>` per page that matches the page's real topic. Logical `h2`/`h3`.
- Every image has descriptive `alt`. Decorative images use `alt=""`.
- Internal links use real `<a href>` with descriptive text, not JS click
  handlers. Every indexable page is reachable within ~3 clicks from home.
- Titles and descriptions are unique per page. Duplicates signal duplicate
  pages.
- Non-public pages (thank-you, login, search results, carts): `noindex` meta
  **and** leave them out of the sitemap. Do not also block them in robots.txt,
  or crawlers never see the `noindex`.
- Lead each page with a direct answer to the question it exists for, then
  detail. This is what AI answer engines quote.

---

## 4. Push notification: IndexNow

One ping reaches Bing, Yandex, Naver, Seznam and Yep (participants change,
**verify** at indexnow.org). Bing's index also feeds several AI assistants, so
this is the fastest route outside Google. Google does **not** support IndexNow.

Setup:
1. Generate a key (8-128 chars, `a-z A-Z 0-9 -`): `openssl rand -hex 16`.
2. Host it at `https://www.example.com/<key>.txt` containing only the key.
3. On deploy, POST changed URLs (not the whole site every time):

```bash
curl -s -X POST https://api.indexnow.org/indexnow \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d '{
    "host": "www.example.com",
    "key": "<key>",
    "keyLocation": "https://www.example.com/<key>.txt",
    "urlList": ["https://www.example.com/", "https://www.example.com/pricing"]
  }'
```

Expect `200` or `202`. `403` = key file missing or mismatched. `422` = URL not
on host. `429` = too many requests; batch instead (up to 10,000 URLs per POST).

Automate it: a post-deploy script that diffs the sitemap's `lastmod` values
against the previous build and submits only changed URLs. Many CMSs and hosts
have a toggle or plugin; check before writing one.

The key is not a secret in the password sense (it is public in the key file),
but keep it in env config, not hardcoded in many places.

---

## 5. Webmaster consoles

| Engine / surface | Console | Covers | How to submit |
|---|---|---|---|
| Google | Search Console | Google Search, Discover, AI Overviews / AI Mode | Domain property, DNS TXT verify, submit sitemap |
| Microsoft | Bing Webmaster Tools | Bing; results also power Yahoo, DuckDuckGo, Ecosia and several AI assistants | Import from Search Console or DNS verify, submit sitemap, IndexNow |
| DuckDuckGo | **None** | Uses Bing plus its own crawler | Covered by Bing. Allow `DuckDuckBot` and `DuckAssistBot` |
| Brave Search | **None** (no public submission console) | Independent index | Discovered by crawl and links. Do not block its crawler |
| Yandex | Yandex Webmaster | Russia/CIS | Only if that audience matters; IndexNow already notifies it |
| Naver | Naver Search Advisor | South Korea | Only for Korean audience |
| Seznam | Seznam Webmaster | Czech Republic | Only for Czech audience |
| Baidu | Baidu Ziyuan | China | Usually needs ICP license and China hosting; skip unless targeting China |
| Apple | No search console. Applebot crawls | Siri, Spotlight, Safari suggestions | Allow `Applebot`. Local businesses: Apple Business Connect |

### 5.1 Google Search Console

1. Open `https://search.google.com/search-console`, add a **Domain**
   property (covers all subdomains and protocols).
2. Copy the TXT record. Add it at the DNS host (agent does this if it has DNS
   access; human approves). Wait for propagation, click Verify.
3. Sitemaps (left nav: Indexing > Sitemaps): submit `sitemap.xml`. Status must
   read Success with a discovered-URL count close to your page count.
4. URL Inspection: inspect the homepage and 2-3 key pages. Use "Test live
   URL" to confirm Google sees the rendered content, canonical and structured
   data. "Request indexing" is rate-limited and Google discourages using it
   to force indexing; use it for a handful of genuinely new or fixed pages only.
5. Settings > Users and permissions: add a second owner (a team or
   backup account) so access is not tied to one person.
6. Link to the analytics property if the team uses one.

Indexing API: officially only for `JobPosting` and livestream
`BroadcastEvent` pages. Do not use it for regular pages.

### 5.2 Bing Webmaster Tools

1. Open `https://www.bing.com/webmasters`. Fastest path: "Import from Google
   Search Console" (imports verified sites and sitemaps). Otherwise verify by
   DNS CNAME/TXT, `BingSiteAuth.xml` file or meta tag.
2. Sitemaps: confirm the sitemap is listed and processed.
3. IndexNow: confirm submissions appear in the IndexNow report.
4. Check URL Inspection and Site Scan for crawl errors.
5. Review the AI performance reporting (added 2026; **verify** menu location)
   to see citations in Copilot and Bing AI answers.

### 5.3 Login and session hygiene

- Use one dedicated browser profile per organization, signed into the
  owner account for these consoles. The agent reuses that profile across
  sessions instead of logging in fresh each time.
- If the agent hits a login, password or 2FA wall: stop, open the exact page,
  tell the human what to type where, resume after they confirm.
- After setup, write the ownership row (section 9) to the private accounts
  file, never the password.

---

## 6. Structured data (JSON-LD)

Put JSON-LD in a `<script type="application/ld+json">` in the server-rendered
HTML. Validate with Google's Rich Results Test and the Schema.org Validator.

### 6.1 Site-wide (homepage)

```json
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": "https://www.example.com/#org",
      "name": "Brand",
      "url": "https://www.example.com/",
      "logo": "https://www.example.com/logo-512.png",
      "sameAs": ["https://www.linkedin.com/company/brand", "https://github.com/brand"],
      "contactPoint": { "@type": "ContactPoint", "contactType": "customer support", "email": "support@example.com" }
    },
    {
      "@type": "WebSite",
      "@id": "https://www.example.com/#website",
      "url": "https://www.example.com/",
      "name": "Brand",
      "publisher": { "@id": "https://www.example.com/#org" }
    }
  ]
}
```

### 6.2 Pick the type that matches the business

| Site type | Primary type | Key properties |
|---|---|---|
| SaaS / app | `SoftwareApplication` (or `WebApplication`, `MobileApplication`) | `applicationCategory`, `operatingSystem`, `offers` (real price), `aggregateRating` only from real third-party or verified reviews |
| Physical location or service area | Most specific `LocalBusiness` subtype (e.g. `HomeAndConstructionBusiness`, `ProfessionalService`, `Restaurant`, `MedicalBusiness`) | `name`, `address`, `geo`, `telephone`, `openingHoursSpecification`, `areaServed`, `priceRange`, `image`, `url`. Must match the Google Business Profile exactly |
| Services offered | `Service` with `provider` -> the business `@id` | `serviceType`, `areaServed`, `offers` |
| E-commerce | `Product` + `Offer` | `price`, `priceCurrency`, `availability`, `gtin` if any, shipping and return policy |
| Blog / articles | `Article` or `BlogPosting` | `headline`, `author` (a real `Person` with a profile URL), `datePublished`, `dateModified`, `image` |
| Events | `Event` | `startDate`, `location`, `offers`, `eventStatus` |
| Any multi-level page | `BreadcrumbList` | matches visible breadcrumbs |

Rules and 2026 realities:
- Markup must describe content visible on the page. Hidden-only markup is a
  violation.
- Self-serving review markup (a business rating itself on its own site) is
  not eligible for review stars on `LocalBusiness` and `Organization`. Do not
  add `aggregateRating` you collected yourself and display only on your site.
- `FAQPage` rich results are gone from Google for all sites (phased out
  2023-2026) and `HowTo` rich results were removed in 2023. The markup is
  still valid and harmless and can still help machines parse Q&A, but do not
  promise rich results from it.
- Prefer one connected `@graph` with `@id` references over many disconnected
  blocks.
- Keep values in one source (config or CMS) that renders both the visible
  page and the JSON-LD, so they cannot drift.

---

## 7. Local presence (only if the business serves a place)

Search engines and AI assistants pull local answers from business profiles
more than from the website. Same name, address, phone (NAP) everywhere,
character for character.

| Profile | Why |
|---|---|
| Google Business Profile | Maps, local pack, AI Overviews for "near me" queries |
| Bing Places for Business | Bing, Copilot, and assistants built on Bing. Can import from Google |
| Apple Business Connect | Apple Maps, Siri, Spotlight |
| Main industry directories and data aggregators relevant to the country | Consistency signals; AI answers cite them |

Each profile needs: correct primary category, service area or address, hours,
website URL (with UTM tags if tracking), real photos, and the human owner's
verification (postcard, phone, video). Verification steps are human-only.

---

## 8. Deprecated or useless (do not do)

| Thing | Status |
|---|---|
| `google.com/ping?sitemap=` and Bing ping URLs | Retired 2023, return 404 |
| `<changefreq>`, `<priority>` | Ignored by Google and Bing |
| `<meta name="keywords">` | Ignored |
| Mass "Request indexing" in Search Console | Rate-limited, discouraged; fix the cause instead |
| Google Indexing API for normal pages | Against its terms; only job postings and livestreams |
| Paid "submit to 500 search engines" services | No value |
| Blocking `Googlebot` to avoid AI Overviews | Removes the site from Search |
| `llms.txt` as an SEO fix | No measurable effect in 2026 |

---

## 9. Report and hand-off

Output one status table. Evidence column is mandatory.

| Item | State | Evidence (date) | Next action |
|---|---|---|---|
| Canonical host + redirects | Done | `curl -I` output, 2026-11-07 | none |
| robots.txt | Done | URL returns 200, AI policy set | none |
| sitemap.xml | Done | 42 URLs, all 200 | none |
| Google Search Console | Done | Domain property verified, sitemap Success | Check Pages report in 7 days |
| Bing Webmaster Tools | UNVERIFIED | Waiting on DNS | Human: approve DNS record |
| IndexNow | Done | 202 on first POST | none |
| Structured data | Done | Rich Results Test: 0 errors | none |
| Business profiles | Human-only | Postcard pending | Owner enters code on arrival |

Private ownership row (gitignored file, never committed):

```
| Console | Login email | Property | Property ID | Verify method | Verified on |
| Google Search Console | owner@company | sc-domain:example.com | n/a | DNS TXT | 2026-11-07 |
```

Then:
1. Set a reminder to check the Search Console "Pages" report and Bing
   "Site Explorer" after 7 and 30 days. New sites typically take days to
   weeks to index; that is normal.
2. Add any new lesson to the project's lessons-learned doc, generalized.

---

## 10. Troubleshooting map

| Symptom | Likely cause | Fix |
|---|---|---|
| "Discovered - currently not indexed" | Thin or duplicate content, weak internal links, new site | Improve content, add internal links, wait |
| "Crawled - currently not indexed" | Quality or duplication | Merge or improve pages; check canonicals |
| "Duplicate, Google chose different canonical" | Conflicting canonicals, http/www variants | One canonical host, self-referencing canonicals |
| "Soft 404" | SPA returns 200 for missing pages | Return real 404 status |
| "Blocked by robots.txt" on a page you want | Over-broad `Disallow` | Narrow the rule |
| "Excluded by noindex" | Leftover staging tag or header | Remove from production build |
| Indexed on Google, missing on Bing | Bing not set up or IndexNow missing | Section 4 and 5.2 |
| Not cited in AI answers | AI search bots blocked (often by host WAF), JS-only content, no clear answer-first text | Section 2.2, pre-flight, section 3 |
| Sitemap "Couldn't fetch" | Wrong content-type, auth wall, redirect | Serve 200 `application/xml` at final URL |
