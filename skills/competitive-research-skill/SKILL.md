---
name: competitive-research
description: Evidence-first competitive research for any app or SaaS -- competitor set typed Direct (Peer Competitor, Innovative Challenger) vs Different but Related, Substitute and DIY, pricing teardown, App Store / Play listing and review mining, feature parity vs differentiation, threat levels, buyer-ready battlecards with objection handlers, and positioning, every claim cited and dated. Load for "battlecard", "competitive analysis", "who are our competitors", "how do we beat X", "pricing vs X", "what are reviewers complaining about", or before positioning, pricing, roadmap parity calls, or a store listing.
---

# Competitive Research Skill

This is the operating procedure. The blank fill-in framework lives in
SaaS-Viber's [`docs/roadmap/COMPETITOR_ANALYSIS.md`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/docs/roadmap/COMPETITOR_ANALYSIS.md); the per-competitor battlecard shape is in
[`references/battlecard.md`](./references/battlecard.md) and the review method is
in [`references/review-mining.md`](./references/review-mining.md).

The job is a decision, not a document. Every run ends with what to build, price,
say, or stop doing, backed by sources a skeptic can click.

## 0. Ground rules (always)

- **Cite or cut.** Every pricing number, feature claim, rating, funding figure, and
  quote carries a source URL and the date you read it. No source means
  `UNVERIFIED` in the cell, not a guess.
- **Read the page itself.** Pricing comes from the competitor's own pricing page
  or store listing, not a review site or a search snippet. Note region and
  currency.
- **Their claims are theirs.** Write "X says it has 10,000 studios", never "X has
  10,000 studios", unless a third party confirms it.
- **Check for the dead.** Look for shutdowns, acquisitions, and pivots before
  writing a card. A defunct competitor is a NONE threat and an acquisition
  channel (its orphaned users).
- **Date the file.** Top of every output: last researched date and next review
  date.
- **Public vs private.** Outputs about a specific app live in that app's repo or a
  private research repo, never in this template. This skill stays generic.
- **No "AI-powered" weapon.** Do not make AI the differentiator or the lead in any
  positioning or copy this skill produces. Buyers discount it and it ages badly.
  Lead with the outcome the user gets.
- **No unprovable knocks.** A comparative claim in public copy must be true,
  current, and sourced. Keep spicy takes in the internal battlecard.

## 1. Frame the question first

Before searching, write three lines at the top of the output:

1. **Decision this serves:** positioning, pricing, roadmap parity, store listing,
   sales or partner pitch, investor or board prep.
2. **Buyer:** who chooses (persona, company size, who pays vs who uses).
3. **Depth:** `brief` (1 page, 3-5 competitors, an hour) or `full` (one card per
   competitor, 8-12 competitors, review mining).

If the decision is unclear, ask one question. Otherwise default to `brief` and
say so.

## 2. Build the competitor set (direct vs indirect)

Every competitor gets a **Type**, and every Direct competitor gets a **Direct
tier**. The tier names come from the ThinkerMetrics competitor-selection
framework (Peer Competitor, Innovative Challenger, Different but Related); this
skill adds Substitute and DIY / status quo so that products solving the job a
different way never get ranked as direct rivals.

| Type | Direct tier | Definition | How many |
|------|-------------|------------|----------|
| **Direct** | **Peer Competitor** | Same buyer, same job, solved the same way. The "traditional" competitor. | 3-5 |
| **Direct** | **Innovative Challenger** | Same buyer and job, but changing how the market works: new model, channel or price point, often smaller or newer. **Not** an established status quo player; an incumbent with a new feature is still a Peer. | 2-4 |
| **Different but Related** | | Same kind of product for a neighboring buyer or market, or one feature away from competing (a Pilates planner vs a yoga planner, consumer practice apps vs a teacher tool). | 2-3 |
| **Substitute** | | A different kind of product the buyer uses to get the same job done (Canva for schedule graphics, Calendly for bookings, Etsy PDFs instead of a planner). Solves the job, is not the same product. | 1-3 |
| **DIY / status quo** | | No product built for the job: spreadsheets, Venmo and DMs, paper, a bio line, a bookkeeper, doing nothing. | 1-3 |

Rules that follow from the split:

- **Top threats rank Direct only.** Substitutes and DIY get their own short list
  ("what we really replace") and never sit in the top-threats ranking, however
  big they are. Canva is not a direct competitor to a schedule tool even though
  every buyer uses it.
