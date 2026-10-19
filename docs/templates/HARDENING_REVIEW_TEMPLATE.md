# Hardening review record

Copy the fields into the app's existing launch tracker; avoid another competing status document. Follow [Production Hardening](../guides/PRODUCTION_HARDENING.md).

Record app/platform, repository and commit, environment/deployed version, date, scope/limitations and owner. For each item record priority, classification, evidence, proposed minimal fix, test, regression risk, recovery and release approval dependency. Close a defect only with verification evidence. Keep private details in the private app repository.

Optional machine-readable form (one or more findings; this example intentionally fails the release gate):

```json
{
  "app": "example",
  "commit": "reviewed-commit",
  "environment": "isolated-test",
  "reviewed_at": "2026-10-19",
  "owner": "release-owner",
  "findings": [{
    "id": "RECOVERY-1",
    "priority": "P1",
    "classification": "untested-risk",
    "status": "open",
    "evidence": "Restore has not been exercised for this candidate.",
    "minimal_fix": "Run isolated synthetic export/import round-trip.",
    "test": "Verify all record types and interrupted import atomicity.",
    "regression_risk": "Replacement import could overwrite existing local records.",
    "recovery": "Disposable profile only; keep fixture and original export.",
    "release_dependency": "Owner reviews result before release."
  }]
}
```

`classification`: `verified-defect`, `untested-risk`, `not-applicable`, `post-traction`, `verified-control`.
`status`: `open`, `verified`, `deferred`, `not-applicable`.
P0/P1 defects or untested risks remain blocking unless verified; `deferred` does not silently waive them. Verified items require `verification` evidence. Not-applicable items require `reason`. The checker cannot authenticate claims, enforce approval or validate deployment state. Exit 0 means record checks passed, 1 means unresolved priority gates, 2 means malformed/incomplete record.
