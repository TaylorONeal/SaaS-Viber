# SEO Strategy

> **Status:** Strategy guide, not a runbook. The runbook is `skills/search-indexing-skill/SKILL.md`.
> **Audience:** First a first-time founder, then an expert, then an AI agent.
> **As of:** Nov 8, 2026. Search engines and AI answer products change their
> behavior often. Treat every dated claim in this doc as a snapshot, and
> re-check it in Search Console and in the official docs before you build
> around it.

## In one minute

SEO is being the best answer for a job someone already searches for. A
person types a problem into Google, Bing, or an AI assistant. Your page is
the clearest, most useful, most trustworthy answer to that problem. That is
the whole job.

It is not tricks. It is not stuffing a keyword into a page fifty times. It
is not buying links. It is not a plugin that fixes everything. It is: pick
a small set of real problems, write one genuinely useful page per problem,
make the page fast and readable by machines as well as people, link your
pages together sensibly, and keep measuring what people actually find.

Do the indexing runbook first. If Google and Bing cannot find, crawl, and
understand your pages, no strategy helps. This guide starts where that
runbook ends.

**Runbook (do not repeat it here):** `skills/search-indexing-skill/SKILL.md`
covers consoles, sitemaps, robots.txt and AI crawler policy, IndexNow,
structured data, and troubleshooting. The background is
`docs/guides/SEO_SETUP_GUIDE.md`. The code level is
`docs/developer/seo-guide.md`.

---

## 1. What SEO actually is for a SaaS

A SaaS does not rank for its own name on day one and then stop. Almost
nobody searches for a product name they have never heard of. They search
for the problem.

A yoga teacher does not search for "CueCraft". She searches for "how to
plan a yoga class sequence" or "yoga sequence builder for teachers". A
studio owner searches for "yoga studio booking software" or "how to take
class bookings online". Your job is to be the best answer to the problem
search, so the person meets your product while solving their problem.

That gives you three rules that decide almost everything else:

1. **One page, one job.** Every indexable page exists to answer one
   question or do one job for one kind of person. If you cannot say the
   job in one sentence, the page is two pages, or it is not a page yet.
2. **The searcher is the judge, not you.** A page is good when the person
   who lands on it finds the answer, trusts it, and takes the next step
   (sign up, try, read the next page). Time on page and bounce rate are
   hints. Signups from search are the verdict.
3. **SEO is slow and cumulative.** A page published today will usually
   take days to weeks to be indexed, and longer to earn a stable position.
   That is normal. The work compounds: ten good pages beat one perfect
   page, and a hundred good pages beat ten, provided each one is genuinely
   useful.

### What SEO is not

* It is not a launch tactic. It will not save a launch week. It pays off
  over months.
* It is not a substitute for a product people want. Traffic to a product
  nobody keeps is wasted traffic.
* It is not free traffic in the sense of no cost. The cost is the time to
  write and maintain good pages. Budget for that time, or do not start.

### For experts

Search ranking is a mix of relevance (does this page match the query and
the intent behind it), authority (do other trustworthy pages link to this
site and this page), and experience (does the page load fast, render
correctly on a phone, and let the person finish the job). AI answer
engines add a fourth factor: citability (can the engine lift a short,
accurate, dated fact from this page and attribute it). This guide treats
all four as one system, not four separate checklists.

### For agents

When an agent is asked to "do SEO", it must first ask: which page, which
query, which intent, and what is the next step for the reader. An agent
that writes pages without those four answers is producing text, not SEO.
Record the four answers in the page brief before writing a word. See
section 7 for the brief format.

---

## 2. Keyword strategy

### 2.1 Search intent comes first

Every query has an intent. The same words can hide different intents, and
the page must match the intent, not just the words.

| Intent | The searcher wants | Page that wins | Example (fictional yoga app) |
|---|---|---|---|
| Informational | To learn or understand | A clear explainer that answers the question fully | "How to plan a yoga class sequence" |
| Commercial investigation | To compare options before choosing | An honest comparison, with tradeoffs and prices where you know them | "Best yoga sequence builders compared" |
| Transactional | To sign up, buy, or try now | A product or pricing page with a clear next step | "Yoga class planner free trial" |
| Navigational | To reach a known site | Your homepage or login page | "[Your product name] login" |

A common beginner mistake is writing an informational page that tries to
sell, or a sales page that tries to teach. The searcher leaves either way.
Match the page to the intent, then add one honest next step at the end.

