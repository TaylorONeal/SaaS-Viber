# Agent Optimization

> **Status:** Guide for two different jobs that share one name. Keep them
> separate.
> **Audience:** First a first-time founder, then an expert, then an AI agent.
> **As of:** Nov 8, 2026. AI search products and agent tools change often.
> Treat every dated claim about what an AI product does as a snapshot, and
> re-check it before you build around it.

## In one minute

"Agent optimization" means two different things, and mixing them up is
the most common mistake in this area.

**Meaning A: Optimizing FOR agents.** Make your website and your docs
usable by AI agents and AI search: the machines that read your pages,
answer questions about your product, and cite you. That is mostly good
writing, server-rendered HTML, clean structure, and honest facts.

**Meaning B: Optimizing the agents that BUILD your app.** Make the AI
coding agents you use faster, safer, and more reliable: clear tasks,
good repo instructions, verification before done, and human-only gates
for the things an agent must never decide alone.

This guide covers both, in that order, and never lets one stand in for
the other. A site that is easy for AI search to read does not make your
coding agent better. A coding agent that ships fast does not make your
site citable. You need both, and they are different work.

The indexing runbook that Meaning A builds on is
`skills/search-indexing-skill/SKILL.md`. The strategy that Meaning A
serves is `docs/guides/SEO_STRATEGY.md`. Do not repeat either here.

---

## Part A: Optimizing FOR agents (AI search and AI readers)

### A.1 What "for agents" means, in plain language

An AI agent that meets your product is usually doing one of three jobs:

1. **Answering a question.** A person asks an assistant "what is the best
   tool for X" or "how do I do Y". The assistant searches, reads a few
   pages, and answers, sometimes with a citation to your page.
2. **Fetching a page live.** A person pastes your link into a chat and
   asks "summarise this" or "what does this cost". The assistant fetches
   the page and reads it.
3. **Acting on your site.** A person asks an agent to check your pricing,
   read your docs, or compare your product with another. The agent reads
   the same public pages a person would read.

In all three cases, the agent is a reader first. It reads what is in the
HTML. It does not run your app, does not guess what you meant, and does
not fill in missing facts. If the fact is not on the page, in plain text,
the agent cannot use it. If the fact is wrong on the page, the agent will
repeat it as if it were true.

So optimizing for agents is mostly this: write pages a careful reader
can understand, in HTML a machine can read, with facts that are true,
dated, and checkable.

### A.2 The checklist, in order

Do these in order. Each one depends on the one before it.

**1. Server-rendered HTML for every public page.**

The main text must appear in the raw HTML, not only after JavaScript
runs. Most AI crawlers do not execute JavaScript. Google renders pages
later, but AI search bots usually do not. Test it the way the runbook
tests it: fetch the page with `curl` and check that the title, the
answer, and the price are in the output. Marketing pages, pricing, blog,
and docs must pass this test. App pages behind login do not need it.
See `skills/search-indexing-skill/SKILL.md` section 1 and
`docs/developer/seo-guide.md`.

**2. Answer-first copy.**

Start each page and each section with a direct answer, then the detail.
One sentence that defines the thing, names who it is for, and says what
it costs or what it does. Then expand. This is what AI answer engines
quote, and it is also what a busy person reads first. Full pattern:
`docs/guides/SEO_STRATEGY.md` section 5.

**3. Clean structure.**

One `<h1>` per page that matches the real topic. Logical `<h2>` and
`<h3>` headings. Short paragraphs. Lists and tables where a list or a
table is the clearest form. Descriptive link text, not "click here".
Every image has descriptive `alt` text, or empty `alt` if it is
decorative. This is basic accessibility and basic machine readability
at the same time.

**4. A sitemap that lists only real, indexable pages.**

Only canonical URLs that return 200. No login pages, no admin pages, no
API routes, no duplicates. `lastmod` is the date of the last significant
content change, never the build date. Generate it at build time from the
route list, never by hand. Full rules:
`skills/search-indexing-skill/SKILL.md` section 2.1.

**5. A robots.txt with an explicit AI crawler policy.**

Decide three jobs separately, and write the policy down:

| Job | Who | Default for a business that wants to be found |
|---|---|---|
| Search index for AI answers and citations | AI search bots and live fetchers | Allow |
| Live fetch when a user asks about a page | User fetchers | Allow |
| Model training | Training crawlers | Owner's choice |

