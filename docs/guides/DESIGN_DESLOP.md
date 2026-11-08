# Design Deslop: An Integrated System in Our Own Version

> **Status:** Thinking layer for design quality. It does not replace the
> enforcement layer or the templates. It explains how to use them well.
>
> **Last updated:** Nov 8, 2026
>
> **Related docs:** [Taste Skill](../../skills/taste-skill/SKILL.md)
> (enforcement layer, the ban list lives here) |
> [Design System Overview](../design/README.md) |
> [Design Tokens](../design/02-design-tokens.md) |
> [Consumer Pages](../design/04-consumer-pages.md) |
> [Theming](../design/08-theming.md) |
> [Visual Inventory](../design/09-visual-inventory.md) |
> [Branding Guide](./BRANDING_GUIDE.md) |
> [Web to Mobile Launch Playbook](./WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md)
> (store screenshots come last)

## In one minute

"Slop" is the generic AI look: the same purple glow, the same font, the same
centered hero, the same three equal cards, the same hollow copy. Users have
learned to recognise it in under a second, and when they do, they trust the
product less, even if the product is good.

Deslop is not a new coat of paint. It is a way of working: study a pattern,
extract the principle behind it, rebuild it in your own voice, and add one
improvement of your own. That is how inspiration grows into something
better, instead of collapsing into a copy. This doc is that way of working,
written down so a founder, an expert, and an agent can all follow it.

Nothing in this doc changes a live app. A deslop run ends with a direction
the owner picks. The build happens one surface at a time, after that pick.

---

## 1. What slop is, and why it costs trust

Slop is not "bad design." It is design with no decisions in it. Every choice
is the default choice, so nothing in the product says anything about the
people who made it.

### The tells, in plain words

- **The glow.** A purple or blue gradient wash behind everything, usually
  with a soft outer glow on buttons. It says "AI made this" before the user
  reads a word.
- **The font.** Inter everywhere, at the same weights, doing nothing
  distinctive. Inter is a fine font. A product that uses it by default,
  with no pairing and no point of view, looks like every other product that
  used it by default.
- **The centered hero.** A headline in the middle, a subheadline in the
  middle, a button in the middle, over a dark image. It is the first layout
  every generator reaches for.
- **The three equal cards.** Three features, three identical boxes, three
  short sentences. Nothing is more important than anything else, so nothing
  is remembered.
- **The hollow words.** "Elevate," "Seamless," "Unleash," "Next-Gen." Words
  that promise everything and describe nothing. A user who reads them learns
  nothing about what the product does.
- **The fake specifics.** Made-up names, made-up numbers, made-up
  testimonials. "99.99 percent uptime" and a smiling stock face. Users can
  feel invented proof, and it reads as dishonesty, not polish.

### Why it costs trust

A user deciding whether to trust a product with their work, their data, or
their money is looking for evidence that a real person cared. Slop is
evidence of the opposite: that nobody looked, or nobody cared enough to
choose. The product may be excellent underneath. The surface says otherwise,
and the surface is what the user meets first. Deslop is therefore not a
vanity project. It is the cheapest trust repair a product can buy, because
it is mostly decisions, not budget.

---

## 2. The principle: grew from inspiration

The live projects were still basic and generic-looking despite bold work.
The fix is not more boldness. It is a better relationship with inspiration.

**The rule in one sentence:** study a pattern, extract the principle,
rebuild it in your own voice, add one improvement, never lift the original.

### The four steps

1. **Study.** Look at the source long enough to say what it is doing, not
   just what it looks like. A footer gallery is not "nice footers." It is
   "the footer is the most honest page, because it shows what the company
   actually values, so make it do real work."
2. **Extract.** Write the principle in one sentence, in your own words. If
   you cannot write the sentence, you have not understood the pattern yet,
   and copying it will produce a worse version.
3. **Rebuild.** Build the pattern from the principle, with your own tokens,
   your own type, your own spacing. Do not open the source while you build.
   If the result looks like the source, you copied. If it feels like the
   source but looks like you, you understood it.
