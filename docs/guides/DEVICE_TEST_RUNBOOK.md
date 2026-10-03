# Device Test Runbook

> How to test a release candidate on real iPhones and Android phones, record
> proof, and keep going when the tooling fights you. Part of the
> [Web to Mobile Launch Playbook](./WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md) (Phase 6).

**Principles**

1. A build upload is not a test. Count installs on real devices.
2. Simulators cannot do true sandbox purchases or real sign-in with the platform identity provider. Plan a physical-device session early.
3. Every result is recorded with build number, device, OS and date, or it did not happen.
4. Credentials and sandbox passwords are typed by the human. Agents hand over a numbered script.
5. Cap flaky tooling at 15 minutes, then switch route.

---

## 1. Setup

| Item | iOS | Android |
|---|---|---|
| Real device | One current iPhone, ideally one older OS | One mid-tier phone, one older OS |
| Install channel | TestFlight at least once | Internal testing track at least once |
| Test account | Sandbox Apple ID (separate from the real one) | License tester account in Play Console |
| App test user | A **free** account, plus an **empty reviewer** account | Same |
| Developer mode | On, for wireless build checks | USB debugging on, if you use adb |
| Network | Same Wi-Fi as the computer, no VPN or hotspot | Same |

Create a fresh free account for purchase tests so the baseline is known
(free tier, zero usage). Create a **disposable** account for deletion tests.

---

## 2. Test Matrix

Mark each cell with Pass, Fail or Not run, plus the build number.

| # | Check | iOS | Android | Notes |
|---|---|---|---|---|
| 1 | Build number on device matches the RC | | | See section 4 |
| 2 | Cold launch, no crash | | | |
| 3 | Reviewer login from an empty account | | | Exactly what the reviewer will do |
| 4 | Create flow from empty state | | | Review notes must start here |
| 5 | Core loop end to end | | | |
| 6 | Background and resume | | | |
| 7 | Offline start and reconnect | | | |
| 8 | Permissions prompts match purpose strings | | | |
| 9 | No pre-release badges or placeholder copy | | | |
| 10 | Paywall loads every product with prices | | | |
| 11 | Purchase: each product, sandbox | | | Human types sandbox password |
| 12 | Entitlement appears server-side after purchase | | | Check the entitlement table |
| 13 | Restore purchases | | | |
| 14 | Cancel or expire behavior | | | |
| 15 | Delete account (email provider) | | | Verify backend purge |
| 16 | Delete account (platform identity provider) | | | |
| 17 | Deep link from cold start | | | |
| 18 | Push permission and delivery (if used) | | | |
| 19 | Safe areas on notch and home indicator | | | |
| 20 | Accessibility: dynamic type or font scale, screen reader basics | | | |

Mark `Not run` honestly. Then write an **accepted-risk line** for each Not run
in the submit-day packet, with the owner's name beside it.

---

## 3. Evidence Log

Keep it in the repo next to the tracker.

```markdown
| Date | Build | Device / OS | Check # | Result | Evidence (screenshot, log, row id) |
|---|---|---|---|---|---|
| YYYY-MM-DD | NNN | iPhone model / OS | 11 | Pass | entitlement row id ... |
```

---

## 4. Verify Which Build Is Installed (No UI Needed)

Do not rely on someone saying "I installed the latest."

**iOS, wireless, with developer mode on:**

```bash
xcrun devicectl list devices
xcrun devicectl device info apps --device <DEVICE_ID> --bundle-id <your.bundle.id>
```

The output includes the installed version and build number.

**Android:**

```bash
adb devices
adb shell dumpsys package <your.package.name> | grep -E "versionName|versionCode"
```

---

## 5. Seeing the Phone Screen From a Computer

| Method | Good for | Known problem |
|---|---|---|
| Native iPhone mirroring on a Mac | Letting an agent drive taps | Sessions can drop on first input, torn down from the phone side. Mac-side fixes rarely help |
| QuickTime movie recording with the iPhone selected as source | View-only screen capture over USB | **Select the iPhone as the source first.** The default can be the computer webcam |
| Screenshot on device, send to computer | Store screenshot capture | Manual |
| `adb exec-out screencap` / `scrcpy` | Android mirroring and capture | Needs USB debugging |

**Mirroring recipe (budget 15 minutes):**

1. Lock the phone, same Wi-Fi as the Mac, no VPN or hotspot.
2. Close competing capture apps and device-hub tools.
3. Click Try Again and wait about 10 seconds.
4. If it drops on first input, toggle Wi-Fi off and on **on both devices**, retry once.
5. Still failing: stop. Use the manual test script (section 6) or command-line checks.

**Diagnose a drop on the Mac:**

```bash
log show --last 5m --predicate 'subsystem == "com.apple.screensharing" AND category == "ScreenContinuityApp"'
```

Look for the connection reaching a ready state followed quickly by a teardown
with "connectionInterrupted". If the Mac log shows the teardown originating from
peer absence on the peer-to-peer wifi interface, the phone side ended it and no
Mac-side change will fix it.

---

## 6. Manual Test Script Pattern (when automation cannot reach the device)

Write the script so a person can run it in about 30 minutes and report back one word per step.

```markdown
Build to test: NNN (confirm in Settings > About).
Account: free-test account (credentials in the password manager).
1. Launch the app. Pass or fail?
2. Open the paywall. Do all three products show prices? (list them)
3. Tap Monthly. Complete the sandbox purchase. You type the sandbox password.
   Tell me the result.
4. Settings > Restore Purchases. Result?
...
```

The agent then logs results, checks the backend for each entitlement, and gates
submission on the outcome.

---

## 7. Capture Store Assets in the Same Session

While the device is in hand, capture:

- Paywall screenshot showing every tier (reusable for each in-app purchase review screenshot, resized to the **exact** accepted size)
- Core-loop screenshots with realistic seed data
- Any screen the review notes mention

Resizing a capture: crop the phone region, upscale with a high-quality filter,
then produce the **exact** pixel dimensions the console lists. Re-check
dimensions with a command before uploading.

```bash
python3 -c "from PIL import Image; im=Image.open('capture.png'); print(im.size)"
```

---

## 8. Automated Checks to Run Alongside

- Unit tests for billing and entitlement code on the exact RC tag.
- End-to-end flows (see [Maestro Setup](../testing/MAESTRO_SETUP.md) and
  [Testing Framework Guide](../testing/TESTING_FRAMEWORK_GUIDE.md)).
- A CI end-to-end job, **run once and its run URL recorded**. A job that has never run is not a gate.

---

## 9. Exit Criteria

- [ ] RC build number confirmed on each test device by command
- [ ] Matrix complete or each gap has an accepted-risk line with an owner
- [ ] Reviewer path passes from an empty account
- [ ] Store screenshots and IAP review screenshots captured from the RC
- [ ] Evidence log committed