Blocking AI search bots removes you from AI answers. Blocking training
crawlers is a separate content licensing decision, and it does not remove
you from search. Do not confuse the two. The token table and the
template are in `skills/search-indexing-skill/SKILL.md` section 2.2.
Check your host's bot management and WAF settings too: a "block AI
bots" toggle can silently block the good bots you just allowed.

**6. Structured data with real values only.**

JSON-LD in the server-rendered HTML, one connected graph, values drawn
from the same source as the visible page so the two cannot drift. For a
SaaS, the types that matter are Organization, WebSite,
SoftwareApplication with a real price, Article or BlogPosting with a
real author and dates, and BreadcrumbList. Never mark up content that
is not visible on the page. Never invent reviews, ratings, prices,
addresses, or hours. Fake markup earns manual actions. Full types:
`skills/search-indexing-skill/SKILL.md` section 6.

**7. llms.txt as an optional map, never as a fix.**

A `/llms.txt` file is a markdown list of your key pages, written for
language models. As of Nov 8, 2026, about 1 in 10 sites ship one, but
no major AI search product has committed to reading it, and Google has
said it does not use it. Add it only if it is cheap. Never add it
instead of crawlable HTML, a clean sitemap, and an explicit robots.txt
policy. If you add it, keep it short, keep every link real, update it
when pages move, and serve it with an `X-Robots-Tag: noindex` header so
it does not show up as a search result. See
`skills/search-indexing-skill/SKILL.md` section 2.3 and
`docs/guides/SEO_SETUP_GUIDE.md` section 10.

**8. Dates and sources on every fact that matters.**

AI engines prefer facts they can verify and date. Put a "last updated"
date on every content page and update it only when the content actually
changes. State prices with their as-of date and a "verify the current
price" note. Name the source of a claim where the claim is not yours.
A page with no date and no source is a page an engine will hesitate to
cite, and a person will hesitate to trust.

**9. A public API or MCP surface only if you actually have one.**

Some founders ask whether they should ship an API or an MCP server so
agents can use their product. The answer is: only if the product already
has an API that real users need, and only if you can support it. An API
built only so an agent can call it, with no real users, is a maintenance
burden that nobody uses. A documented, versioned API with real
authentication, rate limits, and an honest status page is useful to
agents and to people. A fake or half-built one is worse than none.
Do not list an API, an MCP server, or an integration in your docs or
your structured data unless it exists, works, and is supported. That is
the same rule as for prices and reviews: only mark up what is true.

### A.3 What not to do (Meaning A)

* Do not block all AI crawlers by default. That removes you from AI
  answers and from the assistants your future customers use. Decide
  per job, as in A.2 step 5, and write the decision down.
* Do not publish a fake llms.txt. A map that lists pages that do not
  exist, prices that are wrong, or features you do not ship is worse
  than no map. An agent that follows it will quote the wrong thing.
* Do not let an agent invent prices, dates, testimonials, reviews, or
  customer names for your site. Every one of those must come from a
  real source, with a date, and must be checkable. See Part B for the
  rule that stops this at the source.
* Do not hide your content behind JavaScript and then add llms.txt to
  compensate. The crawlers that matter read HTML. Fix the HTML.
* Do not stuff keywords. AI models detect it and deprioritise the page,
  and people leave.
* Do not create thin pages hoping AI search will cite them. Depth wins.
  One genuinely useful page beats ten thin ones.

### A.4 How to know it is working

* Ask the assistants your target questions, once a month, and note
  whether your pages are cited, and whether the citation is accurate.
  Record the date and the exact question. A citation that is wrong is a
  bug in your page, not in the assistant.
* Check Bing Webmaster Tools AI reporting (menu location changes, verify
  it) and Search Console for the queries that bring people to the site.
* Check that a fresh fetch of your homepage and pricing page, by curl,
  still contains the answer and the price. If a redesign breaks that,
  you have broken Meaning A, whatever the design looks like.

### A.5 Checklist (Meaning A)

* [ ] Public pages are server-rendered; the answer and the price appear in raw HTML
* [ ] Each page starts with a direct answer, then detail
* [ ] One `<h1>` per page, logical headings, descriptive link text, real `alt` text
* [ ] Sitemap lists only canonical, indexable, 200-status pages, with honest `lastmod`
* [ ] robots.txt has an explicit AI crawler policy, decided per job, and the host WAF does not silently block the allowed bots
* [ ] Structured data is real, visible, and in one source with the page content
* [ ] llms.txt, if present, is short, accurate, and served with `noindex`; it is not a substitute for HTML
* [ ] Every content page shows a last-updated date; prices carry an as-of date
* [ ] No API, MCP server, integration, price, review, or testimonial is claimed unless it exists and is supported
* [ ] Monthly check: ask the assistants the target questions and record citations