### 2.2 One core job per page

Before you write, fill in this sentence:

> "A [kind of person] who searches for [query] wants to [job], and after
> reading this page they can [next step]."

If two different jobs fit the same page, split it. If the same job is
covered by two pages, merge them. This is the single most effective rule
in this guide.

### 2.3 Long-tail beats head (for a solo founder)

A head keyword is short, popular, and hard: "yoga software", "booking
software", "project management". Large companies with years of authority
own those pages. A solo founder cannot win them in the first year, and
should not try.

A long-tail keyword is longer, more specific, and easier: "yoga sequence
builder for vinyasa teachers", "how to take yoga class bookings without
a front desk", "free trial yoga studio booking for small studios". Fewer
people search for each one, but the people who do are closer to buying,
and you can actually rank for them.

Pick keywords by this test, in order:

1. **Is it a real problem?** Would a real person type this, or did a tool
   invent it? Ask a real user, or read real support emails and community
   posts.
2. **Is the intent clear?** Can you say what the searcher wants to do
   next?
3. **Can this page be the best answer?** Do you know something specific,
   have original data, or have a product that actually does the job?
4. **Can you win it?** Look at the current top results. If they are all
   large companies with long, well linked pages, pick a narrower version.

### 2.4 How to pick 10 starter keywords

Do not start with a tool. Start with your users.

1. List the 10 problems your product solves, in the words your users use,
   not your marketing words. Support emails, onboarding calls, and
   community posts are the source.
2. For each problem, write the question a person would type before they
   know your product exists. That is your keyword.
3. Check each one in Search Console later (once you have traffic) and in
   a keyword tool now, only to confirm people search for it at all. A
   tool cannot tell you whether the problem is real.
4. Sort by a mix of closeness to buying and winnability. The first five
   should be close to buying (commercial or transactional intent). The
   next five should be informational pages that earn trust and links.
5. Stop at ten. Publish those ten pages well before you pick ten more.

### 2.5 Keyword cannibalisation

Cannibalisation is when two of your pages compete for the same query.
Google picks one, usually the wrong one, and both pages do worse than one
good page would.

Symptoms: two pages rank on different days for the same query, neither
ranks well, or a blog post outranks your product page for a buying query.

Fix: decide which page should win that query, make it clearly the best
answer, link to it from the other page with the query words as the link
text, and either merge the loser into the winner or rewrite the loser for
a different query. Do not delete a page that has links or traffic without
redirecting it to the winner.

### For agents

An agent that proposes keywords must cite the source of each one (a user
quote, a support ticket, a Search Console query, or a named tool result
with a date). An agent that invents keywords from its own knowledge is
guessing. Record the source next to the keyword in the table in section 8.

---

## 3. Content that earns links

Links from other sites are still one of the strongest authority signals.
You do not earn them by asking for them. You earn them by publishing
something worth linking to.

### 3.1 The page types that earn links for a SaaS

| Page type | Why it earns links | Example |
|---|---|---|
| Problem page | It answers a question people keep asking, so forums and blogs link to it instead of explaining it again | "How to plan a yoga class sequence in 20 minutes" |
| Comparison page | It saves the reader the work of comparing, so it gets cited | "[Your product] vs [alternative]: an honest comparison" |
| Use-case page | It shows the product doing a real job for a real kind of person | "How a small studio takes bookings without a front desk" |
| Original data | Nobody else has the numbers, so everyone cites you | A survey of your users, a benchmark from your own product data (anonymised) |
| Docs as SEO | Your docs answer the exact question a developer or user types | "How to set up [feature] in 5 minutes" |
| Changelog as SEO | Each release note is a small, dated, findable answer about what changed and why | "What is new in [version]: [benefit]" |

### 3.2 Comparison pages: be honest or do not write them

A comparison page that says you win on every row is not trusted, and it
is not linked to. A comparison page that says, in plain language, who
each option is best for, including when the other option is better, is
trusted, cited, and converts the readers who are actually a fit.

Rules:

* Compare on facts you can verify (price, features, limits). Date the
  page and re-check it quarterly. Prices change; a stale comparison is
  worse than no comparison.
* Name the tradeoff. If you are simpler, say you are simpler and what
  you leave out. If you are cheaper, say what the higher price buys
  elsewhere.
* Never invent a competitor price, feature, or quote. If you cannot
  verify it, leave that cell blank and say so.
