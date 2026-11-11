# Email and Domain Setup

> Added Nov 8, 2026.
> All prices and rules in this file are as of Nov 8, 2026. Verify before you buy. Prices change, intro offers expire, and renewal prices are often higher than first-year prices.
> Companion docs: [Developer Identity Choices](../../decisions/DEVELOPER_IDENTITY_CHOICES.md), `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md` (Phase 1), `docs/guides/IOS_READINESS_CHECKLIST.md`, `docs/guides/ANDROID_READINESS_CHECKLIST.md`, `docs/guides/BRANDING_GUIDE.md`.

## In one minute

Every app needs email addresses from day one: a support address customers can write to, a privacy address for legal requests, and a business address the app stores accept. You have three ways to get email: a free personal Gmail address, which is fast and free but exposes your personal name and cannot be the work email Apple requires for an organization account; email bundled with your domain registrar, which is usually the cheapest paid option but is often basic webmail with limited storage and a renewal price higher than the first year; or Google Workspace, which is Gmail with your own domain plus Drive, Docs, and Meet, at a verified list price starting at $7 per user per month on the annual plan as of Oct 2026. Pick the route that matches whether you are a solo founder testing an idea or a studio with several apps, set up the five addresses every app needs before you enroll in the stores, and do not change your public support address after launch, because it is printed on your store listings, your legal pages, and your users' accounts.

## 1. Plain language: the three routes

### 1.1 Route A: free personal Gmail

What it is: an address like `yourname@gmail.com`, free, set up in minutes, with the full Gmail interface you already know.

What it costs: $0, as of Nov 8, 2026.

When it fits: you are a solo founder testing one idea, you have not published anything yet, and you need an address today for development and testing.

What it cannot do: it cannot be the work email Apple requires for an organization developer account. Apple requires a work email on the organization's own domain for org enrollment, and a Gmail address will not pass. It also exposes your personal name in the address itself, it looks unprofessional on a public store listing and a privacy policy, it mixes personal mail with business mail in one inbox, and it is hard to hand over to a teammate, a support hire, or a buyer later, because the address is tied to your personal Google account.

Rule: use Gmail for testing if you must, but do not put a personal Gmail address on a public store listing, a privacy policy, or a support page. Set up a domain address before you publish.

### 1.2 Route B: email bundled with your domain registrar

What it is: when you buy a domain from a registrar such as GoDaddy, Squarespace, or Namecheap, the registrar often offers email on that domain, either included for a first period or as a low-cost add-on. You get an address like `support@yourapp.com` that uses the registrar's mail service.

What it costs: usually the cheapest paid option, often included or a few dollars a month for the first year, then renews higher. No price is given here on purpose, because registrar prices change often and renewal prices are the trap. Check the registrar's current renewal price before you buy, not just the first-year price. The method to compare is in section 4.

What to check before you buy: whether the mail is the registrar's own webmail or a resold Microsoft 365 mailbox, how much storage you get, whether you can use it in a normal mail app or only in webmail, how many mailboxes the price covers, and what the renewal price is after the first year. Basic webmail is fine for a support inbox that gets a few messages a week. It is not a good fit for a team that lives in email, needs shared inboxes, or needs Drive, Docs, and Meet in the same account.

When it fits: you are solo, you want the cheapest address on your own domain, and you mainly need a public support and privacy address that forwards to you or that you check in webmail.

### 1.3 Route C: Google Workspace

What it is: Gmail with your own domain, plus Drive, Docs, Sheets, Meet, and Calendar, all under your business name. Your address is `you@yourapp.com`, but the inbox is Gmail, with Gmail search, filters, and mobile apps.

What it costs: verified Oct 2026 US list prices, per user per month before tax, as of Nov 8, 2026. Verify on workspace.google.com/pricing before buying, because intro offers change.

| Plan | Annual plan (per user per month) | Flexible plan (per user per month) |
|---|---|---|
| Business Starter | $7 | $8.40 |
| Business Standard | $14 | $16.80 |
| Business Plus | $22 | $26.40 |

The annual plan bills per user for a year and costs less per month. The flexible plan bills month to month and costs more per month, but you can add or remove users at any time. Most solo founders start on Business Starter on the annual plan. Standard adds more Drive storage and better Meet features. Plus adds the most storage and compliance features. You do not need Plus to publish an app.

When it fits: you are a studio with more than one app, you have or will have a team, you want the same Gmail interface with a professional address, or you need Drive and Docs under the business name. It is also the cleanest route when you need a work email on your own domain for an Apple organization enrollment, because the address is a real business mailbox on your domain, not a personal Gmail address.

## 2. How to choose

