# Studio Publisher Page

> How to publish several apps under one studio name, with one shared company site that carries the legal pages once.
>
> Added Nov 8, 2026.
>
> Companion docs: `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 0.5, publisher model; Phase 1, day-one paperwork), `docs/guides/IOS_READINESS_CHECKLIST.md` (organisation enrolment and D-U-N-S), `docs/guides/ANDROID_READINESS_CHECKLIST.md` (organisation Play Console account), `docs/architecture/APP_STORE_COMPLIANCE.md` (privacy policy locations), `docs/guides/DIGITAL_PRESENCE_CHECKLIST.md` (domain, social, and brand consistency), `docs/design/04-consumer-pages.md` (landing, about, and contact page structure), `docs/templates/LAUNCH_TRACKER_TEMPLATE.md` (portfolio tracker, one row per app).

## In one minute

A studio publisher page is one company website that lists every app you make, links to each store listing, and carries the shared legal pages once, so each app links back to it. It makes sense when you have two or more apps, or one app plus a clear second one coming. One organisation developer account can publish many apps under one seller name, and the studio site is the public website Apple asks for when you enrol as an organisation. Each app still needs its own landing page; the studio page does not replace it. It sits above the apps, not instead of them.

## When a studio page makes sense

Build a studio page when any of these is true:

- You have two or more apps live, or in active development.
- You have one app live and a second one clearly coming, with a name and a rough date.
- You want one seller name on the stores that is not your personal name, for example because you plan to add apps over time and do not want each one to look like a separate one-person project.
- You want one support email and one set of legal pages shared across apps, instead of setting up separate ones per app.

Do not build a studio page yet when:

- You have one app and no second one planned. A single app landing page is enough, and a studio page with one app on it looks empty. Add the studio page when the second app is real.
- You are still deciding the company name or the legal entity. The studio page carries the legal name, so settle that first. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` Phase 1.

## What the page is

The studio page is a small company site. It is not a product page and it is not a blog. Its job is to answer three questions in under a minute: who makes these apps, what are the apps, and where do I get help or read the legal pages.

It does four things:

1. Lists every app, with a link to each store listing.
2. Carries the shared legal pages once (privacy policy, terms, data deletion), so each app links back to the same URLs.
3. Gives one shared support email that is monitored daily.
4. Acts as the public website Apple requires for organisation enrolment, and as the marketing URL Google Play asks for.

Naming example only: for example, a studio called Purafield Studio would list its apps here. That sentence is an example of the pattern, not a statement about a real studio. Do not treat it as a fact about any real company, its apps, or its site. Fill in your own studio name, your own apps, and your own links.

## How it relates to the developer accounts

The studio site and the developer accounts are separate things that point at each other.

- One organisation account can publish many apps under one seller name. On iOS, the seller name shown on the store is the legal entity name from your organisation enrolment. On Android, the developer name shown on Play is set in Play Console. Keep the seller name and the studio name the same where the store allows it, so a user who finds one app can find the others.
- Apple organisation enrolment requires a legal entity, a D-U-N-S number, and a public website. The studio site is that public website. Enrolment can take days to weeks, so start it early. See `docs/guides/IOS_READINESS_CHECKLIST.md` section 1 and `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` Phase 1.
- Google Play organisation accounts need identity verification and a public website too. See `docs/guides/ANDROID_READINESS_CHECKLIST.md` section 1.
- The studio site is not a substitute for the developer account paperwork. The site is public; the account is legal. Both must exist.
- If you publish as an individual today and move to an organisation later, the seller name changes and existing users see a new seller. That is allowed but it is a visible change, so decide the publisher model before the first submission if you can. The launch playbook calls this out in Phase 0.5: one legal publisher entity can own many apps, set it up once, reuse it for the whole portfolio.

## Page structure

Keep the page short. A studio page that tries to be a product site for every app at once becomes unreadable. Each section below is one screen or less.

### 1. Studio name and one-line promise

The studio name, large, with one sentence saying what kind of apps the studio makes. Not a mission statement and not a paragraph. Example shape: "[Studio name] makes [what kind of apps] for [who]." Fill in your own words.

### 2. App cards

One card per app, in a grid. Each card has:

- The app icon, the same icon as the store listing.
- The app name, spelled exactly as it appears on the store.
- One line of benefit, not a feature list. One sentence, customer-facing voice. See the companion storefront copy guide for the three voices.
- Store badges, linking to the live listing on the App Store and Google Play. Before an app is live, the card says "Coming soon" with a link to that app's waitlist instead of a store badge. Do not show a store badge for an app that is not on that store.
- A link to that app's own landing page.

Order the cards by priority, not alphabetically. The flagship app goes first.

### 3. Shared support email

One email address, shown plainly, that is monitored daily. State the response time you actually keep, for example "We reply within two business days." Do not publish an email nobody reads. If each app has its own support email, list the studio email here and link to each app's support page from its card.

### 4. Shared legal links

Links to the shared pages, in the footer and on a legal page:

- Privacy policy
- Terms of service
- Data deletion
- Support and contact

Each app's store listing links to these same URLs. The URLs must be live, on your own domain, and accessible without logging in. A privacy policy hosted on a Google Doc does not meet the store requirement. See `docs/architecture/APP_STORE_COMPLIANCE.md` and the legal pages template.

### 5. About and contact

Two short sections, or one combined section:

