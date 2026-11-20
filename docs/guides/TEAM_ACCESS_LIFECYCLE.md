# Team Access Lifecycle

> **When to use this file:** your app has an account owner who adds other people (staff,
> teammates, seats) and those people sign in on the web or in a mobile app. Covers the
> whole life of a team member: invite, first sign-in, role change, removal, and the record
> that proves each step. Pair it with [Role Access Control](../architecture/ROLE_ACCESS_CONTROL.md)
> and [Audit Compliance](../architecture/AUDIT_COMPLIANCE.md).

Most templates stop at "invite sent". The failures happen after that: an invited person
who cannot sign in to the mobile app, a removed person whose session still works, a role
change nobody can account for later.

## The lifecycle

| Stage | What the owner does | What must be true afterwards |
|---|---|---|
| Invite | Enters name, email, role | Person has an account linked to this tenant with that role; an email is on its way |
| First sign-in | Nothing | Person has chosen a password (or other credential) the mobile app accepts |
| Assignment | Assigns work (classes, shifts, tickets) | Person sees their work; a person with none sees a clear empty state |
| Role change | Picks a new role | New access applies on the next request; old and new role are recorded |
| Removal | Turns the person off | Access ends on the next request; their open work is handed back; history is kept |
| Return | Turns the person back on | Same credentials work; work is reassigned on purpose, not restored silently |

## Invite to first sign-in

**The trap:** auth providers' invite links sign the person in on the web with no password.
That feels finished. Then they open the mobile app, which asks for email and password, and
they have none.

- [ ] The invite link lands on a "choose your password" page, not the home page.
- [ ] After saving, that page says what to do next: get the app, sign in with this email.
      Link only to store listings that are live.
- [ ] An expired or reused invite link says so and points to "Forgot password" with the
      invited email. Invite links are single-use.
- [ ] The redirect target is on the auth provider's allow list in every environment.
      Without it the provider falls back to the site root and the flow breaks silently.
- [ ] The server builds the redirect from an allow list of its own origins. Never from a
      raw request header.
- [ ] If the email already has an account, link it and tell the owner no invite was sent.
- [ ] The owner can resend an invite. Resend is refused once the person has signed in.
- [ ] A sign-in-only mobile app tells both audiences what to do: staff use the invited
      email; owners add their team on the web, with the exact menu path.

## States the product must show

Empty and in-between states are where people get stuck. Give each one its own words.

| State | Who sees it | Say this |
|---|---|---|
| Invite sent, not accepted | Owner | "Invite sent" with a resend action |
| Signed in, no team role | The person, in the app | Why (not added, added under another email, or turned off) and what to do, for staff and for owners |
| On the team, nothing assigned | Owner and the person | "Nothing assigned yet" with a link to where assignment happens |
| Work with nobody assigned | Owner | "Nobody assigned" on the item itself, never a removed person's name |
| Turned off | Owner | "Off" with a turn-on action |

## Removal that would pass an audit

Removal is a process, not a flag. Do these in this order.

1. **Tell the owner what will happen before they confirm.** Access ends now, how many open
   items will be handed back, history is kept, the change is recorded.
2. **Record the change first.** Write the audit row (who, to whom, before, after), then
   apply the change. If the record cannot be written, refuse the change. A change with no
   record is worse than a refused change.
3. **End access on the server, on every request.** Authorization checks read the person's
   active flag from the database each time. Do not rely on signing them out or on token
   expiry: an open session must simply stop working.
4. **Hand their open work back.** Future assignments return to "nobody assigned" so nothing
   runs under a removed person's name. Past work stays attributed to them.
5. **Keep the history.** Deactivate, never delete, the membership row.
6. **Remind the owner of what you do not control.** Door codes, shared logins, device
   passcodes.

### Guardrails

- [ ] The last owner cannot be removed or demoted.
- [ ] Nobody can change their own access.
- [ ] Every team action is scoped to the caller's tenant on the server, by id lookup, not
      by trusting a tenant id from the client.
- [ ] An invite cannot overwrite an existing owner's membership (an owner typing their own email).
- [ ] Team management is owner-only (or your chosen role), enforced in the server handler.
      Hiding the page is not enforcement.

## The audit trail

| Rule | Why |
|---|---|
| One row per add, resend, role change, removal, restore, and failed attempt | A reviewer asks "who had access when" and you answer from one table |
| Store actor email and target email as text at write time | The record still reads correctly after either account is deleted |
| Store before and after state | Shows what changed, not only that something changed |
| Append-only at the database | A trigger refuses UPDATE and DELETE for every role, the server role included. Revoke those privileges as well |
| Allow only foreign keys being cleared by a cascade | Otherwise deleting a tenant or person is blocked by its own audit rows |
| Show the trail to the owner | A history list on the team page turns the audit log into a feature and gets it looked at |

## Test it end to end

A unit test of the invite function does not find any of the failures above. One browser
test against a throwaway local backend should:

- [ ] Sign up an owner and add a person two ways (setup flow and team page).
- [ ] Read the invite email from the local mail catcher and open the link as a second browser profile.
- [ ] Choose a password as that person, then sign in with email and password.
- [ ] Change their role as the owner and see it in the history.
- [ ] Turn them off, then prove the still-open second session gets no tenant data and is
      refused by the team endpoints.
- [ ] Check the database: active flag off, future assignments cleared, audit rows present.

Then add database tests for the audit table: the server can insert, nobody can update or
delete, a member cannot forge a row.

## Red flags

| You see | It means |
|---|---|
| "Invite" is only reachable inside first-run setup | Owners cannot add anyone later |
| A team page backed by sample data | The feature looks done and is not |
| The end-to-end test skips the team step | Nobody has run the flow |
| Zero invited users in production | Nobody has run the flow there either |
| Removal only signs the person out | Their token still works until it expires |
| Audit rows written after the change | A failed write leaves a change with no record |