4. **Improve.** Add one thing the source does not do. One is enough. It
   might be a better empty state, a clearer hierarchy, a motion detail that
   explains a state change, or a piece of real copy where the source had
   placeholder text. The improvement is what makes it yours, and it is the
   step most people skip.

### What this is not

- It is not "find a design you like and change the colors." Changing the
  colors on a copy is still a copy, and it will still read as generic,
  because the decisions are still someone else's.
- It is not "avoid all inspiration." A product built with no references is
  not original, it is uninformed. The goal is to be informed and still sound
  like yourself.
- It is not a style. It is a process. Two apps that go through this process
  will look different from each other, and that is the point. If every app
  that follows this doc looks the same, the doc has failed.

---

## 3. Per-app identity: one of each, written down

Two apps built from the same shell must never look like the same template.
The way to guarantee that is to give each app its own identity, recorded as
design tokens, before any screen is built.

**Each app gets exactly one of each:**

| Identity choice | What it is | Example (fictional) |
|---|---|---|
| One accent | The single color that means "this is us" | A deep clay red, used sparingly, never as a wash |
| One type pairing | Two fonts with a job each (display and body, or body and mono) | A grotesque for headlines, a readable sans for body, a mono for numbers |
| One spacing rhythm | How generous or dense the app feels | Airy, with large section gaps and one idea per screen |
| One motion feel | How the app moves | Slow and weighty, springs not slides, nothing bouncing |
| One voice line | The sentence the product would say about itself | "Built for the hour before class, not the week after it" |

Record these five choices in `docs/design/tokens/tokens.json` and in
`docs/design/02-design-tokens.md`, with the reasoning in one line each. The
tokens file is the source of truth. A screen that does not use the tokens is
not a design decision, it is drift, and drift is how templates creep back.

**The taste-skill sets the floor.** It bans the purple glow, bans Inter as a
default, bans centered heroes at high variance, and bans the three equal
cards. This doc does not repeat that ban list. Read the taste-skill as the
enforcement layer. This doc is the thinking that makes the enforcement
meaningful instead of mechanical.

**Known conflicts in this repo, to fix, not to copy:**

- `docs/design/02-design-tokens.md` still lists Inter as the default body
  font. The taste-skill bans Inter as a default. When you set up tokens for
  a new app, pick a real pairing and update the tokens doc. Do not copy the
  Inter default.
- `docs/design/04-consumer-pages.md` still templates a centered hero and a
  feature grid. The taste-skill bans both at high variance. Use the page
  template for its section order and its SEO fields, not for its layout.
  The deslop run in section 4 is the place to replace those layouts.

If a template and the taste-skill disagree, the taste-skill wins, and the
disagreement goes on the fix list. Do not silently follow the template.

---

## 4. The deslop run, step by step

This is the process proposed on Oct 27, 2026, written as a procedure an
owner and an agent can run together. It changes no live app by itself. Each
step ends with something the owner can see and approve.

### Step 1: Audit with real screenshots

Capture screenshots of the real product, on a real phone and a real desktop,
not mockups. For each screen, write one sentence about what feels generic.
Not a paragraph. One sentence. Examples: "The hero could belong to any
product." "These three cards say nothing the headline did not already say."
"The pricing page looks like the template it came from."

If you cannot write the sentence, the screen is probably fine, or you have
not looked long enough. Move on. The audit is a list of sentences, not a
report.

### Step 2: Three bold directions

From the audit, generate three directions. Bold means they disagree with
each other. If all three directions look like cousins, generate again. Each
direction is one page: the five identity choices from section 3, one
sentence on what it feels like, and one screen sketched in that direction.
No direction is "the safe one." Safe is what produced the slop.

### Step 3: The owner picks one

The owner picks one direction, in full. Not "a bit of one and a bit of
another." Mixing directions after the pick is how identity dissolves. The
pick is recorded with the date and the reason in one sentence. That sentence
is the anchor for every later argument about the design.

### Step 4: Lock the tokens

