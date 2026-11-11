# Storefront Copy

> How to write the words a customer, a store reviewer, and your own team each read, without mixing the three up.
>
> Added Nov 8, 2026.
>
> Companion docs: `docs/app-store/SUBMISSION_GUIDE.md` (character limits and screenshot sizes), `docs/guides/IOS_READINESS_CHECKLIST.md` (iOS listing fields and keywords), `docs/guides/ANDROID_READINESS_CHECKLIST.md` (Android listing fields and feature graphic), `docs/guides/BRANDING_GUIDE.md` (logo, icon, and visual consistency), `docs/architecture/APP_STORE_COMPLIANCE.md` (what both stores require), `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 7, store listing and review notes), `docs/templates/SUBMIT_DAY_PACKET_TEMPLATE.md` (the packet that carries review notes on submit day).

## In one minute

Your app has three kinds of copy, and they go to three different readers. Customer-facing copy is what a person deciding whether to download reads. Store-facing copy is what Apple and Google reviewers and the store systems read. Internal copy is what your team reads. Write each one for its reader, keep them in separate files, and never paste internal notes into a store console. If you mix them up, customers see jargon, reviewers see marketing fluff where they needed facts, and your team loses the record of what actually changed.

## The three voices

### Voice A: customer-facing

Reader: a person deciding whether to download, in about ten seconds, on a phone.

What it covers: app name, iOS subtitle, Android short description, full description, screenshots and their captions, app preview video, What's New.

Rules:

- Write benefits, not features. A feature is what the app does. A benefit is what changes in the reader's life. "Plan a full class in minutes" is a benefit. "Sequence engine with 400 poses" is a feature. Lead with the benefit, then name the feature that delivers it.
- One promise per sentence. If a sentence makes two promises, split it.
- Plain words first. If a first-time user would need a glossary, rewrite it.
- The first three lines of the full description matter most. On iOS only the first three lines show before the reader taps "more". Put the core promise there, not the company history.
- No claims you cannot prove on the current build. If a screenshot shows a feature, that feature must exist in the build you submit. Reviewers reject listings where screenshots and description promise more than the app does. See `docs/architecture/APP_STORE_COMPLIANCE.md`.
- No mention of the other platform. Apple rejects listings that say "also available on Android", and the reverse reads as careless on Google Play.
- No prices in the description that can go stale. Prices live in the store's product config and on your pricing page. If you must mention price, point to the plan name, not a number you will forget to update.

### Voice B: store-facing

Reader: an Apple or Google reviewer, plus the store search and compliance systems.

What it covers: iOS keywords, category, privacy nutrition labels and Data Safety answers, review notes, demo account instructions, in-app purchase review screenshots, age and content rating answers.

Rules:

- Keywords are for search, not for humans. iOS gives you 100 characters, comma separated, no spaces after commas, no repeats of words already in the app name or subtitle, singular forms (Apple handles plurals). Example shape: `yoga,class,planner,sequence,teacher,studio`. Do not stuff competitor names. Do not repeat a word to game the count; it wastes characters.
- Category is a discovery decision, not a label. Pick the category where your buyer actually browses. Changing it later is allowed but it resets your ranking in that category, so choose deliberately the first time.
- Privacy labels and Data Safety answers must match what the code actually collects. If the code collects an email and the label says it does not, that is a rejection and a trust problem. Derive the answers from the real data flow, not from what you wish the app collected. See `docs/guides/IOS_READINESS_CHECKLIST.md` section 8 and `docs/guides/ANDROID_READINESS_CHECKLIST.md` section 10.
- Review notes are written from an empty account. The reviewer starts with nothing saved, no classes, no history. If your notes say "open your saved class", the reviewer is stuck. Start every note at the create flow, then the core action, then where purchase, restore, and delete account live. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` Phase 7 and `docs/templates/SUBMIT_DAY_PACKET_TEMPLATE.md` section 4.
- Review notes include a demo account, entered in the console's reviewer credentials field, never pasted into a doc. The password lives in a password manager.
- In-app purchase review screenshots must be at an exact accepted size (for example 1290 by 2796 for iPhone 6.7 inch). A larger image that is "at least big enough" is rejected. One paywall image showing all tiers can serve every product. Capture these in the same device session as the sandbox purchase test.
- Be polite and factual in review notes. Reviewers are human. "The subscription group is attached; the paywall is on the Plan tab" works better than a paragraph of marketing.

### Voice C: internal

Reader: your team, your future self, and any agent working on the next release.

What it covers: changelog, release notes for the team, version notes, what changed and why, what was deliberately left out, known issues.

Rules:

