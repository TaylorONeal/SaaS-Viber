# Legal Pages Template

> Fill-in templates for the four legal pages every app needs. Copy them, fill in the brackets, publish them on your own domain, and link them from the app, the landing page, and the store listings.
>
> Added Nov 8, 2026.
>
> Companion docs: `docs/architecture/APP_STORE_COMPLIANCE.md` (privacy policy requirements and locations for both platforms), `docs/guides/IOS_READINESS_CHECKLIST.md` (section 3, privacy policy; section 9, account deletion), `docs/guides/ANDROID_READINESS_CHECKLIST.md` (section 3, privacy policy; section 10, Data Safety), `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 2, legal pages before mobile; Phase 3.2, account deletion), `docs/app-store/SUBMISSION_GUIDE.md` (privacy policy URL and support URL fields).

## In one minute

Every app needs four legal pages, live on your own domain, before it can ship: a privacy policy, terms of service, a support and contact page, and a data deletion page. This file gives you fill-in templates for all four, with [BRACKETS] where your real values go. They are templates, not legal advice, so get a lawyer for your jurisdiction to read the filled-in privacy policy and terms before your first public launch. Apple requires a live privacy URL for every app and in-app account deletion; Google Play requires the same, plus the Data Safety form. The privacy URL must be on your own domain, not a Google Doc.

## Read this first: these templates are not legal advice

These pages are fill-in templates, not legal advice, and not a substitute for a lawyer. Privacy law differs by jurisdiction, and it changes. What counts as personal data, what consent you need, how long you may keep data, and what rights your users have all depend on where you operate and where your users live. Examples: the GDPR in the EU, the CCPA and similar state laws in the US, and app store rules that add their own requirements on top of the law.

Get a lawyer for your jurisdiction before you publish. A short review by a lawyer who knows your market costs far less than a store rejection, a regulator letter, or a user dispute. At minimum, have a lawyer read the filled-in privacy policy and terms once before your first public launch, and again whenever you start collecting a new kind of data, sharing data with a new third party, or selling in a new region.

How to use this file:

- Copy each template to its own page on your site. One URL per page, for example `/privacy`, `/terms`, `/support`, `/delete-my-data`.
- Replace every [BRACKET] with your real value. Do not publish a page with brackets still in it. A reviewer who finds "[YOUR APP NAME]" in your privacy policy will reject the app.
- Keep the "Last updated" date current. Update it every time the page changes, and keep a short note of what changed.
- Keep the plain language. If a sentence needs a lawyer to understand it, rewrite it. Your users, and the store reviewers, read these pages too.

## What the stores check

Apple requires a live privacy policy URL for every app, with no exceptions. The URL is entered in App Store Connect, and the policy must also be reachable from inside the app, usually in Settings or on the Account tab. Apple also requires in-app account deletion: a visible control in the app that deletes the account and its data, not just an email address to write to. The privacy nutrition labels you complete in App Store Connect must match the policy and match what the code actually collects.

Google Play requires a privacy policy URL under App content, and the same policy must be reachable from inside the app. Google also requires the Data Safety form, which declares what data is collected, whether it is shared, whether it is encrypted in transit, and whether users can request deletion. Google also requires in-app account deletion, with the same standard as Apple: a control in the app, plus a web link for users who cannot open the app.

Both stores check that the privacy URL loads, that it is on your own domain, and that it is accessible without logging in. The privacy URL must be on your own domain, not a Google Doc, not a shared document link, and not a page behind a login. A Google Doc fails the check because you can change who sees it, it has no stable address you control, and it looks temporary. Host the pages on the same domain as your landing page.

Both stores also check that the policy describes the data the app actually collects. If the policy says "we collect no data" and the app sends analytics events with a device identifier, the listing is rejected and the policy is the evidence. Write the policy from the real data flow, not from a wish.

## Template 1: Privacy Policy

Publish at: [YOUR DOMAIN]/privacy
Last updated: [DATE]

### Privacy Policy for [APP NAME]

[APP NAME] is made by [LEGAL ENTITY NAME]. This policy explains what data we collect, why we collect it, where it is stored, who we share it with, how long we keep it, and how you can delete it or ask us about it.

Contact for privacy questions: [PRIVACY CONTACT EMAIL]. Postal address, if you have one and your jurisdiction requires it: [ADDRESS OR "Not applicable, we operate online only"].

### What data we collect

List every type, in plain language. Delete the rows that do not apply, and add any type that is missing. Do not leave a row in place that describes data you do not collect.

| Data | When we collect it | Why |
|---|---|---|
| Email address | When you create an account or join the waitlist | To identify your account and to send account mail |
| Name | [When, or "We do not collect your name"] | [Why, or delete the row] |
| Password | When you create an account | Stored as a hash, never in plain text. We cannot see your password. |
| Profile information you enter | [When, for example when you create a class or a project] | To provide the service you asked for |
| User content you create | [When, for example classes, notes, photos] | To store and show it back to you |
| Payment information | When you subscribe | Processed by [PAYMENT PROVIDER, for example Stripe or the App Store]. We do not store your card number. |
| Device information | When you use the app | To keep the app working, to fix crashes, and to keep your account secure |
| Usage data | When you use the app | To understand which features are used, so we can improve them |
| Location | [When, or "We do not collect location"] | [Why, or delete the row] |
| Analytics events | When you use the app | Sent to [ANALYTICS PROVIDER, or "We do not use third-party analytics"] |
| Crash reports | When the app crashes | To fix the crash. Reports include [WHAT THEY INCLUDE, for example device model and app version] |
| Support messages | When you contact us | To answer you and to fix the problem |

If a row says "we do not collect" something, make sure the code agrees. Check this before every release.

### Why we use your data

We use your data only for these purposes:

- To provide the service you signed up for.
- To keep your account secure and to prevent abuse.
- To process payments and manage your subscription.
- To answer support messages.
- To improve the app, using aggregated usage data that does not identify you.
- To send account mail, such as password resets and receipts.
- To send marketing mail, only if you agreed to it, and only until you unsubscribe.

We do not sell your personal data. We do not use your content to train models. [Delete the training sentence if it does not apply, or rewrite it to state what you actually do.]

### Where your data is stored

Your data is stored by [HOSTING PROVIDER, for example Supabase, AWS, or your own server] in [REGION, for example US East or EU West]. Data is encrypted in transit with TLS and at rest with [ENCRYPTION, for example AES-256, or state what your provider uses]. Access is limited to [WHO CAN ACCESS IT, for example "our team members who need it to run the service"].

Backups: [HOW BACKUPS WORK, for example "Encrypted backups are kept for [NUMBER] days and then deleted"].

### Who we share your data with

We share data only with the services needed to run the app. List each one. Delete the rows that do not apply.

| Service | What we share | Why | Their privacy policy |
|---|---|---|---|
| [PAYMENT PROVIDER] | Payment details and email | To process subscriptions | [LINK] |
| [HOSTING OR DATABASE PROVIDER] | Account and content data | To store the app data | [LINK] |
| [ANALYTICS PROVIDER] | Usage events | To understand feature use | [LINK] |
| [EMAIL PROVIDER] | Email address | To send account and marketing mail | [LINK] |
| [CRASH REPORTING PROVIDER] | Crash reports | To fix crashes | [LINK] |
| [BILLING PROVIDER, for example RevenueCat] | Purchase and subscription status | To manage entitlements across iOS, Android, and web | [LINK] |

We do not share your data with advertisers. We do not share your data with data brokers. [Delete or rewrite if that is not true.] If the law requires us to share data with authorities, we will tell you unless the law forbids it.

### How long we keep your data

- Account data: kept while your account is active, and deleted when you delete your account, as described in the Data Deletion page.
- Waitlist emails: kept until launch and for [NUMBER] months after, then deleted. Unconfirmed waitlist signups are deleted after [NUMBER] days.
- Support messages: kept for [NUMBER] months after the conversation ends.
- Backups: deleted within [NUMBER] days after the data they contain is deleted.
- Payment records: kept for [NUMBER] years where the law requires it for tax and accounting, even after account deletion. These records contain [WHAT THEY CONTAIN, for example the transaction amount and date] and not your content.

### Your rights

Depending on where you live, you may have the right to:

- See a copy of the data we hold about you.
- Correct data that is wrong.
- Delete your account and your data, in the app or by email, as described in the Data Deletion page.
- Export your data in [FORMAT, for example CSV or JSON].
- Object to marketing mail, by unsubscribing in any marketing email.
- Ask how your data is used, by writing to [PRIVACY CONTACT EMAIL].

We answer rights requests within [NUMBER] days. To make a request, write to [PRIVACY CONTACT EMAIL] from the email address on your account, and tell us what you want.

### Children

[APP NAME] is not intended for children under [AGE, for example 13 or 16, per your jurisdiction]. We do not knowingly collect data from children under that age. If you believe a child has created an account, write to [PRIVACY CONTACT EMAIL] and we will delete it.

### Changes to this policy

If we change this policy, we update the "Last updated" date at the top and, for significant changes, we tell you by [HOW, for example email or an in-app notice] at least [NUMBER] days before the change takes effect.

### What the stores check

Apple requires this URL to be live for every app, and requires it to be reachable from inside the app. Google Play requires it under App content, and requires the Data Safety form to match it. Both require in-app account deletion. The privacy URL must be on your own domain, not a Google Doc.

## Template 2: Terms of Service

Publish at: [YOUR DOMAIN]/terms
Last updated: [DATE]

### Terms of Service for [APP NAME]

These terms are the agreement between you and [LEGAL ENTITY NAME] ("we", "us") for your use of [APP NAME], including the website at [DOMAIN], the iOS app, and the Android app. By creating an account or using the app, you agree to these terms. If you do not agree, do not use the app.

### What the service is

[APP NAME] is [ONE OR TWO SENTENCES: what the app does and who it is for]. The service is provided as described on our website and in the store listing. Features may change over time; we will tell you about significant changes in the app or by email.

### Your account

- You must be at least [AGE] years old to create an account.
- You are responsible for keeping your password secret and for everything done with your account.
- One account per person, unless [YOUR RULE, for example "your plan allows team members"].
- You must give accurate information when you create an account, and keep it up to date.
- Tell us at [SUPPORT EMAIL] if you believe your account has been used without your permission.

### Payment and refunds

- Plans and prices are shown on [PRICING PAGE URL] and in the app before you pay. Prices are in [CURRENCY].
- Subscriptions renew automatically until you cancel. The renewal date and price are shown before you subscribe and in your account settings.
- If you subscribe through the App Store or Google Play, that store handles payment, renewal, and cancellation, under that store's rules. Manage the subscription in your store account settings, not only in our app.
- If you subscribe on the web, payment is processed by [PAYMENT PROVIDER]. You can cancel in [WHERE, for example Settings, then Billing].
- Cancelling stops future charges. You keep access until the end of the current billing period. We do not give partial refunds for unused days, unless [YOUR EXCEPTION, for example "the law in your country requires it"].
- Free trials last [NUMBER] days. You will not be charged during the trial. If you do not cancel before the trial ends, the subscription starts and you are charged [PRICE AND INTERVAL]. We show the trial end date and the price before you start the trial.
- Refund requests: write to [SUPPORT EMAIL] within [NUMBER] days of the charge, telling us the date, the amount, and the reason. We decide refund requests under these terms and under the rules of the store or payment provider that took the payment. Store purchases are refunded by the store, not by us, where the store's rules say so.

### Acceptable use

You agree not to:

- Use the service for anything unlawful, or to break the law in your country.
- Upload content you do not have the right to share, or content that infringes someone else's rights.
- Harass, threaten, or harm other users, or post content that is hateful, violent, or sexually explicit involving minors.
- Try to access other users' accounts or data, or to break the security of the service.
- Copy, resell, or redistribute the service, or use it to build a competing service from our content.
- Use automated tools to scrape the service or to create accounts in bulk, unless we have agreed it in writing.

We may remove content that breaks these rules, and we may suspend or terminate accounts that break them repeatedly or seriously.

### Your content

You own the content you create in the app. By using the service you give us permission to store, display, and process that content only as needed to run the service, for example to show it back to you and to back it up. We do not claim ownership of your content, and we do not use it for advertising or to train models, unless [YOUR EXCEPTION, or delete this clause if there is no exception].

### Termination

- You can delete your account at any time, in the app or as described in the Data Deletion page. Deleting your account ends these terms for future use.
- We may suspend or terminate your account if you break these terms, if you do not pay, or if we stop providing the service. We will tell you by email where possible, and give you [NUMBER] days to export your data unless the termination is for serious abuse or a legal reason.
- If we stop providing the service entirely, we will give [NUMBER] days notice and a way to export your data.

### Disclaimers and limits

- The service is provided "as is" and "as available". We do not promise it will be uninterrupted or error free, though we work to keep it running and to fix problems promptly.
- To the extent the law allows, our liability for any claim related to the service is limited to [LIMIT, for example "the amount you paid us in the [NUMBER] months before the claim"].
- Nothing in these terms limits rights you have under the law in your country that cannot be limited by agreement.

### Changes to these terms

If we change these terms, we update the "Last updated" date and tell you by [HOW, for example email or an in-app notice] at least [NUMBER] days before the change takes effect. Continued use after the change means you accept the new terms.

### Governing law and contact

These terms are governed by the laws of [JURISDICTION]. Questions about these terms: [LEGAL OR SUPPORT EMAIL]. Postal address, if required: [ADDRESS].

### What the stores check

The stores require terms to be accessible, and they require subscription terms, trial terms, and cancellation to be clearly shown before purchase. If your terms and your paywall disagree about price, renewal, or cancellation, the paywall is what the reviewer judges, and the mismatch is a rejection risk.

## Template 3: Support and Contact Page

Publish at: [YOUR DOMAIN]/support
Last updated: [DATE]

### Support for [APP NAME]

How can we help?

### Before you write to us

Most questions are answered faster here:

- Documentation: [LINK TO DOCS]
- Frequently asked questions: [LINK TO FAQ]
- Service status: [LINK TO STATUS PAGE, or "We post outage updates at [CHANNEL]"]
- Feedback and feature requests: [LINK TO FEEDBACK FORM]

### Contact us

- Support email: [SUPPORT EMAIL]. We reply within [RESPONSE TIME, for example two business days].
- Feedback: [FEEDBACK FORM LINK]. Tell us what kind of feedback it is: bug report, feature request, or billing issue.
- Billing issues: write to [SUPPORT OR BILLING EMAIL] and include [WHAT YOU NEED, for example the receipt, the date, and the plan name].
- Press: [PRESS EMAIL OR "Write to the support email and mark it Press"].
- Legal and privacy: [PRIVACY CONTACT EMAIL].

When you write, tell us: what you were doing, what you expected, what happened instead, and which device and app version you use. A screenshot helps for bug reports.

### Response time promise

We reply to support mail within [RESPONSE TIME]. Bug reports get an acknowledgement within that time even if the fix takes longer. If you have not heard back within [NUMBER] days, write again and put "Second request" in the subject line.

### What the stores check

Both stores require a support contact: an email or a URL that works. Apple asks for a support URL in App Store Connect; Google Play asks for a contact email that is publicly visible. The support page must work without logging in, because a locked-out user needs it most.

## Template 4: Data Deletion Page

Publish at: [YOUR DOMAIN]/delete-my-data
Last updated: [DATE]

### How to delete your data in [APP NAME]

You can delete your account and your data at any time. This page explains how, what is deleted, and how long backups take.

### Delete in the app (fastest)

1. Open [APP NAME].
2. Go to [EXACT PATH, for example Settings, then Account, then Delete Account].
3. Read the warning, then confirm. You may be asked to enter your password.
4. Your account and your data are deleted as described below.

If you cannot open the app, use the email method below.

### Delete by email

Write to [DELETION OR SUPPORT EMAIL] from the email address on your account, with the subject line "Delete my account". Tell us the email address on the account. We will confirm the request by replying to that address, then delete the account within [NUMBER] days.

### What is deleted

When you delete your account, we delete:

- Your account, profile, and login credentials.
- Your content: [LIST WHAT COUNTS AS CONTENT, for example classes, notes, projects, uploaded files].
- Your settings and preferences.
- Your usage history tied to your account.

We keep only what the law requires us to keep, and only for as long as the law requires:

- Payment records for tax and accounting: kept for [NUMBER] years. These contain [WHAT THEY CONTAIN, for example the transaction amount and date] and not your content.
- Support messages: kept for [NUMBER] months after the conversation ends, then deleted.

### How long backups take

Deleted data is removed from our live systems immediately when you confirm deletion. Encrypted backups that still contain your data are deleted within [NUMBER] days, as backup cycles run. After that date, your data is gone from backups too.

### Export before you delete

Deleting your account is permanent. Before you delete, export your data if you want to keep it: go to [EXACT PATH, for example Settings, then Data, then Export]. Exports are provided in [FORMAT, for example CSV or JSON] and typically complete within [TIMEFRAME].

### After deletion

After your account is deleted, you cannot sign in again with the same account, and we cannot restore your content. You can create a new account with the same email address if you want to start again.

Questions about deletion: [PRIVACY CONTACT EMAIL].

### What the stores check

Apple and Google both require in-app account deletion: a visible control in the app, not just an email address. Both also accept a web deletion link for users who cannot open the app. The Data Safety form and the privacy nutrition labels must state that users can request deletion, and the deletion page must match that statement. The privacy URL must be on your own domain, not a Google Doc.

## Publishing checklist for all four pages

- [ ] Each page lives on your own domain, at its own URL, and loads without logging in
- [ ] Every [BRACKET] is replaced with a real value; no placeholder text remains
- [ ] The privacy policy lists every data type the code actually collects, and no type it does not collect
- [ ] The privacy policy names every third party that receives data, with a link to their policy
- [ ] The terms state the price, the renewal, the trial length, and how to cancel, and match the paywall exactly
- [ ] The support page states the monitored email, the response time, and the status page link
- [ ] The data deletion page states the exact in-app path, what is deleted, and how long backups take
- [ ] A lawyer for your jurisdiction has read the filled-in privacy policy and terms
- [ ] The privacy URL is entered in App Store Connect and in Play Console under App content
- [ ] The privacy policy, terms, and data deletion links are in the app, in Settings or on the Account tab
- [ ] The privacy policy, terms, and data deletion links are in the footer of the landing page and the studio page, if there is one
- [ ] The "Last updated" date is current on every page, and a note records what changed
- [ ] The in-app account deletion control is tested end to end on a real device, from an account with real content

## Fill-in checklist

- [ ] App name: [__]
- [ ] Legal entity name: [__]
- [ ] Domain for all four pages: [__]
- [ ] Privacy policy URL: [__]
- [ ] Terms of service URL: [__]
- [ ] Support page URL: [__]
- [ ] Data deletion page URL: [__]
- [ ] Privacy contact email: [__]
- [ ] Support email: [__]
- [ ] Payment provider named in the policy and the terms: [__]
- [ ] Hosting and database provider named in the policy: [__]
- [ ] Analytics provider named in the policy, or "none" recorded: [__]
- [ ] Backup retention period stated: [__] days
- [ ] Response time promise stated on the support page: [__]
- [ ] Lawyer review done, date: [__], reviewer: [__]
- [ ] Store fields updated: App Store Connect privacy URL, Play Console App content privacy URL, Data Safety form, privacy nutrition labels
- [ ] In-app deletion tested, date and device: [__]
