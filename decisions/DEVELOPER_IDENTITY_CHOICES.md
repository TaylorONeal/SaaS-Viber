# Developer Identity Choices

> Added Nov 8, 2026.
> All prices and rules in this file are as of Nov 8, 2026. Verify before you enroll or pay. Store rules change, and a price or a wait time that was true in November may not be true when you read this.
> Companion docs: `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 0, section 0.5, and Phase 1), `docs/guides/IOS_READINESS_CHECKLIST.md`, `docs/guides/ANDROID_READINESS_CHECKLIST.md`, `docs/guides/BRANDING_GUIDE.md`, `decisions/PAYMENT_CHOICES.md`.

## In one minute

When you publish an app, each store asks who is publishing it: you as a person, or a company. That answer decides what name customers see as the seller, whether your personal legal name, phone number, and email address are exposed, and how hard it is to change your mind later. You can test an idea under your own name as an individual, which is fast and cheap. If you want your name kept private, or you plan to publish more than one app under one studio name, set up a company (usually an LLC) and enroll as an organization before your first public launch, because switching from individual to organization later is not a setting change, it is a new enrollment or a transfer, and the seller name customers see is hard to change after launch.

## 1. Plain language: what you are deciding

### 1.1 The two choices on each store

Apple and Google each offer two kinds of developer account: individual and organization. They are separate enrollments on each store, so you decide twice, once for Apple and once for Google, and the two decisions should match unless you have a specific reason they should not.

An individual account is you, a person. The seller name customers see is your personal legal name. An organization account is a company. The seller name customers see is the company name.

### 1.2 What name appears as seller

On Apple, the seller name on your App Store listing is the legal name on the account. For an individual, that is your personal legal name. For an organization, that is the company's legal name.

On Google Play, the developer name shown on your listing works the same way in practice: a personal account shows your name, an organization account shows the company name. The contact email on a Play listing is publicly visible, so choose that address with the same care as the seller name. See [Email and Domain Setup](../docs/guides/EMAIL_AND_DOMAIN_SETUP.md) for how to set up a business address before you enroll.

### 1.3 Privacy exposure: what the public can see

Under an individual account, your personal legal name is the public seller name. That is the main privacy cost. You also need a phone number and an email address for the account, and support contact details on the listing are visible to customers, so a personal phone number or a personal Gmail address used there is exposed to the public too.

Under an organization account, the company name is public instead of your name, and you can use a business phone number and a business email address on your own domain. That separation is the reason most founders form a company, even before they earn revenue. It is not only about taxes or liability. It is about whether a stranger who downloads your app can find your personal name, phone, and email from the store listing.

### 1.4 Why an LLC is usually the reason to choose organization

An organization account needs a real legal entity behind it. For most first-time founders in the US, that entity is an LLC (limited liability company) or a corporation. Forming the LLC is what makes the organization enrollment possible. The LLC gives you a legal company name, a business tax identifier, and a business address and phone number that are separate from your personal ones.

Do not form an LLC only because a checklist told you to. Form one when at least one of these is true: you want your personal name kept off the public store listing, you plan to publish more than one app under one studio name, you will take payments, hire people, or sign contracts in the company name, or you want business and personal money kept apart. If none of those is true yet, testing under an individual account is a reasonable first step, as long as you do it before your first public launch and you accept that you will need to move before launch if any of those become true.

The studio model works like this: one publisher entity covers many apps. You form one company, enroll once per store as that company, and publish every app under it. That is the model behind a multi-app studio page, the kind of page that lists several apps under one studio name, in the same way the template repo's own studio page lists several apps under one name. You do not need one company per app. One company, many apps, is the normal pattern.

### 1.5 What each store charges, as of Nov 8, 2026

Apple Developer Program: $99 per year, for an individual or an organization. It renews every year. If it lapses, you cannot submit updates, and your apps can be removed from sale. Verify the current fee on developer.apple.com before you enroll.

Google Play Console: $25 one-time fee, for a personal or an organization account. You pay it once when you create the account. Verify the current fee on play.google.com/console before you enroll.

These are the store enrollment fees only. They do not include the cost of forming an LLC, which varies by state, or the cost of a D-U-N-S number, which is free to request (see section 2.2), or the cost of domain email (see [Email and Domain Setup](../docs/guides/EMAIL_AND_DOMAIN_SETUP.md)).

### 1.6 What is hard or impossible to change later

This is the part that costs founders the most time, so read it before you enroll.

Seller name: hard to change after launch. On Apple, changing the seller name generally means updating the legal entity behind the account, which is a formal process with Apple, not a field you edit. On Google, the developer name can be changed in some cases, but a change after you have reviews, links, and press pointing at the old name is disruptive even when it is technically possible. Pick the name you want customers to see for years, not for this month.

Account type, individual to organization: not a setting. You cannot flip an individual Apple or Google account into an organization account. You enroll as a new organization, or you transfer the apps to an organization account. A transfer moves the listing, the reviews, and the ratings in most cases, but it is a formal process, it takes time, it needs both accounts to be in good standing, and it can go wrong at the worst moment, which is usually launch week. Do it before launch, not after.

Bundle ID (iOS) and package name (Android): permanent. The bundle ID looks like `com.yourcompany.yourapp` and the package name looks the same. Once an app is published with one, it cannot be changed. Changing it means a new app listing, with no reviews, no ratings, and no existing users carried over. Never ship, or even prepare a signed build with, a placeholder such as `com.example.*`. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 3, section 3.1, and `docs/guides/IOS_READINESS_CHECKLIST.md`, section 2.

App name transfer limits: an app name itself can be changed on a listing, but the name is tied to the listing and the account that owns it. If you publish under your personal name and later move to a company, the app moves with the transfer process above, and the public history of the listing moves with it. Plan the name and the owner together, on day one, so you do not have to move either later.

### 1.7 Decision table

| Question | Individual | Organization (LLC or corporation) |
|---|---|---|
| Seller name customers see | Your personal legal name | Your company name |
| Personal name kept private | No | Yes, if you use business contact details too |
| Needs a legal entity | No | Yes, an LLC or corporation |
| Needs a D-U-N-S number | No | Yes, on Apple and on Google for orgs |
| Needs a business tax ID (EIN in the US) | No, your SSN is the tax identifier (see section 2.3) | Yes, the company EIN |
| Needs a work email on your own domain | No, but recommended anyway | Yes, Apple requires it for org enrollment, Gmail will not pass |
| Needs a public website on your own domain | No | Yes, Apple requires a working public website for the organization |
| Apple fee, as of Nov 8, 2026 | $99 per year | $99 per year |
| Google fee, as of Nov 8, 2026 | $25 one time | $25 one time |
| Google closed test before first production release | Yes for personal accounts created after Nov 13, 2023 (see section 2.5) | Organization accounts are not subject to the personal-account closed test rule in the same way, verify the current rule before you rely on this |
| Best for | Testing one idea fast, solo, before launch | A studio with several apps, a public brand, or any founder who wants their personal name private |
| Hard to reverse | Switching to org later means a new enrollment or a transfer | Closing a company or changing its legal name is a formal legal process |

### 1.8 Recommended default

Solo test under an individual account, switch to an organization (LLC) account before your first public launch if you want your name private or you will have multiple apps.

In practice that means: if you are still validating the idea and you have not published anything, enroll as an individual, build, and test. As soon as you decide this app will go public under a brand, or you decide you want a second app under the same studio name, stop and form the company, get the D-U-N-S number, and enroll as an organization before you submit the first public version. Do not publish first and fix the identity later. The fix is always more expensive than the delay.

If you already know you want a studio, skip the individual step. Form the company first, then enroll as an organization on both stores, then build. That is the slower start and the faster finish.

## 2. For experts and for agents: the precise detail

### 2.1 Apple Developer Program: individual vs organization

Individual enrollment: Apple asks for your legal name, a phone number, an email address, and payment of $99 per year (as of Nov 8, 2026). Two-factor authentication on the Apple ID is required. Approval can take 24 to 48 hours, sometimes longer. The seller name is your legal name. Some capabilities are limited for individual accounts compared with organization accounts, for example team roles and some business features. See `docs/guides/IOS_READINESS_CHECKLIST.md`, section 1.

Organization enrollment: Apple asks for the legal entity name, a D-U-N-S number (see section 2.2), a public working website on the organization's own domain, a work email address on that domain, and a person with legal authority to bind the company (see section 2.4). Apple does not accept a DBA (doing business as), a trade name, a branch, or a sole proprietorship for organization enrollment. The entity must be a legal entity in its own right, such as an LLC or a corporation, with its own D-U-N-S number. Approval takes longer than an individual enrollment, days to weeks after the identifiers exist, because Apple verifies the entity. The seller name is the legal entity name.

What Apple will not accept for an organization, stated plainly: a DBA or trade name alone, a sole proprietorship, a branch office of another company, or a personal name with a business suffix added. If the only name you have is a DBA, you are not ready for organization enrollment. Form the entity first.

### 2.2 D-U-N-S number

A D-U-N-S number is a 9-digit business identifier issued by Dun and Bradstreet. It is free to request. Apple requires it for organization enrollment. Google also requires it for organization accounts.

Timing, as of Nov 8, 2026, verify before you rely on it: Apple says to allow up to 5 business days for Dun and Bradstreet to issue a D-U-N-S number, plus up to 2 business days for Apple to receive it after it is issued. Google warns that getting a D-U-N-S number can take up to 30 days in some cases. Start the D-U-N-S request the same day you form the company. It is on the critical path in `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 1, because every later step waits on it.