- **Different but Related** can be rated HIGH when it is one feature or one
  market move away; say which move in the rationale.
- When a tracking sheet exists, add `Type` and `Direct tier` columns and tag
  every row; never leave a row untyped.

Find candidates from: store search for your top 5 keywords (top 10 results each),
"alternatives to X" pages, G2 / Capterra category pages, Reddit and community
threads where buyers ask for recommendations, the competitors' own comparison
pages, and Product Hunt. Substitutes almost never show up in search; ask what the
buyer did last week.

**Social-first sweep.** Many new consumer and creator apps never rank in store
search or on G2; they grow through Instagram, TikTok, creator founders and paid
ads. Run this sweep for any consumer, creator or prosumer product:

- **Ad libraries:** Meta Ad Library (facebook.com/ads/library, all countries,
  "All ads") and TikTok's Top Ads / Creative Center for your top 5 job keywords
  ("class planner", not your category jargon). A competitor running ads now is
  spending to win your buyer now. Record the hook line and the first frame.
- **Creator search:** the buyer's own hashtags plus "app" (for example
  `#pilatesinstructor app`) and "how I plan my classes" style posts. Note which
  tools appear on screen, not just in captions.
- **Bio links:** a social account's bio link is often the only route to the
  product; follow it to the store page or site and verify there.
- **Pasted reports and screenshots** (from a person, a newsletter or another AI)
  are leads, not evidence. Verify every named product on its own page before it
  enters the log, and record what did not check out.

Count a social-first product in the set when it targets the same buyer and job,
even with tiny store ratings: ad spend and creator reach move faster than
reviews.

Cap the set at 12. More is a list, not research.

## 3. Research lanes (per competitor)

Run the lanes that matter for the decision. `brief` runs 1-3; `full` runs all.

1. **Website and pricing:** headline promise, target buyer, tiers, limits that
   force upgrades, trial length, card-required, annual discount, who pays.
2. **Store listing** (if they ship an app): title, subtitle, rating, rating
   count, last update date, update cadence, in-app purchase list and prices,
   screenshot story (what the first 3 frames sell), category rank if visible.
   Check both App Store and Google Play; they often differ.
3. **Reviews:** follow `references/review-mining.md`. Mine 1-3 star reviews for
   pain and 5 star reviews for love. Quote verbatim with a link.
4. **Product velocity:** changelog, release notes, store "What's New" history,
   blog. What shipped in the last 90 days tells you direction.
5. **Money and team:** funding (Crunchbase, press), headcount trend (LinkedIn),
   job postings (where they are investing next).
6. **Go-to-market:** paid ads (Meta Ad Library, TikTok Creative Center, Google
   Ads Transparency), social presence (handle, posting cadence, founder-creator
   or not), partnerships, SEO pages they rank for. Quote the ad hook; hooks are
   the competitor's positioning in their own words.
7. **Community voice:** Reddit, Facebook groups, Discord, forums. What buyers say
   when the vendor is not in the room.

## 4. Pricing teardown

Do not just list tiers. Normalize so prices compare:

| Competitor | Model | Free tier | Price at small | Price at mid | Price at large | Trial | Source + date |
|------------|-------|-----------|----------------|--------------|----------------|-------|---------------|

- Pick three realistic customer sizes for your buyer (for example 1 user / 10
  clients, 3 users / 100 clients, 10 users / 1,000 clients) and compute the
  monthly cost at each, including per-seat, per-client, and transaction fees.
- Mark the **cliff**: the limit that forces an upgrade.
- Mark **who pays**: the operator, the end customer (booking fees, take rate), or
  both.
- Note store price tiers vs web prices when they differ.

## 5. Feature parity vs differentiation

List every feature the buyer weighs, then classify it. This is the roadmap
output.

| Feature | Us | Peer A | Peer B | Innovative Challenger | Class | Call |
|---------|----|--------|--------|------------|-------|------|

Ratings: Full (F), Partial (P), None (N), Planned (PL), each with a source for
competitors.

| Class | Meaning | Call |
|-------|---------|------|
| **Table stakes** | Most peers have it and buyers expect it | Match it. Missing it loses deals before they start. |
| **Parity gap** | We lack it, some peers have it, buyers ask for it in reviews | Prioritize by review frequency. |
| **Differentiator** | We do it and peers do not, or we do it clearly better | Protect it, lead with it, prove it. |
| **Deliberate non-goal** | Peers have it, we chose not to | Write the reason down so nobody rebuilds it. |
| **Open gap** | Nobody does it well and reviewers want it | Candidate wedge. Validate before building. |

