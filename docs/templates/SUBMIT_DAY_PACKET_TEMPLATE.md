# Submit-Day Packet Template

> Fill this in the day **before** submission. It replaces memory and chat history
> on the day. Nothing here is entered into a store console until a human does it.
> See [Web to Mobile Launch Playbook](../guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md), Phase 8.

**App:** [APP_NAME] **Version:** [x.y.z] **Build:** [NNN] **Tag:** [vX.Y.Z-rc.N]
**Prepared:** [date] **Supersedes:** [older packet to retire, if any]

Retire stale packets and submit notes the moment a new RC replaces them.

---

## 1. Gate Status (evidence, not hope)

| Gate | State | Evidence |
|---|---|---|
| Publisher entity and accounts | | |
| Agreements active (paid apps) | | |
| EU trader status | | |
| Build installed on a real device | | Device, OS, date |
| Reviewer login from empty account | | |
| Billing reconciled | | |
| Sandbox purchase / restore / cancel | | Run or NOT RUN |
| Account deletion tested | | |
| Pre-release copy removed | | |
| Pre-flight (console clicked through) | | Date |

---

## 2. Decisions Already Settled

List every question that was open and how it was resolved, so nobody reopens it.

- Which product attaches: [product id]. Which stays unattached: [legacy id].
- Which build to attach: [version (build)], tag [tag]. The console may still show an older build.
- Reviewer account: [login], library is empty, so notes start at the create flow.
- Release type: [manual | automatic | scheduled].

---

## 3. Products to Attach

| Product | Type | Id | Review screenshot file | Status |
|---|---|---|---|---|
| | | | `iap-review/...png` at the exact accepted size | Ready to Submit |

Subscription group: [name]. It must be added to the draft separately.
"Items ready to submit" count expected: [N].

---

## 4. Review Notes (paste-ready, no passwords)

```text
Start with: [create flow path].
Then: [core action path].
Account tab holds: purchase, restore, delete account.
Reviewer login: see Reviewer Information (credentials entered separately).
Anything unusual: [explain].
```

Credentials live in the password manager. A human enters them.

---

## 5. Store Assets Checklist

| Asset | File | Size verified |
|---|---|---|
| Screenshots (per required size) | | |
| IAP review screenshots | | |
| Icon | | |
| Feature graphic (Google) | | |
| Privacy, support, marketing URLs load | | |

---

## 6. Submit Order

**Apple**

1. Agreements show Active.
2. Version page: select build [NNN].
3. In-app purchases and subscriptions: upload each screenshot, confirm review notes, add each to the draft.
4. Add the subscription group to the draft.
5. Review Information: notes and reviewer credentials.
6. Check "items ready" count equals [N].
7. Submit for Review.

**Google**

1. Track: [internal | closed | production]. Upload AAB.
2. Data Safety, content rating, target audience, ads declaration.
3. Listing and graphics.
4. Pre-launch report: clear blocking issues.
5. Staged rollout: [percent].
6. Send for review.

---

## 7. Accepted Risks (owner may overrule)

| Not run | Risk if wrong | Owner decision |
|---|---|---|
| e.g. Sandbox purchase on device | A purchase-flow bug surfaces as a rejection, not a customer incident, if no live store customers exist yet | |

---

## 8. Human-Only Touches

1. Drag screenshots into the console.
2. Enter reviewer and sandbox credentials.
3. Click Submit.

---

## 9. After Submit

- [ ] Record timestamp and console status in the tracker.
- [ ] Create a scheduled check for the review email (quiet while pending).
- [ ] If rejected: capture the guideline cited, the fix, the fastest resubmit path.
- [ ] If approved: release (if manual), then run the launch comms checklist.
- [ ] Open the 1.0.1 list.