Agent instruction: when you prepare the enrollment packet, request the D-U-N-S number first, record the date requested, and record the date issued. Do not tell the founder the organization enrollment is ready until the D-U-N-S number is issued and Apple or Google has confirmed receipt. A D-U-N-S number that has been requested but not issued is not evidence of anything.

### 2.3 EIN vs SSN

In the US, an individual developer uses their Social Security Number (SSN) as the tax identifier for the Apple and Google paid-apps agreements and tax forms. An organization uses the company's Employer Identification Number (EIN), issued by the IRS when the company is formed. Never put an SSN in a document, a repo, a chat log, or a shared tracker. The EIN is a business identifier and is less sensitive, but it still belongs in a password manager or a secure vault, not in the repo. Tax forms, banking details, and payout setup are human-only steps. An agent prepares the packet and records the status, a person signs and submits. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 1 and Phase 8, section 8.3.

### 2.4 Legal authority to bind the company

For an organization enrollment, Apple requires a person who has legal authority to sign agreements on behalf of the company, such as a founder, an officer, or a director. That person must be able to confirm they can bind the company legally. This is not a formality. If the person enrolling cannot legally bind the company, the enrollment can be rejected or later invalidated. The enrolling person should be a founder or an officer named in the company formation documents. Record who that person is in the decision record at the end of this file, and keep the company formation documents where that person can reach them.

