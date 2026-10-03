---
name: web-to-mobile-launch
description: Evidence-based launch workflow for taking a web SaaS to the App Store and Google Play -- day-one parallel paperwork, billing reconciliation, signing and CI, device testing, submit-day packet, human-only gates, and status reporting. Load for any launch status check, store submission prep, release candidate, or "are we ready to submit" question.
---

# Web to Mobile Launch Skill

The full playbook is `docs/guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md`. This skill
is the operating procedure an agent follows. Read the playbook phase that
matches the task before acting.

## 1. Evidence rules (always)

- Evidence order: live dashboard or database, then CI run URL, then dated tracker entry, then bot summaries. Higher wins.
- A gate is `Done` only with evidence cited. Otherwise write `UNVERIFIED`.
- Newer dated entries supersede older ones. No evidence in 7 days: `Stale`.
- Never mark a gate done from a document.
- One canonical tracker (`docs/templates/LAUNCH_TRACKER_TEMPLATE.md`). Update it whenever a gate moves.

## 2. Status check procedure

1. Read the tracker and the newest submit-day packet.
2. Verify live state where tools allow: store consoles, billing provider, CI runs, production database, mailbox for store emails from the last 10 days.
3. Report one table per priority tier: app, gate, state, evidence and date, one next action.
4. List human-only gates separately. Never act on them.
5. Flag stale rows and conflicts between documents.
6. Write the result back to the tracker.

## 3. Human-only gates (report, never act)

Agreements, banking, tax, trader declarations, entering passwords or sandbox
credentials, dragging local files into a console, final Submit for Review, and
releasing a manual release. Hand the human a numbered script.

## 4. Day-one parallel start

On any new app, start these in the same day: legal entity, business identifier,
Apple and Google developer accounts, agreements and banking, trader status,
domain, support email, privacy policy URL. Record start and completion dates.

## 5. Before the first signed build

- Permanent bundle id and package name chosen. Reject `com.example.*`.
- Key and certificate ownership decided.
- Known-green CI config copied. Working CI token and a tag trigger provisioned.
- Run each CI gate once and record the run URL.
- Inspect the produced artifact: signed, target SDK, id, version code.

## 6. Billing reconciliation (one pass, before sandbox tests)

Product ids identical across store, provider, paywall and server. Product type
matches paywall copy. Prices and regions. Offering and entitlement mapping. Server
accepts every store you ship. Webhook live. Production secrets set (put unverifiable
ones on the human list). Per platform: full billing path or free. Do not touch live
billing configuration during a launch.

## 7. Device testing

- Count installs on real devices, not builds.
- Verify the installed build by command (`xcrun devicectl device info apps`, `adb shell dumpsys package`).
- Budget 15 minutes for any flaky tooling (mirroring), then switch route.
- Select the phone as the capture source first. Never open a recording tool that may default to the computer webcam.
- Follow `docs/guides/DEVICE_TEST_RUNBOOK.md` and log evidence per check.

## 8. Pre-flight a week early

Click through each console's submission flow without submitting: price,
availability, declarations, review screenshots at the exact accepted size,
subscription group attached, reviewer login from an empty account, URLs load,
release type chosen.

## 9. Submit day

Use `docs/templates/SUBMIT_DAY_PACKET_TEMPLATE.md`. Write review notes from an
empty account. Add every product and the subscription group to one draft. Match
the "items ready" count. Leave legacy products explicitly unattached. Plan two human
touches: drag screenshots, click Submit.

## 10. After submit

Create a scheduled mailbox check: quiet while pending, on rejection report the
guideline cited and the fastest resubmit path, on approval remind to release and start
the launch comms checklist. Record timestamps in the tracker.

## 11. Working with other agents

One agent holds the device. Read the other agent's merged docs and session log
before repeating its work. Write handoffs into the repo: tracker, packet, lessons,
continuation steps. Do not touch live billing configuration.

## 12. Close the loop

After significant work, add new generalizable lessons to
`docs/ai-agents/LESSONS_LEARNED.md` (section "Launch and Store Submission") and
promote anything seen in two apps into this skill or `CLAUDE.md`.