* Link to the competitor's own site. It is honest, and it is what a
  trustworthy comparison does.

### 3.3 Use-case pages

One use-case page per kind of person, not per feature. A feature list
says what the product does. A use-case page says what the person gets
done, in their words, in their order, with the obstacles named.

Structure: the person's situation, the job they need done, the old way
and why it hurt, the new way step by step, what changed (time saved,
mistakes avoided, money), and the next step. One real quote beats five
adjectives. Never invent a quote or a customer. If you have no customer
yet, write the page from your own use of the product and say so.

### 3.4 Docs as SEO

Your documentation is search content, not just support content. People
search for "how to [do the thing your product does]" and land on docs.
Write docs pages with the same care as marketing pages: one job per page,
a direct answer at the top, steps in order, and a link to the next page.

Keep docs public and crawlable unless a page is genuinely private. A
docs page hidden behind login cannot rank and cannot be cited.

### 3.5 Changelog as SEO

A public changelog is a stream of small, dated, specific pages that
search engines and AI assistants can cite. Each entry should say what
changed, who it helps, and how to use it, in plain language. "Bug fixes
and improvements" as a whole entry helps nobody and ranks for nothing.
See the storefront copy guide for the customer-facing version of the same
rule.

### 3.6 Programmatic pages: only when each page is genuinely useful

Programmatic pages are pages generated from a template and a dataset,
for example one page per city, per integration, or per use case. They
work when every generated page answers a real, distinct question with
real, distinct content. They fail when they are the same paragraph with
one word swapped, which search engines treat as thin duplicate content.

Test before you scale: publish ten programmatic pages by hand, check
whether they earn traffic and links, and only then generate the next
hundred. If the ten do not earn anything, the template is the problem,
not the count.

### For experts

Link earning is a lagging indicator of usefulness, not a separate
activity. The highest return work is usually: fix the ten pages that
already get impressions but few clicks, publish the five pages your
users keep asking for, and update the three pages that are out of date.
Outreach (telling people a useful page exists) helps only after the page
is genuinely useful.

---

## 4. Technical SEO beyond indexing

The runbook covers crawlability. This section covers the technical work
that decides whether a crawlable page ranks and converts.

### 4.1 Core Web Vitals

The targets, from the runbook and the implementation guide, are:

| Metric | Target | What it measures |
|---|---|---|
| LCP (Largest Contentful Paint) | Under 2.5 seconds | Loading speed |
| INP (Interaction to Next Paint) | Under 200 milliseconds | Responsiveness |
| CLS (Cumulative Layout Shift) | Under 0.1 | Visual stability |

Measure on a real phone, on a throttled connection, not only on a fast
office connection. The fixes that matter most for a SaaS marketing site
are: compress and size images (WebP or AVIF), code-split JavaScript by
route, preload critical fonts, lazy-load images below the fold, and serve
static assets from a CDN. Full checklist:
`docs/guides/SEO_SETUP_GUIDE.md` section 8 and
`docs/developer/seo-guide.md`.

### 4.2 Server-rendered HTML

A page whose main text only appears after JavaScript runs is invisible
to most AI crawlers and slow to be understood by Google. Marketing
pages, pricing, blog, and docs must be server-rendered (SSR) or
statically generated (SSG). App pages behind login do not need SEO and
can stay client-side. The rule from the implementation guide is:

* Marketing pages (`/`, `/pricing`, `/blog`): SSG or SSR
* App pages (`/app/*`): client-side, no SEO needed
* Public profiles (`/u/{slug}`): SSR or ISR

If you inherit a single-page app, prerendering is the retrofit. Do not
ship a marketing site that is an empty shell in `curl`.

### 4.3 Internal linking structure

Internal links are how crawlers discover pages and how authority flows
around your site. Rules:

* Every indexable page is reachable within about three clicks from the
  homepage.
* Link text says what the destination page is about. "Click here" and
  "learn more" tell a crawler nothing.
* Link from high-traffic pages to the pages you most want to rank. Your
  homepage, pricing page, and top blog post are the strongest internal
  link sources you own.
* Do not orphan a page. A page with no internal links is a page a crawler
  may never find, even if it is in the sitemap.
* Keep the structure shallow and honest. A flat site with clear sections
  beats a deep maze.

### 4.4 URL design

* Short, readable, and stable. `/yoga-sequence-builder` beats
  `/products/category-3/item-4821`.
