# Project Governance

> Template describing how decisions are made in this project. Replace bracketed
> placeholders and move to your repo root if you open source your project. Start
> simple -- a solo maintainer model is a perfectly valid first version.

## Overview

This document defines roles, responsibilities, and the decision-making process
for [YOUR_PROJECT_NAME]. The goal is to keep the project healthy, transparent,
and welcoming while shipping reliably.

## Roles

| Role | Who | Responsibilities |
|------|-----|------------------|
| **Maintainer(s)** | [names/handles] | Final say on direction, releases, and merges. Reviews and merges PRs, triages issues, cuts releases. |
| **Contributors** | Anyone who submits a PR | Propose changes via pull requests; participate in discussion. |
| **Community** | Users and reporters | File issues, request features, report vulnerabilities. |

Promotion from contributor to maintainer is by invitation from existing
maintainers, based on a sustained track record of quality contributions.

## Decision-Making

- **Day-to-day changes** (bug fixes, docs, small features): a maintainer reviews
  and merges. One approval is sufficient.
- **Significant changes** (architecture, breaking changes, new dependencies): open
  an issue or discussion first. Aim for consensus among maintainers; if consensus
  cannot be reached, the lead maintainer decides.
- **Anything user-facing and irreversible** (data model changes, public API,
  license): requires explicit maintainer sign-off and a migration/communication
  plan.

## Proposing Changes

1. Open an issue describing the problem and proposed approach.
2. Discuss and reach rough agreement before large implementation effort.
3. Submit a PR referencing the issue. See [CONTRIBUTING.md](./CONTRIBUTING.md).
4. Address review feedback; a maintainer merges once approved and CI is green.

## Releases

- Releases follow [Semantic Versioning](https://semver.org/).
- The maintainer cuts releases and maintains the changelog.
- Security fixes are prioritized per [SECURITY.md](./SECURITY.md).

## Changing This Document

Amendments to governance are themselves a significant change: open an issue,
discuss, and require maintainer sign-off before merging.
