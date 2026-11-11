# Attribution End to End

> Added Nov 8, 2026. All prices, limits, and rules in this file are as of Nov 8, 2026. Verify in the vendor docs or console before you buy, enroll, or ship.
>
> Related docs: [Attribution Tracking](../prd/ATTRIBUTION_TRACKING.md) (the UTM vocabulary, the five models, the event taxonomy) | [Tracking Plan](../developer/tracking-plan.md) (the event registry) | [GA4 and Web Analytics](./GA4_AND_WEB_ANALYTICS.md) (what GA4 can and cannot tell you) | [Admin Dashboard](./ADMIN_DASHBOARD.md) (where attributed numbers get read) | [Analytics Setup](../developer/analytics-setup.md) (the code)

## In one minute

Attribution is the answer to one question: where did this customer come from, and what did they do before they paid. You answer it in three steps, and if any step is missing the answer is "we do not know", not a guess. First, tag every link you control with UTMs so the visit carries its own story. Second, capture that story on the visitor's first touch and store it on their customer record when they sign up. Third, freeze it at conversion, because a customer who found you on a podcast in March and paid in June was still found on the podcast, no matter what they clicked last. The store breaks the chain twice, once on iOS and once in the waitlist to install handoff, and this doc names both breaks honestly instead of papering over them.

## 1. Plain language: what attribution is and is not

Attribution is not mind reading. It is record keeping. A person clicks a link, your site writes down where the link said they came from, and when that person becomes a customer, that note is attached to their record. If nobody wrote it down, there is nothing to attribute. If two different notes disagree, you need a rule for which one wins, and you need to have written that rule down before the argument happens.

What attribution cannot do: it cannot prove that an ad caused a purchase. A person can see your post, search your name a week later, click an organic result, and sign up. The record says organic search. The post may have done the work. Attribution tells you what the last recorded touch was, and what the first recorded touch was. It does not tell you what was in the person's head. Anyone who sells you certainty here is selling you a story.

## 2. UTM discipline: tag every link you control

UTM parameters are the five query values you add to a link so the visit arrives with its story attached. The controlled vocabulary lives in [Attribution Tracking](../prd/ATTRIBUTION_TRACKING.md). The discipline is this doc's job.

| Parameter | What it means | Convention |
|---|---|---|
| `utm_source` | Where the traffic comes from | Lowercase, no spaces, hyphens. `google`, `instagram`, `newsletter`, `partner-acme` |
| `utm_medium` | The type of channel | Controlled vocabulary only: `cpc`, `cpm`, `social-paid`, `social-organic`, `email`, `referral`, `affiliate`, `organic`, `direct`, `product`, `event`, `pr`, `community` |
| `utm_campaign` | The specific campaign | `YYYY-MM-campaign-name`, for example `2026-11-launch-week` |
| `utm_term` | Paid search keyword, optional | The keyword or keyword group |
| `utm_content` | Which ad variant, optional | Descriptive slug, for example `hero-cta` |

Rules that make the vocabulary work:

- **Lowercase always.** `Instagram` and `instagram` are two different sources in every tool. Pick lowercase and enforce it.
- **No spaces, no underscores in values.** Hyphens only. A space in a URL becomes `%20` and then becomes a second, broken source.
- **One campaign name per campaign.** If the launch is `2026-11-launch-week` in the email and `launchweek` in the social post, you have two campaigns and no total.
- **Never tag organic search or direct traffic.** Those are inferred when nothing is tagged. Tagging them creates a fake campaign.
- **Short links carry the campaign.** A short link that strips the UTMs destroys the story. Build the UTMs into the destination URL first, then shorten it, and click the short link once to check the UTMs survive.
- **Ad click IDs are captured, not trusted.** Tandava's server-side capture stores `fbclid`, `gclid`, `gbraid`, `wbraid`, `ttclid`, and `msclkid` when they arrive, and computes the channel on the server, never trusting the client's claim about where it came from. Copy that: capture the click ID, compute the channel yourself.