* Use words a person would type, separated by hyphens, in lowercase.
* One URL per page. Do not let the same content live at two URLs. Pick
  the canonical one and redirect the other.
* Do not change a URL that already ranks or has links without a 301
  redirect to the new URL. A changed URL without a redirect is a broken
  link and lost authority.

### 4.5 Canonicals

Every public page carries a self-referencing canonical link: an absolute
URL that says "this is the one true version of this page". When the same
content can be reached with tracking parameters, a trailing slash
variant, or an http variant, the canonical tells the search engine which
one to index. Conflicting canonicals (two pages each claiming to be the
canonical of the other, or a canonical that points to a redirect) are a
common cause of "Duplicate, Google chose a different canonical" in
Search Console. The runbook covers the check.

### 4.6 Hreflang, only if truly multilingual

Hreflang tags tell search engines which language version of a page to
show in which country. Add them only when you have real, translated
versions of the same page. A machine-translated page that nobody
maintains is worse than no translated page. If you are English only,
skip hreflang entirely. If you add a language, translate the page, the
title, the description, and the structured data, and keep all versions
updated together.

### For agents

An agent that changes a URL, a canonical, a redirect, or a robots rule
must list the affected pages and the expected Search Console effect
before making the change, and must check Search Console after. A
technical SEO change with no before and after check is a guess. See
`docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` for the evidence rule
that applies here too: a gate is done only with evidence.

---

## 5. AI search, GEO, and AEO

GEO (generative engine optimization) and AEO (answer engine
optimization) are new names for an old idea: be the page an answer
engine can quote. As of Nov 8, 2026, AI search is a real source of
traffic and citations for SaaS sites, and it rewards the same qualities
as classic SEO, with a few additions.

### 5.1 What AI answer engines actually do

When a person asks an AI assistant a question, the assistant searches,
reads a small set of pages, and writes an answer with citations (or, in
some products, without visible citations). It cites pages that:

* Answer the question directly, in the first paragraph, in plain
  language.
* State facts clearly, with dates, numbers, and named sources where the
  fact came from.
* Are structured so the engine can lift a short passage: headings, lists,
  tables, and short paragraphs.
* Are crawlable as plain HTML. Most AI crawlers do not execute
  JavaScript. A JS-only page is invisible to them.

None of this is a secret trick. It is the same as writing a good page,
with the answer put first instead of buried.

### 5.2 Answer-first paragraphs

Start each page and each section with the answer, then the detail. The
pattern is:

> "[Product] is [one sentence definition]. It helps [person] do [job]
> by [method]. It costs [price or pricing model], as of [date]."

Then expand. A reader who only reads the first paragraph still leaves
with the answer. An AI engine that only lifts the first paragraph still
quotes you correctly.

### 5.3 Clear facts with dates

AI engines prefer facts they can verify and date. Write facts as facts,
not as vague claims:

* Good: "Google Workspace Business Starter costs $7 per user per month
  on the annual plan, as of Oct 2026. Verify the current price before
  you buy."
* Bad: "Affordable pricing for teams of all sizes."

Date your pages. Show a "last updated" date on every content page, and
update it only when the content actually changes. A page that says
"updated today" every day, with no change, loses trust.

### 5.4 Being cited: original data, quotable definitions, FAQ schema

Three things make a page citable:

1. **Original data.** A survey, a benchmark, or an analysis nobody else
   has. Even a small dataset, honestly described, is citable. Say how
   you collected it, how many people or records it covers, and when.
2. **A quotable definition.** One sentence that defines the thing, in
   your own words, that other writers want to quote. Put it near the top
   of the page.
3. **A real FAQ.** Questions real users ask, answered in two to four
   sentences each, marked up with FAQPage structured data so machines
   can parse the question and answer. As of 2026, Google no longer shows
   FAQPage as a rich result for most sites, so do not promise rich
   results from it. The markup is still valid and still helps machines
   understand the page. See `skills/search-indexing-skill/SKILL.md`
   section 6.

### 5.5 Structured data for AI search

Structured data does not make a bad page rank. It makes a good page
understandable. For a SaaS, the types that matter are Organization,
WebSite, SoftwareApplication (with a real price), Article or BlogPosting
(with a real author and dates), and BreadcrumbList. Keep the markup in
one source that renders both the visible page and the JSON-LD, so the
two cannot drift apart. Never mark up content that is not visible on
the page, and never invent reviews, ratings, prices, or addresses.
Fake markup earns manual actions. Full types and rules:
`skills/search-indexing-skill/SKILL.md` section 6.

