#!/usr/bin/env python3
"""Validate a local review record, not the security of its subject. No network/writes."""
import datetime
import json
import sys
from pathlib import Path


def validate(record):
    errors, blockers = [], []
    def required(obj, fields, label):
        for key in fields:
            if not isinstance(obj.get(key), str) or not obj[key].strip():
                errors.append(f'{label}: missing text field {key}')
    if not isinstance(record, dict):
        return ['review must be an object'], []
    required(record, ('app', 'commit', 'environment', 'reviewed_at', 'owner'), 'review')
    try:
        datetime.date.fromisoformat(record.get('reviewed_at', ''))
    except (ValueError, TypeError):
        errors.append('reviewed_at must be an ISO date')
    findings = record.get('findings')
    if not isinstance(findings, list) or not findings:
        return errors + ['findings must be a nonempty array'], []
    seen = set()
    for n, item in enumerate(findings, 1):
        label = f'finding {n}'
        if not isinstance(item, dict):
            errors.append(f'{label}: must be an object')
            continue
        required(item, ('id', 'evidence', 'minimal_fix', 'test', 'regression_risk',
                        'recovery', 'release_dependency'), label)
        ident = item.get('id')
        if isinstance(ident, str):
            if ident in seen:
                errors.append(f'{label}: duplicate id')
            seen.add(ident)
        priority, kind, status = (item.get(k) for k in ('priority', 'classification', 'status'))
        if priority not in ('P0', 'P1', 'P2', 'P3'):
            errors.append(f'{label}: invalid priority')
        if kind not in ('verified-defect', 'untested-risk', 'not-applicable', 'post-traction', 'verified-control'):
            errors.append(f'{label}: invalid classification')
        if status not in ('open', 'verified', 'deferred', 'not-applicable'):
            errors.append(f'{label}: invalid status')
        if status == 'verified':
            required(item, ('verification',), label)
        if kind == 'not-applicable' or status == 'not-applicable':
            required(item, ('reason',), label)
            if kind != 'not-applicable' or status != 'not-applicable':
                errors.append(f'{label}: not-applicable classification/status must agree')
        if kind == 'verified-control' and status != 'verified':
            errors.append(f'{label}: verified-control needs verified status')
        if kind == 'post-traction' and priority in ('P0', 'P1'):
            errors.append(f'{label}: post-traction cannot conceal a P0/P1 gate')
        if priority in ('P0', 'P1') and kind in ('verified-defect', 'untested-risk') and status != 'verified':
            blockers.append(label)
    return errors, blockers


def main():
    if len(sys.argv) != 2:
        print('Usage: python3 scripts/check-hardening-review.py review.json')
        return 2
    try:
        record = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
    except (OSError, ValueError) as exc:
        print(f'Cannot read review: {type(exc).__name__}')
        return 2
    errors, blockers = validate(record)
    for message in errors:
        print('INVALID:', message)
    for message in blockers:
        print('UNRESOLVED PRIORITY GATE:', message)
    if errors:
        return 2
    if blockers:
        return 1
    print('Record checks passed; evidence truth and release approval require human review.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