## 6. Threat levels

| Level | Definition | Review cadence |
|-------|------------|----------------|
| **EXTREME** | Overlapping buyer and strong execution. Could take our users now. | Monthly |
| **HIGH** | Strong in an adjacent space, one feature or channel away from EXTREME. | Monthly |
| **MEDIUM** | Relevant, but different buyer, model, or delivery. | Quarterly |
| **LOW** | Tangential buyer or segment. | Twice a year |
| **NONE** | Defunct, pivoted away, or no overlap. Note if its users are up for grabs. | Annually |

Give each rating one line of rationale. A threat rating without a reason is a
vibe.

## 7. Battlecards

One card per Direct competitor (Peer Competitor or Innovative Challenger) at MEDIUM or above. Different but Related only if HIGH+. Substitutes and DIY get a line in the README, not a card.
Use `references/battlecard.md`. Every card has, at minimum:

- Snapshot table (model, pricing, funding, buyer, last update)
- Where they win (be honest; this is what sales hears)
- Where they lose (gaps, with sources)
- Landmine questions (questions a buyer can ask them that expose the gap)
- 2-4 objection handlers: objection, response, proof point
- When to walk away (the buyer they genuinely serve better)

Objection handlers must be sayable in 30 seconds and map to a positioning weapon
from section 8.

## 8. Positioning

1. **Weapons table:** the 3-5 differentiators that win, each with why it wins
   and the proof. Every "How we win" line in the cards maps back to one of these.
2. **Positioning statement:** For [buyer] who [pain], [product] is a [category]
   that [outcome]. Unlike [main alternative], we [differentiator].
3. **Unserved gaps:** niches, price points, or jobs no competitor serves well.
4. **Copy implications:** the one line for the store subtitle or hero, and words
   to avoid because every competitor already uses them.

Store metadata rule: never put competitor names in an app's title, subtitle,
keyword field, or screenshots. Both stores reject it. Compete on the job, not the
name.

## 9. Output layout (in the app's repo)

```
docs/competitive/
  README.md            <- dated header, decision, threat matrix, weapons, index
  <competitor-slug>.md <- one battlecard per competitor (full depth only)
  pricing.md           <- normalized pricing teardown
  reviews.md           <- review themes, counts, verbatim quotes with links
  parity.md            <- feature parity vs differentiation table
  sources.md           <- every URL with the date read
```

For `brief` depth, put everything in `docs/competitive/README.md`.

Update in place on re-runs. Add a **What changed since last run** section at the
top (price changes, launches, shutdowns, rating moves) so the delta is visible.

If the app repo is public and the research is sensitive (deal notes, partner
names, internal metrics), keep it in a private research repo and link to it.

## 10. Report back

The chat summary is short:

1. The decision and your recommendation in one or two sentences.
2. Threat matrix for Direct competitors (competitor, direct tier, threat, one-line why), then a separate line listing the substitutes and DIY habits we replace.
3. Top 3 parity gaps and top 3 differentiators.
4. Anything `UNVERIFIED` that the recommendation leans on.
5. Link to the output folder or PR.

## 11. Maintenance triggers

Re-run when: a competitor raises money, ships a major feature, changes pricing,
shuts down, or a new entrant shows up in your top store keywords; and at least
quarterly for anything HIGH or above.

## Related

Paths below are in SaaS-Viber. Installed elsewhere, use the links.

- [`docs/roadmap/COMPETITOR_ANALYSIS.md`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/docs/roadmap/COMPETITOR_ANALYSIS.md) -- blank framework and positioning matrix
- [`skills/search-indexing-skill/`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/skills/search-indexing-skill/SKILL.md) -- once positioning is set, get the pages found
- [`skills/launch-skill/`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/skills/launch-skill/SKILL.md) -- store listing and submission gates
- [`docs/guides/STOREFRONT_COPY.md`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/docs/guides/STOREFRONT_COPY.md) -- turning positioning into store copy
- [`docs/guides/PLG_FRAMEWORK.md`](https://github.com/TaylorONeal/SaaS-Viber/blob/main/docs/guides/PLG_FRAMEWORK.md) -- pricing and trial design