### 5.6 llms.txt: optional and unproven

A `/llms.txt` file is a markdown map of your key pages, written for
language models. As of Nov 8, 2026, about 1 in 10 sites ship one, but no
major AI search product has committed to reading it, and Google has said
it does not use it. Add it only if it is cheap. Never add it instead of
crawlable HTML, a clean sitemap, and an explicit robots.txt policy.
If you add it, serve it with an `X-Robots-Tag: noindex` header so it does
not show up as a search result. See
`skills/search-indexing-skill/SKILL.md` section 2.3.

### 5.7 What AI search does not do (as of Nov 8, 2026)

* It does not replace classic search. Most buying journeys still pass
  through Google or Bing, and AI answers often link back to the same
  pages that rank well.
* It does not reward keyword stuffing. Models detect it and deprioritise
  the page.
* It does not cite a page it cannot crawl. Blocking AI search crawlers
  removes you from AI answers. Blocking training crawlers is a separate
  decision. Do not confuse the two. The policy table is in
  `skills/search-indexing-skill/SKILL.md` section 2.2.
* It does not guarantee a citation. Being citable is necessary, not
  sufficient. Authority, freshness, and the quality of the answer still
  decide.

---

## 6. Measurement

### 6.1 What to check, and where

| Question | Tool | Where to look |
|---|---|---|
| Are my pages indexed? | Google Search Console | Pages report |
| What queries bring people here? | Google Search Console | Performance, Queries tab |
| Which pages get impressions but few clicks? | Google Search Console | Performance, filter by page, sort by impressions |
| Which pages get clicks but no signups? | Search Console plus product analytics | Join the landing page to the signup funnel |
| Is the site fast on phones? | Search Console, PageSpeed Insights | Core Web Vitals report |
| Are AI assistants citing us? | Bing Webmaster Tools AI reporting, plus manual checks | Ask the assistants your target questions and note citations |
| Are links growing? | Search Console Links report, or a link tool | Top linked pages, new linking domains |

Product analytics for the signup funnel is in
`docs/developer/analytics-setup.md` and
`docs/developer/tracking-plan.md`. SEO tells you who arrived. Product
analytics tells you what they did next. You need both.

### 6.2 Weekly and monthly rhythm

**Weekly (30 minutes):**

* Search Console: any new errors, any page that dropped out of the
  index, any manual action.
* Top queries: any new query worth a page, any query where you rank on
  page two and a small improvement could move you to page one.
* One fix: the single highest-value fix from the list above.

**Monthly (half a day):**

* Lighthouse on the homepage, pricing, and top three content pages.
* Broken links across the site.
* The five pages with the most impressions and the lowest click-through
  rate: rewrite their titles and descriptions.
* The three most out-of-date pages: update facts, prices, and dates.
* New links: who linked to you, and is there a page they linked to that
  deserves a follow-up.

**Quarterly (one day):**

* Full technical audit: crawl the site, check canonicals, redirects,
  sitemap, robots.txt, structured data.
* Refresh the keyword table in section 8. Retire keywords you have won
  or lost interest in. Add the next five.
* Review competitor pages that outrank you for your target queries.
  What do they answer that you do not?

### 6.3 What good looks like

Do not promise yourself a traffic number. Traffic depends on the niche,
the competition, and how many pages you publish. Judge by direction and
by quality, not by a single number.

| Time | What good looks like |
|---|---|
| 3 months | All ten starter pages indexed. A handful of queries on page two or three. First signups from search, even if few. No indexing errors. |
| 6 months | Several starter pages on page one for long-tail queries. A steady trickle of signups from search each week. One or two pages earning links without you asking. |
| 12 months | A clear set of pages that reliably bring signups. Search is one of your top three acquisition channels. You know which pages earn and which do not, and you update the earners. |

If after six months of publishing good pages nothing ranks, the problem
is usually one of these: the pages are not indexed (run the runbook),
the keywords are too competitive (narrow them), the pages do not match
intent (rewrite the top), or the site is too slow or JS-only (fix the
technical section). Do not buy links to fix it.

### 6.4 When SEO is the wrong channel

SEO is the wrong first channel when:

* You have no product yet, and no page to send traffic to. A waitlist
  page and a few problem pages can help, but a full SEO program cannot.
* Your buyers do not search. Some products are bought by referral, by
  sales, or by community. If your first ten customers all came from a
  community, invest there first.
