---
name: competitive-research
description: Evidence-first competitive research for any app or SaaS -- competitor set in four rings, pricing teardown, App Store / Play listing and review mining, feature parity vs differentiation, threat levels, buyer-ready battlecards with objection handlers, and positioning, every claim cited and dated. Load for "battlecard", "competitive analysis", "who are our competitors", "how do we beat X", "pricing vs X", "what are reviewers complaining about", or before positioning, pricing, roadmap parity calls, or a store listing.
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

## 2. Build the competitor set (four rings)

| Ring | Definition | How many |
|------|------------|----------|
| **Peers** | Same job, same buyer, similar product | 3-5 |
| **Challengers** | Newer or disruptive players reshaping the category (new model, new channel, new price point) | 2-4 |
| **Adjacent** | Different category the buyer could stretch to cover the job, or one feature away from competing | 2-3 |
| **Substitutes** | What people do instead: spreadsheets, Notes app, DMs, paper, a generic tool, hiring someone, doing nothing | 1-3 |

Find candidates from: store search for your top 5 keywords (top 10 results each),
"alternatives to X" pages, G2 / Capterra category pages, Reddit and community
threads where buyers ask for recommendations, the competitors' own comparison
pages, and Product Hunt. Substitutes almost never show up in search; ask what the
buyer did last week.

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
6. **Go-to-market:** paid ads (Meta Ad Library, Google Ads Transparency),
   social presence, partnerships, SEO pages they rank for.
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

| Feature | Us | Peer A | Peer B | Challenger | Class | Call |
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

One card per Peer and Challenger at MEDIUM or above (Adjacent only if HIGH+).
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
2. Threat matrix (competitor, ring, threat, one-line why).
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