Translate the picked direction into tokens: accent, type pairing, spacing
rhythm, motion feel, voice line. Update `tokens.json`,
`02-design-tokens.md`, and `08-theming.md` together, so light mode, dark
mode, and the token reference agree. Verify contrast meets WCAG 2.1 AA
(4.5 to 1 for normal text, 3 to 1 for large text) before building anything
on the tokens.

### Step 5: One surface at a time

Rebuild one surface at a time, in this order: landing page, then the core
app screen, then onboarding, then settings and the rest. One surface per
pass, reviewed against the audit sentence for that surface. A pass that
rebuilds everything at once cannot be reviewed, and unreviewed work is how
slop returns.

### Step 6: Store screenshots last

App Store and Play Store screenshots are the last surface, not the first.
They must show the rebuilt product, not the old one with new copy. The
launch playbook already orders it this way. A screenshot set made early is
a promise the product does not keep yet.

### Step 7: Re-audit

Take fresh screenshots. Write one sentence per screen again. If the same
sentence comes back, the direction did not land, and the next pass starts
there. If new sentences appear, those are the next pass. Deslop is a loop,
not a launch event.

**Human gates:** the owner picks the direction, and the owner approves each
surface before it ships. An agent can run the audit, generate the three
directions, and rebuild a surface. An agent does not pick the direction and
does not ship a redesign to a live app without the owner's go.

---

## 5. License triage for inspiration

Inspiration is not free use. Every source has a license, and the license
decides what you may do with it. Check the license at use time, not at
bookmark time, because licenses change and because a bookmark is not
permission.

### The two buckets

| Bucket | What it means | What you may do |
|---|---|---|
| Commercial-use allowed | The license permits commercial use, with its conditions met (attribution, share-alike, or similar) | Use the source directly, following its conditions, and record the license note |
| Inspiration only | All other cases, including no license stated, a non-commercial license, or any doubt at all | Study the pattern, extract the principle, rebuild it yourself. Never lift screenshots, logos, copy, or UI verbatim |

**When in doubt, the source is inspiration only.** Doubt is not a reason to
use something and hope. It is the answer.

### Inspiration sources named in this project

The following were named as inspiration sources in the Oct 27, 2026 design
discussion. Treat **all of them as inspiration only** unless you have
checked the license yourself, at use time, and recorded the result:

- landdding.com
- godly.website
- recent.design
- footer.design
- mobbin.com
- 60fps.design
- on.design
- posts.design

None of these is presented here as commercial-use allowed. Do not present
any of them that way in your own docs either. A source's name in a list is
not a license grant.

### The pattern library entry

When a pattern earns a place in your library, record it in this form, with
the license note filled in every time:

```markdown
Pattern: [What it is, in your words]
Principle: [The one-sentence principle, in your words]
Source: [Where you saw it]
License at time of use: [Commercial-use allowed, with conditions / Inspiration only]
What we changed: [The one improvement, in your words]
Used in: [Which app and surface, or "not used yet"]
```

A pattern without a license note is not in the library. It is a bookmark,
and bookmarks do not ship.

### What "never lift" covers

Screenshots, logos, copy, and UI, verbatim or with only the colors changed.
It also covers close paraphrases of copy: changing three words in someone
else's headline is still their headline. Write your own sentence from the
principle, or do not write the sentence.

---

## 6. How this connects to the taste-skill and the design docs

| Layer | File | Job |
|---|---|---|
| Thinking | This doc (`DESIGN_DESLOP.md`) | Why a choice is good, how to arrive at it, how to run the process |
| Enforcement | `skills/taste-skill/SKILL.md` | The ban list and the metric dials (variance, motion, density) that an agent must follow |
| Templates | `docs/design/` | Token definitions, page templates, theming, visual inventory |
| Identity record | `docs/design/tokens/tokens.json` | The machine-readable tokens for one app |

Do not duplicate the ban list here. If the taste-skill changes, this doc
should still be true, because it does not restate the bans, it points to
them. Do not duplicate the token values here either. Tokens live in the
tokens file. This doc says how to choose them.