- About: two or three sentences. Who runs the studio, where it is based if you want to say so, and what it makes. No founding myth, no jargon.
- Contact: the support email again, plus links to the studio's social profiles if they exist. Do not list social profiles that are empty or abandoned.

### 6. Footer

The footer repeats the legal links, the support email, and the copyright line with the legal entity name and the year. The footer is the same on every page of the studio site.

## Per-app versus studio decisions

Some things are shared at studio level, some stay per app. Getting this split wrong is the most common studio page mistake: either every app repeats the same legal text with small differences that drift, or one shared page tries to describe apps that collect different data.

| Decision | Studio level (shared) | Per-app level (separate) |
|---|---|---|
| Seller name on the stores | One organisation account, one seller name | Nothing per app |
| Studio site | One site, lists all apps | Each app has its own landing page too |
| Privacy policy URL | Can be shared if every app collects the same data for the same purposes | Per-app policy if an app collects different data, or if its data handling differs in a way a user would care about |
| Terms of service | Can be shared if the terms are the same for every app | Per-app terms if pricing, refunds, or acceptable use differ |
| Support email | Can be shared, one monitored inbox | Per-app support page if the app needs its own help content |
| Data deletion page | Can be shared if the deletion path is the same | Per-app instructions if the in-app deletion path differs |
| App icon, name, description, screenshots | Never shared | Always per app |
| Store listing, keywords, category | Never shared | Always per app |
| Social profiles | Studio profiles are shared | Per-app profiles only if the app has its own audience and someone actually posts there |

Rule of thumb: share the legal pages when the facts are the same. The moment the facts differ, split the page. A shared privacy policy that is wrong for one app is worse than two policies, because it is wrong in a place the stores check.

## The studio page and the app landing pages

The studio page and the per-app landing pages have different jobs. Do not merge them.

- The studio page answers "who makes this and what else do they make". Its reader is someone who found one app and wants to trust the maker, or a store reviewer checking that the organisation is real.
- The app landing page answers "what does this app do and should I download it". Its reader is a potential user. It carries the promise, the screenshot or video, the pricing, the FAQ, and the waitlist or store badges. See the landing, waitlist, and feedback guide for the full structure.

Link both ways: every app card on the studio page links to that app's landing page, and every app landing page links back to the studio page in its footer, usually as "Made by [Studio name]".

## A naming example, handled carefully

The pattern is easier to picture with a name in it, so here is one, labelled as an example.

For example, a studio called Purafield Studio would list its apps here: each app would get a card with its icon, one line of benefit, and store badges linking to its listings, and the shared privacy policy and terms would live on the studio site so every app links back to the same pages.

That is the whole example. Nothing in this doc states what apps Purafield Studio makes, what its site address is, or what its legal pages say, because this doc does not know those facts. If you use this pattern for a real studio, replace the example name with your real studio name and fill in your real apps and links. Do not present the example as a fact about a real company.

## Fill-in template outline

Copy this outline and fill it in. Brackets mean you supply the value.

```text
Studio site: [domain, for example studio.example.com]
Legal entity name: [exact legal name on the developer accounts]
Studio display name: [name shown on the site and the stores, if the same]

Header
  Studio name: [name]
  One-line promise: [one sentence: what kind of apps, for who]

Apps (one block per app, flagship first)
  App 1
    Name (exactly as on the store): [name]
    Icon file: [path]
    One-line benefit: [one sentence]
    Landing page: [URL on your domain]
    App Store listing: [URL, or "not live yet, waitlist link instead"]
    Google Play listing: [URL, or "not live yet, waitlist link instead"]
    Status: [live / in TestFlight or closed testing / coming soon]
  App 2
    [same block]

Support
  Shared support email: [email]
  Response time promise: [for example, within two business days]
  Status page: [URL, or "none yet"]

Legal (all on your own domain, all live, no login required)
  Privacy policy: [URL]
  Terms of service: [URL]
  Data deletion: [URL]
  Shared or per-app: [shared, or list which apps have their own]

About
  Two or three sentences: [who runs the studio, what it makes]

Contact
  Support email: [email, repeated]
  Social profiles: [list only profiles that are active]

Footer
  Legal links: [privacy, terms, data deletion]
  Copyright: [legal entity name, year]
```

## Fill-in checklist

- [ ] Studio name decided, and legal entity name recorded exactly as it appears on the developer accounts
- [ ] Organisation developer accounts set up (Apple and Google), or a dated plan to do so, with the waits started early
- [ ] Studio site live on your own domain, with a public URL Apple and Google can check
- [ ] App cards written, flagship first, each with the store icon, the exact store name, one line of benefit, and live store badges or a waitlist link
- [ ] Each app has its own landing page, linked from its card, and each landing page links back to the studio page
- [ ] Shared support email published and monitored daily, with an honest response time promise
- [ ] Shared legal pages live on your own domain: privacy policy, terms, data deletion, all accessible without login
- [ ] Per-app versus shared split decided and recorded: which legal pages are shared, which apps have their own, and why
- [ ] About and contact sections written, two or three sentences, no empty social profiles listed
- [ ] Footer repeats the legal links, the support email, and the copyright line with the legal entity name
- [ ] Portfolio tracker updated with one row per app. See `docs/templates/LAUNCH_TRACKER_TEMPLATE.md`
- [ ] No invented facts about any example studio name appear as real claims anywhere on the page