Put the UTM vocabulary in the tracking plan. Every event in `docs/developer/tracking-plan.md` that fires at signup carries `utm_source`, `utm_medium`, and `utm_campaign` as properties. If a link is not in the plan, it is not tagged, and if it is not tagged, it is unattributed.

## 3. First-party attribution: capture first touch, freeze at conversion

This is the pattern the CueCraft family proved, and it is the backbone of this doc. It has four parts.

### 3.1 Capture on first touch, in the browser and on the server

When a visitor first lands, capture three things: the UTMs, the referrer (`document.referrer`), and the landing page. CueCraft stores them in the browser under a visitor id and an acquisition context, then POSTs them once at signup and clears local storage. The browser copy is a cache. The server copy is the record.

Capture the first touch, not every touch, as the permanent record. Later visits may update the `src` and `cta` fields for the current session, but the first touch is what answers "where did they come from". If you overwrite first touch on every visit, a customer who found you on a podcast and came back through a Google search becomes a Google customer, and your podcast looks worthless.

### 3.2 Store it on the customer record at signup

At signup, the server writes the first-touch values onto the customer record: `utm_source`, `utm_medium`, `utm_campaign`, `referrer_url`, `landing_page`, `first_touch_at`. The existing PRD in this repo calls the tables `user_attributions` (first touch) and `attribution_touches` (multi-touch log), with the anonymous id populated before signup and the `user_id` filled in after. Use those table names or your own, but keep the split: one row that says where they came from, and a log that says every touch they had.

The join happens at sign-in, and it is a link, never a replacement. Tandava's PRD-024 model is the clearest version: one visitor, one journey, frozen at conversion. Three ids: a `visitor_id` in local storage, a `profile_id` linked at sign-in on every browser, and a studio relationship carrying the source, the first touch, and the converting touch for that studio. Links are added, never replaced, so a person who signs in on a second browser keeps both journeys.

### 3.3 First touch vs last touch, and the rule for which wins

- **First touch** answers "where did they come from". Use it for channel decisions: which sources bring people who stay.
- **Last touch** answers "what closed them". Use it for campaign decisions: which message turned a visitor into a customer.
- **Converting touch** is the touch on the visit where they converted. Tandava freezes first touch and converting touch together at conversion, so the record says both where they came from and what closed them, and neither changes afterwards.

Owners ask both questions, so the default view shows both. A report that shows only last touch will always over-credit search and under-credit the podcast, the post, and the friend who told them about you. A report that shows only first touch will never credit the email that actually closed the sale. Show both, label both, and never present one as "the" attribution.

The repo's existing PRD also describes linear, time-decay (with a 7-day half-life), and position-based (40/20/40) models. Those are useful for a mature product with thousands of conversions. For a new product, first touch and converting touch are enough. Add the fancier models when you have enough data for them to mean something, not before.

### 3.4 The customer record: four populations, one source of truth per question

This is the part founders get wrong most often, and it is the part the user asked for explicitly: your customer is recorded in four different places, and they are four different populations with different keys.

- **`auth.users`** is the login record. It knows an email and a password, or a social login. It does not know whether the person paid.
- **Your profiles table** is the product record. It knows the display name, the plan, and the settings. It is keyed to the auth user.
- **Stripe customers** are the billing record. Stripe knows the card, the subscription, and the payment history. It does not know what the person did in your app.
- **RevenueCat customers** are the store billing record. RevenueCat knows the App Store and Play purchases, the entitlements, and the renewals. It does not know your web customers.

Never add these together. A Stripe customer count and a RevenueCat customer count overlap on every person who pays on both web and mobile, and neither one equals your profile count. Name the source of truth per question, in writing, in the decision record: signups come from the profiles table, revenue comes from Stripe plus RevenueCat, and the attribution join lives on the profile, because the profile is the only record that touches all three.

Erasure has to cross all four. Deleting a profile without clearing the Stripe customer, the RevenueCat customer, and the auth user is not deletion, it is hiding. TeacherTree proved the failure mode: account removal clears `user_id` on matching funnel rows only, it does not remove the browser id or the public-handle properties. That is partial de-identification, not deletion. Write the erasure checklist across all four populations before you need it, and test it on a test account.

## 4. Store attribution gaps: what the stores give you and what they do not