---

## Part B: Optimizing the agents that BUILD your app

### B.1 What "for agents" means here, in plain language

A coding agent (Claude Code, Cursor, Copilot, Codex, or any CLI agent)
is a fast junior developer with no memory of your project, no judgement
about what matters, and a strong tendency to sound confident. It will do
exactly what you asked for, including the parts you did not mean, unless
the repo tells it what good looks like and how to check its own work.

Optimizing the build agent means giving it three things: context it can
load in one pass, tasks it can actually finish, and a way to prove the
work is done. This repo already has the context layer. This section is
about using it well.

### B.2 The agent interface this repo already provides

These files are the agent interface. An agent that starts work here
should load them before it writes code. A human who asks an agent to
work here should point it at them.

| File | What it is | Who loads it |
|---|---|---|
| `AGENTS.md` | Repository-level onboarding for CLI agents and Codex | Any CLI agent, at session start |
| `CLAUDE.md` | Auto-loaded context and coding conventions for Claude Code | Claude Code, automatically |
| `.cursorrules` | Project context for Cursor | Cursor, automatically |
| `skills/README.md` | How reusable skills work, and the list of skills | Any agent, when the task matches a skill |
| `docs/ai-agents/AGENTS.md` | Reusable onboarding template for AI assistants | Any agent, as a template for a new repo |
| `docs/ai-agents/MODERN_AGENTIC_DEVELOPMENT.md` | Long-context, tool-using agent operating model | Any agent, for long tasks |
| `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` | The launch playbook, with evidence rules | Any agent, for launch work |
| `skills/search-indexing-skill/SKILL.md` | The indexing runbook | Any agent, for indexing work |

Keep these files short, current, and honest. An agent interface that
describes a repo that no longer exists is worse than no interface: the
agent will follow the stale instructions with confidence. When the repo
changes, update the interface in the same change. When a lesson is
learned, add it to the interface, generalised, in the same session.

### B.3 How to write a task an agent can actually do

A task an agent can finish has five parts. If any part is missing, the
agent will guess it, and the guess will be wrong in the way that is
hardest to spot.

1. **Outcome.** What exists when the work is done, in concrete terms.
   "A new guide at `docs/guides/X.md`" is an outcome. "Improve the
   docs" is not.
2. **Constraints.** What the agent must not do. "Do not push to GitHub",
   "do not touch live billing configuration", "no em dashes", "do not
   invent prices". Constraints are as important as the outcome.
3. **Context.** The files to read first, the decisions already made,
   and the facts already verified. Link to the files, do not paste
   them. An agent that has to discover the context will discover the
   wrong version of it.
4. **Evidence.** How the agent proves the work is done. A link check
   that passes, a test run with output, a console screenshot, a dated
   tracker entry. The evidence is named in the task, before the work
   starts.
5. **Done criteria.** The sentence that ends the task. "Done means the
   file exists at the path above, the link check passes, and the summary
   lists the files and word counts." An agent without done criteria
   keeps polishing, or stops early, and neither is visible.

A short template, copied from the way this repo's own tasks are written:

```text
Task: [one sentence, outcome first]
Read first: [2 to 5 files, with paths]
Do not: [constraints, one per line]
Evidence: [what proves it, and where it goes]
Done means: [one sentence]
```

### B.4 Verification packets

A verification packet is the evidence an agent hands back with its
work, so a human (or another agent) can check it without redoing the
work. Every substantial agent task in this repo should end with one.
The packet has four items, and no more:

1. **What changed.** Files, with paths, and one line each on what
   changed in them.
2. **What was checked.** The command run, the test, or the console
   visited, with the result. A passing link check, a test run, a
   `curl` output. Quote the result, do not summarise it as "it worked".
3. **What was not checked.** The things the agent could not verify, and
   why. "Could not verify the live price" is useful. Silence is not.
4. **What is still open.** The next step, the decision that needs a
   human, or the fact that needs checking.

The rule that makes packets work: **an agent never marks its own work
done without evidence.** "Done" means the evidence exists and is cited.
A summary that says "done" with no evidence is not done. It is
unverified. Write `UNVERIFIED` where there is no evidence, and let a
human decide whether that is acceptable. The same rule is in
`docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` for launch gates, and it
applies to docs, code, and config alike.