**The dials, in one paragraph:** the taste-skill sets a baseline of design
variance 8, motion intensity 6, and visual density 4, and the owner can
override them per app. Those numbers are the enforcement of "bold, but not
chaos." A deslop direction that needs variance 2 to work is not bold, it is
a retreat to the template. A direction that needs variance 10 everywhere is
not a direction, it is noise. The direction brief in section 8 should record
the dial settings the direction needs, so the build can be checked against
them.

---

## 7. Worked before and after (fictional landing page)

Same fictional app as the PLG framework: **Second Mat**, a class planner
for yoga teachers. Fictional, not a real product, not CueCraft. Same facts
in both versions. Only the choices change.

### Before: the generic version

- Centered hero, dark image, headline: "Elevate Your Teaching Journey."
  Subheadline: "Seamless class planning for next-gen yoga teachers."
  One button in the middle.
- Three equal cards: "Plan," "Teach," "Grow." Each with one vague sentence.
- A purple-blue gradient wash behind the hero, Inter throughout.
- Social proof: three made-up quotes from made-up teachers with stock
  faces, and "99.99 percent of teachers love Second Mat."
- Pricing section that says "Simple, transparent pricing" and shows three
  equal plan cards.

What a visitor learns: nothing. What the product does, who it is for, and
why it is different are all missing, replaced by words that could describe
any product.

### After: the deslop version

- Split hero, left aligned. Headline in the teacher's words: "Walk into
  class knowing the sequence, not holding it." Subheadline names the job:
  "Build a class in ten minutes, teach it from one screen, keep the notes
  from last time." The hero image is a real class sequence, mid-use, not a
  stock photo of a studio.
- One accent, a deep clay red, used only for the primary action and for the
  "now teaching" state. Neutral zinc everywhere else. No gradient wash.
- Type pairing with a job each: a grotesque for the headline, a readable
  sans for the body, mono for times and counts ("42 minutes, 18 poses").