This is the honest part. The stores report downloads and sources, and they do not join to in-app behavior. No tool in this template fixes that. Anyone who says otherwise is selling you a join that does not exist.

### 4.1 What you get from each store

- **App Store Connect** gives you downloads, sources, and campaign data for App Store campaign links. It tells you how many people arrived and from which campaign. It does not tell you which of those people signed up, activated, or paid.
- **Google Play Console** gives you downloads and store listing performance, and Android has one real join the iOS side does not: the Play Install Referrer passes UTMs through the install, so an Android install can carry its campaign into the app. Use it. It is the only store-to-app attribution that actually works end to end.
- **RevenueCat** gives you purchase attribution: which purchases happened, through which store, on which plan. It tells you what was bought, not what brought the buyer.

### 4.2 The iOS limit, stated plainly

Tandava's PRD-024 states it, and this doc repeats it because it is the fact founders most want to be untrue: **on iOS, install source is reported from App Store Connect data, not joined per person.** App Store campaign links are visible only in App Store Connect analytics, not inside the app. You can know that 40 installs came from a campaign. You cannot know which 40 people they were, or whether any of them paid. Do not build a report that pretends otherwise. Do not buy a tool that promises a per-person iOS install join, because the store does not provide the data it would need.

### 4.3 What to do instead

- Report store attribution at the population level: installs by source from App Store Connect, installs by campaign from Play Install Referrer, purchases by plan from RevenueCat. Three numbers from three dashboards, labeled with their source, never merged into one.
- Use the web to close the loop where you can. A waitlist signup on the web carries UTMs. A TestFlight invite sent to that email carries the same record. When the tester installs and signs in with the same email, the first-party join at sign-in connects the web touch to the app account. That is the web-to-app handoff, and it works because the email is the key, not because the store helped.
- Accept the gap for pure store installs. A person who finds you in the App Store, installs, and signs up with a fresh email has no first touch you can record. Label them unattributed. CueCraft's rule applies here too: missing or empty `utm_source` is unattributed, not proven direct traffic.

## 5. Web-to-app handoff: the waitlist to TestFlight to install chain

The chain has four links, and it breaks at the third one if you are not deliberate.

1. **Waitlist signup on the web.** UTMs captured, stored on the waitlist record. This is the first touch.
2. **TestFlight invite (iOS) or closed test invite (Android).** Sent to the waitlist email. The invite is tied to the email, so the record survives.
3. **Install.** On Android, the Play Install Referrer can carry the campaign through. On iOS, nothing carries it. The install itself is unattributed unless the email joins it later.
4. **Sign-in inside the app.** The app account is created with the same email as the waitlist record. The first-party join links the web touch to the app account, and the journey is complete.

Where the chain breaks: a tester signs up for the waitlist with one email and installs with a different Apple ID email; a tester forwards the TestFlight invite to a friend, who installs with no waitlist record at all; a tester installs from the store directly without ever touching the waitlist. Each break produces an unattributed install, and each one is normal. The honest report says "42 waitlist signups, 31 installs we can join, 11 unattributed", not "42 signups became 42 installs".

For Android closed testing, remember the current rule: personal accounts created after Nov 13, 2023 must run a closed test with at least 12 testers opted in continuously for 14 days before applying for production access, as of Nov 8, 2026. Start that clock early, because the waitlist is your tester pool and the clock does not start until 12 testers are opted in.

## 6. Worked example: a fictional yoga class app

The app is called Second Mat. It is fictional. Nothing in this example is a real customer.

- **March:** A yoga teacher hears about Second Mat on a podcast. She visits the landing page from the podcast link, tagged `utm_source=podcast-yoga-talk&utm_medium=referral&utm_campaign=2026-03-launch`. First touch recorded: podcast, referral, March launch. She joins the waitlist and leaves.
- **April:** She searches "yoga class planner", finds Second Mat organically, and signs up. Last touch is organic search. First touch is still the podcast. The customer record stores both: first touch podcast, converting touch organic search, conversion in April.
- **May:** She teaches her first class from a sequence, which is the app's activation event, and upgrades to the paid plan on the web through Stripe. The payment is recorded in Stripe, the activation in the first-party table, and the attribution on the profile says podcast first, organic search converting.
- **June:** She installs the iOS app from the App Store after seeing a post. App Store Connect reports one more install from the App Store. The app has no record of the post, and the install is unattributed in the store report. When she signs in with the same email, the first-party join connects the app account to the existing profile, and the journey stays podcast first, organic search converting. The install is not re-attributed to the post.

