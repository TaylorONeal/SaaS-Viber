# Battlecard Template

Copy one block per competitor into `docs/competitive/<competitor-slug>.md` (full
depth) or under a heading in `docs/competitive/README.md` (brief depth). Fill
every cell or write `UNVERIFIED`. Keep each card to about half a page: tables
over paragraphs.

---

```markdown
## [Competitor] -- [THREAT: EXTREME | HIGH | MEDIUM | LOW | NONE]

> Ring: Peer | Challenger | Adjacent | Substitute
> Last researched: YYYY-MM-DD

### Snapshot

| Field | Detail | Source (date) |
|-------|--------|---------------|
| Model | Subscription / per-seat / per-client / take rate / one-time / freemium | |
| Pricing | Exact tiers and the upgrade cliff | |
| Free tier / trial | | |
| Who pays | Operator, end customer, or both | |
| Funding / revenue | Last round, total raised, any revenue signal | |
| Buyer | Persona and size they actually sell to | |
| Platforms | Web / iOS / Android / API | |
| Store rating | iOS x.x (n ratings), Android x.x (n ratings) | |
| Last update | Most recent release date and cadence | |

### Where they win

- What they are genuinely good at. Be honest; this is what we lose deals on.

### Where they lose

- Gap that matters to our buyer -- source
- Top review complaint theme and count -- link to `reviews.md`

### Strategic direction

What the last 90 days of launches, hires, funding, and pricing changes say about
where they are heading.

### Landmine questions

Questions a buyer can ask them that expose the gap:

- "How do I ... without ...?"
- "What does it cost at [realistic size]?"

### How we win

| Objection (what the buyer says) | Response (30 seconds) | Proof point | Weapon |
|---------------------------------|-----------------------|-------------|--------|
| "We already use X and it works." | | | |
| "X is cheaper." | | | |

### When to walk away

The buyer they serve better than we do. Do not chase this one.
```

---

## Summary sections (after the cards)

1. **Threat matrix:** competitor, ring, threat, pricing model, one-line why.
2. **Pricing comparison:** link to `pricing.md` or inline the normalized table.
3. **Unserved gaps:** what nobody does well.
4. **Positioning weapons:** 3-5 differentiators with why each wins and the proof.