- Say what changed, why, and what was left out. "Fixed crash on class save (race between autosave and publish)" is useful. "Various improvements" is not.
- Never write internal copy in a way that could be pasted into the store. If a changelog line contains a ticket number, a customer name, a revenue figure, or a blame statement, it stays internal by design.
- Date every entry and tie it to a version number and a tag. See `docs/architecture/VERSION_MANAGEMENT.md`.
- The internal changelog is the source of truth that the customer-facing What's New is condensed from, not the other way round. Condense, do not copy.

## The character limits table

All limits below come from `docs/app-store/SUBMISSION_GUIDE.md` and the two readiness checklists. Verify them in the console before you submit; the stores change limits occasionally.

| Field | iOS | Android |
|---|---|---|
| App name | 30 characters max | 30 characters max |
| Subtitle / short description | Subtitle, 30 characters max | Short description, 80 characters max |
| Full description | 4,000 characters max | 4,000 characters max |
| Keywords | 100 characters, comma separated, no spaces | No keywords field; search uses title, short and full description |
| What's New / release notes | 4,000 characters max | Release notes per release, keep short |
| Promotional text (iOS only) | 170 characters, updatable without a new binary | Not applicable |
| App icon | 1024 by 1024 PNG, no alpha channel | 512 by 512 PNG, 32 bit with alpha |
| Feature graphic | Not applicable | 1024 by 500, required |
| Screenshots | Minimum 3, maximum 10 per device size; iPhone 6.7 inch is 1290 by 2796 | Minimum 2, maximum 8 per device type; 16:9 or 9:16 |

How to count: count characters, not words. A 30 character subtitle is short. Draft in a character counter, not in your head. Test the subtitle and short description on a real phone, because truncation in search results hides the end of a line that looked fine in a document.

## App icon and branding

One icon, everywhere. The same mark appears on the store listing, the home screen, the website favicon, social profiles, and inside the app. If a user cannot recognise the store icon on their home screen, the brand has failed. See `docs/guides/BRANDING_GUIDE.md` for the full token and logo rules.

- Legible at small size. The icon must read at 29 by 29 points in a settings list, not just at 1024 by 1024. Test it at the smallest size before you ship it.
- No text baked into the icon. Text becomes unreadable when small, and it duplicates the app name the store already shows next to the icon. A simple shape or mark only.
- No transparency on iOS (the 1024 by 1024 PNG must have no alpha channel). Android uses a 512 by 512 PNG with alpha and adaptive icon rules.
- No badges, ribbons, or "new" overlays. The stores reject them and they date fast.
- Keep the icon, the brand colours, and the fonts consistent across the store, the web landing page, and the app itself. The branding guide is the single source of truth; do not invent a second palette for the store listing.

## Screenshots that tell a story

Screenshots are the listing. Most download decisions are made from the first two screenshots plus the icon and the subtitle, before the description is ever read.

- Order tells a story. Screenshot 1 is the promise: the core outcome, in the app, with a short caption. Screenshot 2 is the proof: the core action being done. Screenshots 3 onward are the supporting features, in the order a new user meets them.
- Show real app content, not placeholder data and not marketing graphics alone. Captions may overlay short text, but the screen underneath must be the real app.
- Capture from the release candidate, on the exact device sizes the console asks for. A screenshot from an older build that shows a screen you have since changed is a mismatch the reviewer can reject.
- First two screenshots carry the promise. If a reader only ever sees two, they should still know what the app does and for whom.
- Localise screenshots for each language you support. A German user who sees English screenshots assumes the app is English only.
- No fake status bar content. Do not show a fake carrier name, a fake time, or a fake battery state that could confuse a reviewer.
- App preview video, if you make one, is 15 to 30 seconds, shows the real app in use, and has captions or no spoken words at all so it works muted.

## How to write What's New

What's New is customer-facing (Voice A). It is the one piece of store copy that changes every release, so it is where teams most often slip into internal voice.

- User benefit first. "Your saved classes now sync in seconds, even on slow connections" beats "Improved sync performance".
- Never ship "bug fixes and improvements" as the whole note. It tells the reader nothing and it tells Apple nothing. If the release really is only fixes, name the one fix a user would notice: "Fixed: classes no longer disappear after you edit them offline."
- Versioned and dated. Every What's New entry belongs to one version number, and the internal changelog carries the matching date and tag.
- One to three items. A release with twelve bullet points reads as unfocused. Pick the changes a user would care about; the rest stays in the internal changelog.
- No internal jargon. No ticket numbers, no library names, no "refactored the entitlement layer". If a change only matters to engineers, it does not belong in What's New.
- Match the screenshots. If What's New announces a redesigned planner, the screenshots should show the redesigned planner.

## Keeping the three copies in sync

The three voices drift apart naturally. The description promises a feature, the changelog says it was cut, the review notes describe a flow that no longer exists. Prevent that with a small routine, run before every submission:

1. Read the customer-facing description and the first two screenshots against the release candidate build. Does every claim exist in the build?
2. Read the review notes from an empty account. Can a stranger follow them?
3. Read the internal changelog. Does it explain every customer-facing claim in What's New?
4. Update the privacy labels and Data Safety answers if the release changed what data is collected. This is the step most often forgotten.
5. Record the version, the date, and the tag in the tracker. See `docs/templates/LAUNCH_TRACKER_TEMPLATE.md`.

Keep the three copies in three separate files. A single file that mixes audiences invites copy and paste errors, and a paste error is how an internal note ends up in App Store Connect.

## Worked example: a fictional yoga class app

This example is fictional. It is not a real app in this repo. It shows the same release, version 1.4.0, written three ways. The release adds a printable class plan and fixes an offline editing bug.

### Voice A: customer-facing (What's New, version 1.4.0)

"Print your class plan. From any class, tap Print to get a clean one page plan you can take into the studio. Fixed: edits you make offline no longer disappear when you reconnect."

Note what this does: two benefits, plain words, no jargon, no ticket numbers.

### Voice A: customer-facing (full description opening, same app)

"Plan a yoga class in minutes, then teach it with confidence. FlowPlan helps yoga teachers build balanced sequences, save them, and print a clean plan to take into the studio. Start from a template or build from scratch, and your plan stays with you offline."

Note what this does: one promise per sentence, benefit first, the first three lines carry the whole pitch.

### Voice B: store-facing (review notes, same release)

"Reviewer login: see Reviewer Information (credentials entered separately). The account is empty. Start on the Home tab and tap New Class to create a class. The Plan tab holds the class sequence. Printing is on the class detail screen, top right, labelled Print. Purchase, restore, and delete account are on the Account tab. The printable plan is new in 1.4.0; the offline editing fix is covered in the internal changelog."

Note what this does: starts from an empty account, names exact tabs and labels, says what is new, points to the changelog instead of repeating it.

### Voice B: store-facing (iOS keywords, same app)

`yoga,class,planner,sequence,teacher,studio,print,lesson,flow`

That is 9 words, under 100 characters, comma separated with no spaces, no repeats of the app name or subtitle words.

### Voice C: internal (changelog, version 1.4.0)

"1.4.0, 2026-11-08, tag v1.4.0. Added: printable class plan (PDF export from class detail, one page, studio friendly layout). Fixed: offline edits lost on reconnect (race between autosave and publish; autosave now wins and publish retries once). Left out: shared class links, moved to 1.5.0 because the review flow is not finished. Known issue: printing on iPad in landscape crops the footer on first print; workaround is portrait."

Note what this does: what changed, why, what was left out and why, and a known issue with a workaround. None of this goes to customers verbatim.

## Agent rules

These rules are for any agent, human or automated, that writes storefront copy in this repo.

1. Say which audience you are writing for, in the first line of your reply or in the file header. "This is customer-facing copy" or "This is internal changelog text". Never deliver copy without naming its audience.
2. Never paste internal notes into App Store Connect or Google Play Console. If you are asked to fill a store field, write fresh customer-facing or store-facing copy for that field.
3. Never invent a feature, a price, a rating, a testimonial, or a screenshot. If the build does not have it, do not write it.
4. Count characters before you deliver a name, subtitle, short description, or keywords field. State the count.
5. When you write a changelog, include the version, the date, what changed, why, and what was left out.
6. When you write review notes, write them from an empty account. If you cannot verify a flow from an empty account, say so and put it on the human list.
7. When a release changes data collection, flag the privacy labels and Data Safety form for a human to update. Do not silently keep old answers.
8. Keep the three voices in three separate files. If a file mixes them, split it before you submit anything.

## Fill-in checklist

- [ ] App name chosen, 30 characters or fewer on both stores. Character count: [__]
- [ ] iOS subtitle written, 30 characters or fewer. Text: [__] Count: [__]
- [ ] Android short description written, 80 characters or fewer. Text: [__] Count: [__]
- [ ] Full description written, first three lines carry the core promise. Draft location: [__]
- [ ] iOS keywords written, 100 characters or fewer, comma separated, no spaces, no repeats of name or subtitle. Text: [__] Count: [__]
- [ ] Category chosen and reason recorded: [__]
- [ ] App icon finalised, legible at small size, no text baked in, iOS 1024 by 1024 with no alpha, Android 512 by 512 with alpha
- [ ] Screenshots captured from the release candidate, in story order, first two carry the promise
- [ ] What's New written for this version, benefit first, no "bug fixes and improvements" as the whole note
- [ ] Review notes written from an empty account, demo account in the password manager, never in a doc
- [ ] In-app purchase review screenshots at an exact accepted size, captured in the purchase test session
- [ ] Privacy labels and Data Safety answers checked against what the code actually collects this release
- [ ] Internal changelog written: version, date, what changed, why, what was left out
- [ ] The three voices live in three separate files, and nothing internal was pasted into a store console