| Your situation | Recommended route | Why |
|---|---|---|
| Solo, testing one idea, nothing published yet | Route A (Gmail) for now, then Route B or C before launch | Free and fast, but do not publish with it |
| Solo, about to publish one app under your own name | Route B (registrar email) or Route C Starter | You need an address on your own domain for the listing and the privacy policy |
| Solo or small studio, publishing under a company or studio name | Route C (Google Workspace) | You need a real work email on your own domain for Apple org enrollment, and a professional address for every app |
| Studio with several apps, or a team of two or more | Route C (Google Workspace) | One account per person, shared addresses for support and privacy, Drive and Docs under the business name |
| Tightest budget, one app, low email volume | Route B (registrar email) | Cheapest paid address on your own domain, if the renewal price stays acceptable |

If you are unsure, choose Route C Starter on the annual plan. It is the route that least often needs to be redone later, and the cost for one user is $84 for a year (see section 5).

## 3. The addresses every app needs from day one

Set these up before you enroll in the app stores, not after. The stores, your legal pages, and your users all need them, and changing them later means updating every listing and every page.

| Address | Purpose | Who reads it |
|---|---|---|
| `support@yourapp.com` | Customer support, the public contact on the store listing | You, or whoever handles support |
| `privacy@yourapp.com` | Privacy requests, data deletion requests, the contact on your privacy policy | You, and it must be monitored, because deletion requests have legal deadlines |
| `legal@yourapp.com` | Legal contact, terms and compliance mail (can be the same mailbox as privacy in a small studio, but use a separate address so you can split it later) | You |
| `hello@yourapp.com` | General contact, press, partnerships, the friendly address on your marketing site | You |
| `no-reply@yourapp.com` | Automated mail only, such as password resets and receipts, so replies do not go to a dead inbox | Nobody, it sends mail, it does not receive it |
| `yourname@yourapp.com` | Your named founder address, for store enrollment, business mail, and signing up for services | You |

You do not need six paid mailboxes for six addresses. See section 4.1 for how aliases and groups give you six addresses on one paid mailbox.

## 4. For experts and for agents: the precise detail

### 4.1 Alias vs mailbox vs group

These three words are often confused, and the difference decides what you pay for.

A mailbox is a paid seat with its own inbox, password, and storage. In Google Workspace, each user is a mailbox and you pay per user per month. In registrar email, each mailbox is usually priced separately too.

An alias is a second address that delivers to an existing mailbox, at no extra cost. In Google Workspace, `support@yourapp.com` can be an alias of `you@yourapp.com`, so mail to support lands in your inbox. In most registrar mail, aliases are also free. Use aliases for the addresses in section 3 when one person reads them all.

A group is a shared address that delivers to several mailboxes, such as a support group that delivers to you and a teammate. In Google Workspace, a group is free to create and can have its own address, such as `support@yourapp.com`, delivering to every member. Use a group when more than one person needs to read and reply to the same address, or when you want a shared support inbox that survives one person leaving.

Agent instruction: set up one paid mailbox for the founder, then create the five public addresses as aliases or as a group, not as five paid mailboxes. Record which address is an alias, which is a group, and which mailbox it delivers to, in the checklist at the end of this file. Do not create a paid mailbox per public address unless the founder asks for it.

### 4.2 SPF, DKIM, and DMARC in one paragraph a non-expert can follow

Email providers need proof that mail from your domain really comes from you, or they will mark it as spam or reject it. Three DNS records provide that proof, and you set them up once, in your domain's DNS settings, where your domain lives. SPF is a record that lists which mail servers are allowed to send mail for your domain. DKIM is a signature your mail provider adds to each message, so the receiver can verify the message was not changed in transit. DMARC is a record that tells receivers what to do when a message fails SPF or DKIM, such as reject it or quarantine it, and where to send reports about failures. Google Workspace and most registrars give you the exact values to paste, and they provide a checker to confirm the records are live. An agent can prepare the three records and the steps to add them, but DNS changes are a human-confirmed step, because a wrong DNS change can take your website and your email offline, so verify the records after they are added and record the date they were confirmed.

### 4.3 Domain purchase checklist

- [ ] Registrar chosen (GoDaddy, Squarespace, Namecheap, or another registrar you trust)
- [ ] Domain name matches the app name and the brand, and the matching social handles are available (see `docs/guides/BRANDING_GUIDE.md`)
- [ ] Auto-renew turned on, so the domain does not expire and take your email and your website down with it
- [ ] Privacy protection turned on, so your personal name, address, and phone number are not published in the public domain registry
- [ ] DNS access confirmed, so you can add the SPF, DKIM, and DMARC records and the records your mail provider needs
- [ ] Renewal price checked and recorded, including the price after any first-year discount ends
- [ ] Payment method on file is a business card or an account you will still control in a year, not a card that expires next month

### 4.4 How to compare registrar email prices without being misled

