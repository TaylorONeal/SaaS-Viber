# Landing Page, Waitlist, and Feedback

> The pages every app needs before launch: one page that earns the download, one list that earns the first users, and one channel that earns the next version.
>
> Added Nov 8, 2026.
>
> Companion docs: `docs/design/04-consumer-pages.md` (landing, pricing, about, and contact page structure), `docs/guides/SEO_SETUP_GUIDE.md` (search console, sitemap, Open Graph, structured data), `docs/guides/DIGITAL_PRESENCE_CHECKLIST.md` (domain, email setup, analytics, brand consistency), `docs/guides/BRANDING_GUIDE.md` (logo, colours, email branding), `docs/FAQ.md` (FAQ template by audience), `docs/app-store/SUBMISSION_GUIDE.md` (support URL and marketing URL fields), `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 2, web app live before mobile; Phase 10, post-launch).

## In one minute

Every app needs a landing page before launch, even if the app is not in the stores yet. The landing page makes one promise, shows it with one screenshot or video, and gives the visitor one action: join the waitlist before launch, or download from the stores after launch. The waitlist collects email only at first, confirms with double opt-in, and turns into your first TestFlight and closed-test testers. Feedback forms, in the app and on the site, separate bug reports from feature requests from billing issues, and someone reads them and replies within a promised time. The support page states the email, the response time, and the status page, and the email behind it is monitored daily.

## The landing page every app needs before launch

A landing page has one job: turn a visitor into a waitlist signup before launch, or a download after launch. Everything on the page serves that job. If a section does not serve it, cut it.

Structure, in order, from `docs/design/04-consumer-pages.md`:

1. Hero. One headline with the promise in under eight words, one subheadline that says who it is for, one primary call to action, and one hero image or video of the real app. The call to action is "Join the waitlist" before launch and "Download on the App Store / Get it on Google Play" after launch. Do not show store badges for a store the app is not on yet.
2. Social proof, only if it is real. Four to six customer or press logos, or two or three real quotes with a name and a role. Never fake a quote, a logo, or a review count. If you have no social proof yet, skip the section. An empty proof section is worse than none.
3. Problem statement. Two or three sentences, empathy first, describing the pain the app removes. Write it in the visitor's words, not in product jargon.
4. Features. Three or four key features, each with an icon, a title, and one or two sentences. Each feature ties back to the promise in the hero. If a feature does not support the promise, it belongs on a feature page, not on the landing page.
5. How it works. Three steps, numbered, plain language. A visitor should be able to repeat the three steps back to you after reading them once.
6. Pricing. A preview or "Starting at [price]" with a link to the full pricing page. If the app is free, say so plainly. Do not hide the price and do not show a price that is out of date. The pricing page itself follows the structure in `docs/design/04-consumer-pages.md`.
7. FAQ. Five to eight real questions, in the visitor's words, with short answers. Link to the full FAQ where it helps. See `docs/FAQ.md` for the template by audience.
8. Final call to action. The same primary action as the hero, repeated with a different angle on the value.
9. Footer. Links to the app pages, the studio page if there is one, and the legal pages: privacy policy, terms, data deletion, support. The footer is where a store reviewer looks for the privacy URL, so it must be there and it must work.

Technical basics, from `docs/guides/SEO_SETUP_GUIDE.md` and `docs/guides/DIGITAL_PRESENCE_CHECKLIST.md`:

- The page lives on your own domain, loads over HTTPS, and is separate from the app deploy, so a copy change cannot break the app.
- Page title and meta description written for humans first, search second. Open Graph tags on every page so shared links show the app name, a short description, and a 1200 by 630 image.
- Sitemap includes the landing page and the legal pages. It does not include authenticated app pages, API routes, or admin pages.
- Analytics installed before launch, with the signup or download click defined as a conversion, so you can see whether the page works.
- Page speed: images compressed, lazy loaded below the fold, largest contentful paint under 2.5 seconds. A slow landing page loses the signup before the copy is read.

## The waitlist

The waitlist is not a mailing list. It is a list of people who asked to be first. Treat it that way.

### What to collect

- Email only, at first. One field, one button. Every extra field you add cuts signups. Do not ask for a name, a phone number, or a company on the first form.
- Optional second field: "What do you want it to do?" One open text box, optional, never required. This one field is worth more than a ten question survey, because it tells you what the signup actually wants, in their words. Read every answer.
- Nothing else on the first form. You can ask more later, after they have joined and you have earned the right to ask.

### Double opt-in

- After signup, send a confirmation email with one click to confirm. Only confirmed addresses get launch mail. This is not bureaucracy; it keeps your sender reputation clean, it proves the address is real, and in some jurisdictions it is the lawful basis for marketing mail.
- The confirmation email says what the person signed up for, what they will receive, and how often. One sentence each.
- Unconfirmed signups get one reminder, then nothing. Do not keep mailing people who never confirmed.

### What to send, and how often

- Before launch: at most one email a month, plus the launch email. Each email has one piece of real news: a date, a feature that is ready, a screenshot of the real app. Never send "just checking in" mail.
- Launch email: the day the app is live, one email, with the store links and one sentence on what to do first. This is the email the whole waitlist exists for.
- After launch: move waitlist members to the normal product update list only if they agreed to it, and say so in the launch email. A waitlist signup is not consent to a weekly newsletter.
- Every marketing email has a working unsubscribe link and a physical or contact address in the footer, per the email rules in `docs/guides/DIGITAL_PRESENCE_CHECKLIST.md` section 7.

### Turning waitlist signups into testers

The waitlist is your fastest route to real testers, and the stores reward it:

- iOS: invite waitlist members to TestFlight. Internal testers need no review; external testers need a short Beta App Review. Give them a "What to Test" note that names two or three flows, not a generic "try everything".
- Android: add waitlist members to the closed testing track. New personal developer accounts created after Nov 13, 2023 must run a closed test with at least 12 testers opted in continuously for 14 days before applying for production access, so start this clock early. See `docs/guides/ANDROID_READINESS_CHECKLIST.md` section 8 and `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` Phase 1.
- Ask testers for one thing: the exact step where they got stuck, in their words, with a screenshot if they can. "It was confusing" is not feedback you can act on. "I tapped Save and nothing happened" is.
- Thank testers by name in the launch email, if they agreed to be named. Do not name anyone who did not agree.

### Privacy note on the form itself

- The waitlist form carries a one line privacy note next to the button, linking to the privacy policy. Example wording: "We use your email only to tell you when [App name] launches. Read our privacy policy." Fill in your app name and your policy link.
- The note is on the form, not buried in a footer. A person should see it before they type their email.
- Store waitlist emails separately from product accounts, delete unconfirmed addresses after a fixed period you state in the privacy policy, and never sell or share the list.

## Feedback forms

Feedback is how the second version gets better than the first. A form nobody reads is worse than no form, because it teaches users that you do not listen.

### Where feedback lives

- In the app: a feedback entry in Settings or on the Account tab, reachable in two taps from anywhere. Label it "Send feedback", not "Contact us", because users send feedback and contact support for different reasons.
- On the site: a feedback link in the footer and on the support page, pointing to the same form or the same email as the in-app entry, so feedback lands in one place.

### What to ask

Keep the form to four fields:

1. What kind of feedback is this? A choice of three: bug report, feature request, billing issue. This one choice decides who reads it first and how fast it gets an answer.
2. What happened, or what do you want? One open text box. For a bug, prompt for the steps: "What did you tap, what did you expect, what happened instead?"
3. Your email, prefilled if the user is signed in. Needed so you can reply. Say so on the form: "We reply to this address."
4. Optional screenshot or screen recording. For bug reports this is often the whole diagnosis.

Do not ask for a rating on the feedback form. Ratings belong in the store, at a happy moment, not in a form filled out by someone who is already frustrated.

### Where feedback goes, who reads it, and the response-time promise

- One inbox or one tracker for all feedback, whether it came from the app, the site, or email. If feedback lives in three places, it gets lost in two.
- One named person reads it daily. "The team reads it" means nobody does. Name the reader, even if the reader is you.
- Response-time promise, stated on the form and kept: for example, "We reply within two business days." A bug report gets an acknowledgement within that time even if the fix takes longer. Silence is the failure, not a slow fix.
- Close the loop. When a reported bug is fixed, reply to the person who reported it. When a requested feature ships, tell the people who asked. This is the cheapest retention work there is.

### Separating the three kinds

| Kind | Who reads it first | First reply | What happens next |
|---|---|---|---|
| Bug report | The person who can reproduce it, usually the builder | Acknowledgement within the promised time, plus one question if the steps are unclear | Reproduced, fixed, or added to the known issues list with a workaround, and the reporter is told |
| Feature request | The person who decides the roadmap, usually the owner | Acknowledgement, plus a plain statement of whether it fits the product direction | Logged in one list, reviewed regularly, requester told when it ships or when it is declined with a reason |
| Billing issue | The person who can see payments and refunds, usually the owner | Acknowledgement within the promised time, plus what you need from them (receipt, date, plan) | Resolved or refunded per the terms, and the answer cites the terms, not a guess |

Never answer a billing issue with a feature request reply, and never answer a bug report with a sales message. The three-choice field at the top of the form exists to prevent exactly that.

## The contact and support page

The support page is a promise, not a decoration. It follows the structure in `docs/design/04-consumer-pages.md` and it states four facts plainly:

1. Support email, monitored daily. One address, shown in full, not hidden behind a form only. The form is an option; the email is the guarantee.
2. Response time. The time you actually keep, for example "We reply within two business days." Do not promise "within 24 hours" if you reply in four days. A kept promise beats an ambitious one.
3. Status page link. Where users check whether the service is down, instead of emailing to ask. If you have no status page yet, say so and name the channel where you post outage updates, for example the studio social account or a status section on the site.
4. Quick links first. Documentation, FAQ, and the feedback form sit above the contact form, because most visitors can solve their own problem faster than you can reply, and they would rather do that.

The support page also links to the privacy policy, terms, and data deletion page, and it works without logging in. A locked-out user who cannot sign in must still be able to reach support; that is the moment they need it most.

## Fill-in checklist

- [ ] Landing page live on your own domain, separate deploy from the app, HTTPS enforced
- [ ] Hero written: promise in under eight words, who it is for, one primary call to action
- [ ] One screenshot or video of the real app in the hero, captured from the current build
- [ ] Store badges shown only for stores the app is actually live on; waitlist button shown before launch
- [ ] Pricing preview present with a link to the full pricing page, or a plain statement that the app is free
- [ ] FAQ written, five to eight real questions, with a link to the full FAQ
- [ ] Footer carries the legal links: privacy policy, terms, data deletion, support
- [ ] Page title, meta description, and Open Graph tags set; sitemap submitted
- [ ] Waitlist form collects email only, plus one optional "What do you want it to do?" field
- [ ] Double opt-in enabled; confirmation email states what the person signed up for and how often they will hear from you
- [ ] Launch email drafted: store links, one sentence on what to do first
- [ ] Waitlist to tester plan written: TestFlight invites for iOS, closed testing track for Android, with the 20 tester and 14 day clock started early where it applies
- [ ] Privacy note on the waitlist form itself, linking to the privacy policy
- [ ] Feedback form live in the app (two taps from anywhere) and on the site, with the three-kind choice, steps prompt, email, and optional screenshot
- [ ] One inbox or tracker for all feedback; one named person reads it daily
- [ ] Response-time promise stated on the form and on the support page, and actually kept
- [ ] Support page states the monitored email, the response time, the status page link, and the quick links to docs and FAQ
- [ ] Support page works without logging in