If Second Mat reported only last touch, the podcast would get no credit and the team would stop doing podcasts. If it reported only first touch, the search page that closed the sale would get no credit. Both numbers are shown, both are labeled, and the decision is made with both in view.

## 7. Expert detail: the capture table and the models

Per-surface capture is the Tandava pattern worth copying: one capture row per surface, so a studio page, a landing page, and a share link each record their own visits and do not contaminate each other. Tandava's server-side capture stores path, referrer, UTM tags, ad click ids, and device class, computes the channel on the server, and never stores IP, user agent string, or cookies. Its rate limits are 300 visits per source per hour and 20,000 per studio per hour, enforced through a salted hash kept at most a day, and unknown or private surfaces record nothing and do not say why. Copy the shape: compute the channel on the server, cap abuse silently, store nothing identifying.

The five models, and when each is honest to use:

| Model | What it does | Use when |
|---|---|---|
| First touch | All credit to the first touch | Deciding which channels bring people |
| Last touch (converting touch) | All credit to the touch that converted | Deciding which message closes sales |
| Linear | Credit spread evenly across all touches | You have many touches per journey and want a rough share |
| Time decay, 7-day half-life | Recent touches get more credit | Your sales cycle is days, not months |
| Position-based, 40/20/40 | 40% first, 40% last, 20% spread across the middle | You want one number that respects both ends |

Default view: first touch and converting touch, side by side. Add the other three only when you have enough conversions for them to be stable. A model computed on 12 conversions is noise with a formula.

## 8. Agent instructions

- Never invent a UTM value. If a link has no UTMs, the visit is unattributed, and the record says unattributed.
- Never overwrite first touch. Later visits update the current session only.
- Never join a store install to a person on iOS. Report the App Store Connect number at the population level and label it.
- Never add Stripe customers, RevenueCat customers, auth users, and profiles together. Name the source of truth per question.
- Never present one attribution model as "the" attribution. Show first touch and converting touch together, and label both.
- Never copy a real measurement ID, PostHog key, or credential from another repo. Use `G-XXXXXXXXXX` and `phc_your_project_api_key`.
- Never store IP addresses, user agent strings, or cookies in an attribution table. Capture path, referrer, UTMs, and click ids only, and compute the channel on the server.
- When a link is created, check it carries its UTMs and that the short link preserves them. Click it once and verify.

## 9. Fill-in attribution worksheet

- [ ] UTM vocabulary written in the tracking plan: sources [ ], media [ ], campaign format [ ]
- [ ] First-touch capture built: browser [ ], server endpoint [ ], stored on [table name]
- [ ] Customer record join: at [signup / sign-in], key is [email / profile id]
- [ ] First touch frozen at conversion: [yes / no], converting touch frozen: [yes / no]
- [ ] Source of truth per question: signups [profiles table], revenue [Stripe + RevenueCat], attribution [profile]
- [ ] Erasure checklist across all four populations: auth [ ], profiles [ ], Stripe [ ], RevenueCat [ ], tested on a test account [ ]
- [ ] Android Play Install Referrer: [wired / not wired]
- [ ] iOS limit acknowledged: install source from App Store Connect only, no per-person join [yes]
- [ ] Waitlist to install chain tested end to end with [ ] testers, [ ] joins succeeded, [ ] unattributed
- [ ] Default report shows first touch and converting touch side by side [yes / no]

**Decision record**

- Attribution models used: [first touch and converting touch, plus ]
- First-touch storage: [table and fields]
- Unattributed is labeled [unattributed, never direct]
- Store attribution reported at [population level], from [App Store Connect / Play Console / RevenueCat]
- Verified Nov 8, 2026. Next verify date: [ ].