### B.5 Skills and prompt guides as the agent's tools

This repo carries reusable skills in `skills/` and prompt guides in
`docs/`. They are the agent's tools, not decoration. The rule for using
them is simple: when a task matches a skill, load the skill first, read
it, and follow it. Do not improvise a procedure the skill already
covers. When a task matches no skill, do the work, and if the work will
recur, write the skill down afterwards, starting from the template in
`skills/README.md`.

Prompt guides are the same idea for writing: a guide that tells an
agent how to write a PRD, an architecture doc, or a launch guide, with
the questions to ask and the shape of the answer. They exist so that
ten agents produce ten docs in the same shape, not ten different shapes.

### B.6 Human-only gates

Some things an agent must never do, even when asked politely, and even
when it could technically do them. In this repo, the human-only gates
are: signing agreements, entering passwords or sandbox credentials,
banking and tax forms, trader declarations, dragging files into a store
console, the final Submit for Review, and releasing a manual release.
The full list, with the numbered script the agent hands the human
instead, is in `skills/launch-skill/SKILL.md` and in
`docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` section 1.

The principle generalises: any step that spends money, signs a legal
agreement, publishes to a store, or cannot be undone is human-only.
An agent prepares it, reports the exact state, and hands the human a
numbered script. It does not click the button.

### B.7 What not to do (Meaning B)

* Do not let an agent invent facts. Prices, dates, testimonials,
  reviews, customer names, statistics, and URLs must come from a real
  source, with a date, or be marked as fill-ins. An agent that invents
  a price to complete a table has created a lie that will be quoted.
* Do not let an agent mark its own work done without evidence. See B.4.
* Do not let an agent work from a stale interface. If `AGENTS.md` or
  `CLAUDE.md` describes a repo that has changed, update the file first.
* Do not give an agent a task with no done criteria. It will either
  stop early or keep polishing, and you will not be able to tell which.
* Do not let an agent touch live billing, live store listings, or live
  credentials. Those are human-only, or a separate, explicitly approved
  step with evidence.
* Do not accept a summary as a delivery. A built batch, a drafted doc,
  or a passing test is not delivery until the evidence is cited and the
  file is where the task said it would be.

### B.8 Checklist (Meaning B)

* [ ] The task has an outcome, constraints, context, evidence, and done criteria, written down before work starts
* [ ] The agent loaded the matching skill or prompt guide first, if one exists
* [ ] The agent loaded `AGENTS.md` or `CLAUDE.md` or `.cursorrules` for this repo
* [ ] No price, date, testimonial, review, statistic, or URL was invented; fill-ins are marked as fill-ins
* [ ] The verification packet lists what changed, what was checked with results, what was not checked, and what is still open
* [ ] No step is marked done without cited evidence; unverified work is labelled `UNVERIFIED`
* [ ] Human-only gates were prepared, not performed, with a numbered script for the human
* [ ] The agent interface (`AGENTS.md`, `CLAUDE.md`, skills) was updated in the same change if the repo changed

---

## How the two meanings fit together

Meaning A makes your product findable and citable by machines.
Meaning B makes your building process reliable enough that the facts
Meaning A publishes are true. If Meaning B fails, Meaning A publishes
lies faster. If Meaning A fails, Meaning B builds a product nobody
finds. Do Meaning B first for any given change, then Meaning A for the
page that describes it. In that order, every time.

---

## Related docs

* `skills/search-indexing-skill/SKILL.md`: the indexing runbook Meaning A builds on
* `docs/guides/SEO_STRATEGY.md`: the strategy Meaning A serves
* `docs/guides/SEO_SETUP_GUIDE.md`: technical foundations and AI search background
* `docs/developer/seo-guide.md`: meta tags, structured data, and SPA code
* `docs/developer/analytics-setup.md`: PostHog and GA4 setup for measuring what agents and people do next
* `docs/developer/tracking-plan.md`: event names for the funnel
* `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`: launch evidence rules and human-only gates
* `AGENTS.md`: repository onboarding for CLI agents
* `CLAUDE.md`: Claude Code context
* `.cursorrules`: Cursor context
* `skills/README.md`: how reusable skills work
* `docs/ai-agents/AGENTS.md`: reusable onboarding template
* `docs/ai-agents/MODERN_AGENTIC_DEVELOPMENT.md`: long-context agent operating model