- Instead of three equal cards, an asymmetric layout: a large panel showing
  a real sequence being taught, with a narrow column beside it listing the
  three things the teacher does not have to do anymore (retype poses, hunt
  for last week's notes, print a sheet). The hierarchy says what matters.
- Proof is real or absent. One real teacher, named, with a real quote about
  one real class. No made-up numbers. If there is no real quote yet, the
  section is omitted, not invented.
- Motion with a job: the sequence panel advances one pose at a time when
  the visitor scrolls, showing the teaching flow instead of describing it.
  Nothing moves for decoration.
- Pricing names the limit plainly: "Free for 3 taught classes a month.
  Unlimited for the price of one studio drop-in." The limit is the free
  tier's gate, and the comparison is concrete, not a slogan.

Same facts. Different choices. The second version could only belong to this
product, because every choice came from the teacher's job, not from a
template.

---

## 8. For experts

- **Variance, motion, density** are dials, not decorations. Set them per
  app in the direction brief, and check the build against them. A landing
  page at variance 8 with a dashboard at variance 8 is a consistent product.
  A landing page at variance 8 with a dashboard at variance 2 is two
  products sharing a logo.
- **Accessibility is a floor, not a direction.** WCAG 2.1 AA contrast,
  visible focus, keyboard access, and respect for `prefers-reduced-motion`
  apply to every direction, including the boldest one. A direction that can
  only work by breaking contrast is not bold, it is unusable. The full
  checklist is in `docs/design/README.md`.
- **Performance is part of the look.** A heavy gradient, a large unoptimized
  hero image, and three animation libraries will make the boldest design
  feel slow, and slow reads as cheap. Animate `transform` and `opacity`
  only, keep perpetual motion isolated in its own component, and test on a
  mid-tier phone, not only on a desktop. The taste-skill's performance
  guardrails are the enforcement for this.
- **Dark mode is a second design, not an inversion.** The theming doc
  (`docs/design/08-theming.md`) shows the structure: lighter primary, muted
  borders, no pure black. A direction brief should name one dark-mode
  decision, not just "dark mode supported."
- **The audit sentence is a skill.** "This feels generic" is not an audit
  sentence. "This hero could belong to any product" is. Train the sentence
  by writing it for products you admire, too: what, exactly, makes them
  unmistakable? That is the standard your own screens are measured against.

---

## 9. For agents

Read this section before doing any design work in this repo.

- **This doc changes no live app.** It is a process and a standard. A
  redesign of a live app needs the owner's direction pick and a per-surface
  go. Never present a deslop pass as shipped design.
- **Run deslop as a review pass, one surface at a time.** Audit, propose
  three directions, wait for the pick, lock tokens, rebuild one surface.
  A single change that rebuilds every screen at once has failed this
  process, however good it looks.
- **Follow the taste-skill as enforcement.** Its bans are mandatory unless
  the owner explicitly overrides them for a specific surface. Do not
  re-argue a ban in a build. If a ban conflicts with a template in
  `docs/design/`, follow the ban and flag the template conflict.
- **Never use Lovable.** This is a standing rule for this project. Do not
  propose it, do not use it, do not route design work through it.
- **Never position CueCraft as AI.** CueCraft is hand-built, rule-based
  sequencing, not an AI generator. That positioning rule applies to copy,
  to store listings, and to design work on CueCraft surfaces. Do not write
  AI-positioning copy for it in any direction.
- **Never lift an inspiration source.** Study it, extract the principle,
  rebuild it, add one improvement. If you cannot name the principle in one
  sentence, do not build from that source yet. Record the license note for
  every pattern you use, using the entry form in section 5.
- **Never invent proof.** No made-up names, numbers, quotes, or
  testimonials in any mock, screenshot, or landing page. Use real content,
  clearly labeled placeholder content the owner will replace, or omit the
  section. The taste-skill bans fake numbers and generic names for the same
  reason.
- **Tokens are the source of truth.** Change the tokens file and the token
  docs together. A screen that hardcodes a color or a font instead of using
  a token is a regression, even if it looks right today.
- **Do not duplicate the taste-skill.** When you write design guidance in
  this repo, link to it. A second copy of the ban list will drift, and a
  drifted ban list is worse than no list.

---

## Direction brief (fill in)

```markdown
App: [YOUR_APP_NAME]
Audit sentences (one per screen):
- [Screen]: [What feels generic, in one sentence]
- [Screen]: [What feels generic, in one sentence]
- [Screen]: [What feels generic, in one sentence]

Direction A: [Name]
- Accent: [One color]
- Type pairing: [Display / Body]
- Spacing rhythm: [Airy / Dense / One idea per screen]
- Motion feel: [Slow and weighty / Quick and light]
- Voice line: [One sentence]
- Dials: variance [ ] / motion [ ] / density [ ]

Direction B: [Name]
- (same five choices)

Direction C: [Name]
- (same five choices)

Owner pick: [A / B / C]
Pick date: [DATE]
Reason (one sentence): [Why this one]
Tokens locked: [Yes / No, date]
Surfaces rebuilt, in order: [Landing / Core screen / Onboarding / ...]
Store screenshots redone: [Yes / No, date]
Re-audit date: [DATE]
```

---

## Checklist

- [ ] Audit screenshots captured from the real product, one sentence per screen
- [ ] Three bold directions written, each with the five identity choices
- [ ] Owner picked one direction, with date and reason recorded
- [ ] Tokens locked in `tokens.json`, `02-design-tokens.md`, and `08-theming.md`, contrast verified
- [ ] Surfaces rebuilt one at a time, landing first, store screenshots last
- [ ] Every inspiration source recorded with a license note, all inspiration only unless verified otherwise
- [ ] No screenshots, logos, copy, or UI lifted verbatim from any source
- [ ] No made-up names, numbers, quotes, or testimonials in any surface
- [ ] Re-audit done with fresh screenshots, new sentences recorded
- [ ] Taste-skill followed as enforcement, conflicts with templates flagged
- [ ] No live app changed without the owner's per-surface go