### 2.5 Google Play: personal account closed test rule

Personal accounts created after Nov 13, 2023 must run a closed test with at least 12 testers opted in for 14 days before production access, as of Nov 8, 2026. Verify the current rule on play.google.com/console before you plan around it, because Google has changed the tester count and the wording of this rule before. The Android checklist in this repo, `docs/guides/ANDROID_READINESS_CHECKLIST.md`, was corrected Nov 8, 2026 to the same 12-tester rule. Treat the current Play Console help page as the authority, not either document, and start the closed test clock early. If you publish under an organization account, confirm whether the personal-account closed test rule applies to you at all, and do not assume it does not.

Note for agents: when you plan a Google launch date, add the 14-day closed test to the timeline before the production date, and record the date the test started and the number of testers opted in. A test that started but never reached the required tester count does not satisfy the rule.

### 2.6 EU trader status (Digital Services Act)

EU trader status is a day-one item, not a launch-week item. Under the EU Digital Services Act (DSA), Apple and Google must collect and display trader information for developers who distribute apps in the EU and who count as traders. If you sell apps or in-app purchases in the EU, you will be asked to declare whether you are a trader, and to provide trader details such as a business name, address, and contact information. Non-trader status has its own declaration path, but do not declare yourself a non-trader to avoid paperwork if you are in fact selling a product. Decide your trader status when you decide your entity, record it in the tracker, and answer the declaration in each console a week before submission, as part of the pre-flight check in `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 7, section 7.3. Verify the current declaration wording in each console, because the stores add new declarations over time.

### 2.7 What an agent should and should not do

An agent can: prepare the comparison table for the founder, list the documents needed for each enrollment, draft the decision record, check the public fee and timing pages and report what they say, and track dates in the launch tracker.

An agent cannot: form the LLC, request the D-U-N-S number on the founder's behalf, sign the Apple or Google agreements, enter tax or banking details, pay the enrollment fee, or click submit on an enrollment. Those are human-only steps, by a person with legal authority. See `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`, Phase 8, section 8.3.

## 3. Decision record (fill this in)

Copy this section into your repo's decision log and fill it in before you enroll.

- App name: ____________________
- Studio or company name (if any): ____________________
- Decision: individual / organization (circle one)
- Apple account type: individual / organization (circle one)
- Google account type: individual / organization (circle one)
- Reason for this choice: ____________________
- If organization, legal entity type: LLC / corporation / other: ____________________
- If organization, state or country of formation: ____________________
- If organization, D-U-N-S number requested on (date): ____________________
- If organization, D-U-N-S number issued on (date): ____________________
- If organization, EIN on file (in password manager, not in this file): yes / no
- Person with legal authority to bind the company: ____________________
- Work email on own domain set up: yes / no (address: ____________________)
- Public website on own domain live: yes / no (URL: ____________________)
- EU trader status decided: trader / non-trader (circle one), decided on (date): ____________________
- Decided by: ____________________
- Date decided: ____________________
- Review trigger (when to revisit this decision, for example before a second app or before first public launch): ____________________

## 4. Checklist before you enroll

- [ ] Seller name decided, and you are willing to have customers see it for years
- [ ] Individual or organization decided for Apple, and separately for Google
- [ ] If organization: legal entity formed, or a dated plan to form it before first public launch
- [ ] If organization: D-U-N-S number requested, with the request date recorded
- [ ] If organization: public website on the company's own domain is live
- [ ] If organization: work email on the company's own domain is set up (Gmail will not pass for Apple org enrollment)
- [ ] If organization: person with legal authority to bind the company is named
- [ ] Business phone number and business email are set up, separate from personal ones
- [ ] Bundle ID and package name chosen, permanent, not a placeholder
- [ ] EU trader status decided and recorded
- [ ] Apple fee ($99 per year, as of Nov 8, 2026) and Google fee ($25 one time, as of Nov 8, 2026) verified on the store pages before paying
- [ ] If Google personal account: closed test plan started early enough to cover 14 days before production
- [ ] Decision record above filled in and saved in the repo