Do not compare first-year prices. Compare the renewal price, for the same number of mailboxes, over one year, including tax if the registrar shows it. The method: open the registrar's pricing page, find the email add-on, note the first-year price and the renewal price separately, note how many mailboxes and how much storage that price covers, and note whether the price is per mailbox or per account. Write those four numbers down for each registrar you compare, then compare the renewal totals. If a registrar does not show a renewal price before checkout, treat that as a warning sign and ask their support for the renewal price in writing before you buy. No registrar price is quoted in this file, because registrar prices change often and a number printed here would be stale within months.

### 4.5 Migration notes: why changing your public address later is painful

Moving from a personal Gmail address to a domain address after launch is painful because the old address is printed in places you do not control. It is on your App Store and Play listings, on your privacy policy and terms pages, in your users' inboxes from past mail, in your users' account records as their contact address, and in press, links, and screenshots other people made. Changing it means updating every listing, every legal page, and every template, resubmitting app metadata for review in some cases, and telling existing users to use the new address, while mail to the old address still arrives for months. Some of those places you cannot update at all, such as a screenshot someone else took. Do the migration before your first public launch, when the address has not been published anywhere yet. If you have already published with a personal Gmail address, migrate now, keep the old address monitored for at least a year, and set an auto-reply on the old address pointing to the new one.

## 5. Cost table: Google Workspace for one year

Prices are the verified Oct 2026 US list prices, per user per month before tax, as of Nov 8, 2026. Verify on workspace.google.com/pricing before buying.

### 5.1 One user, one year

| Plan | Annual plan, 1 user, 1 year | Flexible plan, 1 user, 1 year |
|---|---|---|
| Business Starter | $7 x 12 = $84 | $8.40 x 12 = $100.80 |
| Business Standard | $14 x 12 = $168 | $16.80 x 12 = $201.60 |
| Business Plus | $22 x 12 = $264 | $26.40 x 12 = $316.80 |

### 5.2 Three users, one year

| Plan | Annual plan, 3 users, 1 year | Flexible plan, 3 users, 1 year |
|---|---|---|
| Business Starter | $7 x 3 x 12 = $252 | $8.40 x 3 x 12 = $302.40 |
| Business Standard | $14 x 3 x 12 = $504 | $16.80 x 3 x 12 = $604.80 |
| Business Plus | $22 x 3 x 12 = $792 | $26.40 x 3 x 12 = $950.40 |

### 5.3 The other routes, for comparison

| Route | Cost for one year |
|---|---|
| Free personal Gmail | $0 |
| Email bundled with your domain registrar | Check the registrar's current renewal price, see section 4.4, do not compare first-year prices |
| Google Workspace, 1 user, Starter annual | $84 |

Note: the Workspace totals above are for mailboxes (paid users). The five public addresses in section 3 do not add cost when they are set up as aliases or as a group on one mailbox. A studio with one founder and five public addresses pays for one user, not six.

## 6. Agent checklist

Use this checklist when you set up email and domain for a new app. Do not mark an item done until you have evidence for it, such as a screenshot, a DNS checker result, or a dated note.

- [ ] Domain purchased, auto-renew on, privacy protection on
- [ ] Email route chosen (Gmail for testing only / registrar email / Google Workspace) and recorded with the reason
- [ ] If Google Workspace: plan chosen (Starter / Standard / Plus), billing chosen (annual / flexible), number of paid users recorded
- [ ] If registrar email: renewal price recorded, mail type recorded (registrar webmail / Microsoft 365), storage recorded
- [ ] Founder mailbox created (one paid mailbox)
- [ ] `support@` set up as an alias or a group, delivers to: ____________________
- [ ] `privacy@` set up as an alias or a group, delivers to: ____________________
- [ ] `legal@` set up as an alias or a group, delivers to: ____________________
- [ ] `hello@` set up as an alias or a group, delivers to: ____________________
- [ ] `no-reply@` set up for automated mail, replies go to: ____________________
- [ ] Founder named address set up: ____________________
- [ ] SPF record added and confirmed live on (date): ____________________
- [ ] DKIM record added and confirmed live on (date): ____________________
- [ ] DMARC record added and confirmed live on (date): ____________________
- [ ] Test mail sent to `support@` and received, on (date): ____________________
- [ ] Test mail sent from the domain address and not marked as spam, on (date): ____________________
- [ ] Support address entered in the App Store and Play listings, or recorded as not yet published
- [ ] Privacy address entered on the privacy policy page
- [ ] No personal Gmail address on any public listing, legal page, or support page
- [ ] Decision recorded: route, plan, cost per year, date set up: ____________________

## 7. Fill-in checklist (founder copy)

- App name: ____________________
- Domain: ____________________
- Registrar: ____________________
- Email route: free Gmail / registrar email / Google Workspace (circle one)
- If Workspace, plan: Starter / Standard / Plus (circle one), billing: annual / flexible (circle one)
- Paid users: ____________________
- Cost per year: $____________________
- Support address: ____________________
- Privacy address: ____________________
- Legal address: ____________________
- Date set up: ____________________
- Set up by: ____________________