* You need signups this week. SEO will not deliver them. Paid search,
  a launch, or direct outreach will.
* You cannot maintain pages. A stale blog with three posts from last
  year hurts trust more than no blog.

In those cases, do the indexing runbook once, publish the homepage and
pricing page well, and come back to SEO when you have a product and a
month to spare.

---

## 7. A 90-day starter plan

This plan assumes one person, a few hours a week, and a product that
already exists. Scale the counts down, never the quality, if you have
less time.

### Weeks 1 to 2: Foundations

* Run `skills/search-indexing-skill/SKILL.md` end to end. Consoles
  verified, sitemap submitted, robots.txt with AI policy set,
  structured data on the homepage and pricing page.
* Fix Core Web Vitals on the homepage and pricing page.
* Write the keyword table in section 8. Ten keywords, with intent and
  source for each.
* Write a one-sentence brief for each of the ten pages (section 2.2).

### Weeks 3 to 6: First five pages

* Publish one page per week, in order of closeness to buying.
* Each page: one job, answer-first opening, headings, one honest next
  step, internal links to the homepage and pricing page, unique title
  and description, structured data where it fits.
* Submit each new URL in Search Console (a handful of pages only, not
  mass requests) and notify Bing with IndexNow on deploy.
* Start the weekly Search Console check.

### Weeks 7 to 10: Next five pages, and fix the first five

* Publish the remaining five pages, one per week.
* Re-read the first five with fresh eyes. Fix the title and description
  of any page with impressions but few clicks. Add the answer you wish
  you had included.
* Publish one comparison page and one use-case page from section 3.
* Ask three happy users for a quote, a link, or a review. Ask after a
  positive moment, not at random.

### Weeks 11 to 13: Measure and decide

* Monthly review from section 6.2. Which pages earn impressions, clicks,
  and signups? Which do not?
* Update the three most out-of-date pages. Retire or merge any page that
  earns nothing and serves no job.
* Decide the next ten keywords, or decide SEO is not your channel yet
  and pause it honestly. Either decision is better than publishing
  without measuring.

### Page brief format (copy this for each page)

```text
Page: [URL]
Query: [the exact query this page answers]
Intent: [informational / commercial / transactional]
Reader: [kind of person]
Job: [what they want to do]
Next step: [signup / trial / read next page / contact]
Source for the keyword: [user quote / support ticket / Search Console / tool, with date]
Author: [real person]
Last updated: [date]
```

---

## 8. Fill-in tables

### 8.1 Keyword table

| # | Keyword (query) | Intent | Reader | Page (URL) | Source | Status |
|---|---|---|---|---|---|---|
| 1 | [query] | [intent] | [person] | [URL] | [source, date] | [not started / draft / live / ranking] |
| 2 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 3 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 4 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 5 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 6 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 7 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 8 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 9 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |
| 10 | [query] | [intent] | [person] | [URL] | [source, date] | [status] |

### 8.2 Checklist

* [ ] Indexing runbook done: `skills/search-indexing-skill/SKILL.md`
* [ ] Ten starter keywords chosen, with intent and source for each
* [ ] One page brief per keyword, with the job and next step written
* [ ] Homepage, pricing, and top pages pass Core Web Vitals on mobile
* [ ] Marketing pages are server-rendered, not JS-only
* [ ] Every indexable page reachable within three clicks from home
* [ ] Unique title and description on every public page
* [ ] Structured data on homepage, pricing, and articles, with real values only
* [ ] AI crawler policy set deliberately in robots.txt (search bots allowed)
* [ ] Weekly Search Console check scheduled
* [ ] Monthly title and description review scheduled
* [ ] Quarterly technical audit scheduled
* [ ] Comparison pages dated and re-checked quarterly, with no invented prices
* [ ] No page published without a real author and a last-updated date

---

## Related docs

* `skills/search-indexing-skill/SKILL.md`: the indexing runbook (do this first)
* `docs/guides/SEO_SETUP_GUIDE.md`: technical foundations and AI search background
* `docs/developer/seo-guide.md`: meta tags, structured data, and SPA code
* `docs/developer/analytics-setup.md`: PostHog and GA4 setup for the funnel
* `docs/developer/tracking-plan.md`: event names for signup and activation
* `docs/guides/DIGITAL_PRESENCE_CHECKLIST.md`: every place the product exists online
* `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`: launch evidence rules that apply to SEO changes too
