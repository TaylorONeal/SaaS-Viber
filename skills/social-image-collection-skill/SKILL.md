---
name: social-image-collection
description: Build a labeled test set of real-world images (schedules, menus, price lists, flyers, receipts) by browsing Instagram as a signed-in human would, saving each find to a private collection, capturing it to disk and logging its source. Load when an app's image or OCR feature needs varied real examples, or someone asks to "collect examples from Instagram" for testing.
---

# Social Image Collection Skill

Real users photograph and post things you never designed for. A scanner, parser
or OCR feature tested only on clean samples fails on day one. This skill turns
public social posts into a test set with provenance, without behaving like a
scraper.

It produces one paste-ready prompt for a browser agent (Cowork, Claude in
Chrome, or similar) running in the user's own signed-in browser. You write the
prompt; the user's agent runs it.

## When to Use

- An image feature (photo scan, OCR, layout parser) needs varied real inputs.
- You have a list of accounts (a directory, a CRM export, the accounts a brand
  follows) and want examples from them.
- You need to search a topic ("weekly yoga schedule", "food truck menu") and
  keep only posts that match a clear definition.

Not for: bulk scraping, collecting personal data about people, reposting
content, or anything that needs an API the platform hasn't granted you.

## Inputs to Gather First

1. **Target definition.** One paragraph a stranger could apply: what counts,
   what doesn't, how recent. Write the exclusions too (one-off event flyers are
   not schedules).
2. **Account list.** Handles with city or segment. Dedupe and strip URLs to bare
   handles. Put it inline in the prompt; the browser agent usually can't read
   your repo or server files.
3. **Search terms.** Plain phrases, hashtags, and a few other-language variants
   for layout variety.
4. **Signed-in account.** Which account saves the finds. Collections are
   private to that account.
5. **Output folder** on the user's machine.

## Prompt Structure (in this order)

1. **Setup:** which browser, one tab, which account must be signed in, and a
   hard stop on any password, 2FA, captcha or "confirm it's you" screen.
2. **Checkpoint file** (JSON): current part, finished handles and terms, every
   logged post URL, the run's save count. Resume from it on every start.
3. **Log file** (CSV): handle, post_url, post_date, format, slides, city,
   source, saved_to_collection, files, notes. `source` records which part
   found it (following, directory, search:<term>) so you can weigh sources later.
4. **Definition** of a match, plus per-account caps (for example 3 posts) and a
   rule to skip repeats of the same template.
5. **Per-match steps:** save to the named collection (create once if missing),
   capture a screenshot per relevant slide with a predictable filename
   (`<handle>-<YYYY-MM-DD>-<n>.png`), keep the full-resolution file too when
   available, append the log row. Verify the first file opens before going on.
6. **Parts:** accounts the brand follows, then the directory list, then search.
   Say how deep to look per account (highlights first, then about 24 grid posts).
7. **Pace and limits** (below), stated as rules, not suggestions.
8. **Report:** why the run ended, counts per part, missing or private handles,
   the most unusual examples by URL. Close the tab.

## Pace and Limits (non-negotiable)

- Human pace: 3 to 8 seconds between actions, varied; longer between accounts.
- A per-run cap on saves (about 150). Stop at the cap and resume next run.
- Stop at once on any rate-limit or "unusual activity" message, quote it, and
  don't retry. An action block on the user's account costs far more than a
  slower collection.
- Read-only except the one save action. Never like, comment, follow, unfollow,
  message, or change settings.

## Privacy and Use

- Capture business posts, not people. Skip posts whose main subject is a
  person's face or private life.
- Keep the set internal for testing. Don't republish images or commit them to a
  public repo; store them in a private bucket or local folder, and keep the
  post URL so any image can be removed on request.
- Don't record names, phone numbers or emails from posts in the log. The handle
  and URL are enough provenance.
- Respect the platform's terms; this method is for low-volume manual-pace
  collection by the account owner, not automation at scale.

## After the Run

- Spot-check 10 rows: does each file match its URL, and does it meet the
  definition?
- Tag each image with what makes it hard (handwriting, low light, multiple
  weeks, non-English, dense grid). Those tags become your test buckets.
- Feed the set into the feature's eval harness and track pass rate per bucket.
