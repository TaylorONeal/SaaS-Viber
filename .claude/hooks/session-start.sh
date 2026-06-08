#!/bin/bash
# SessionStart hook for SaaS-Viber.
# Prepares a Claude Code on the web session: installs JS dependencies once the
# project actually declares any, and validates documentation integrity so the
# session starts on a known-good repo. Idempotent and non-interactive.
set -euo pipefail

# Web-only: skip entirely in local sessions.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"

# Install JS deps only if the project declares any (avoids creating a lockfile
# for the empty template; auto-installs once an adopter adds dependencies).
if [ -f package.json ] && node -e "const p=require('./package.json');process.exit((Object.keys(p.dependencies||{}).length+Object.keys(p.devDependencies||{}).length)>0?0:1)"; then
  echo "[session-start] Installing JS dependencies..."
  npm install --no-audit --no-fund
else
  echo "[session-start] No JS dependencies declared yet; skipping npm install."
fi

# Validate documentation links (dependency-free, fast). Non-fatal so a doc nit
# never blocks a session from starting.
if [ -f scripts/check-docs.py ]; then
  echo "[session-start] Checking documentation links..."
  python3 scripts/check-docs.py || echo "[session-start] docs:check reported issues (see above)."
fi

echo "[session-start] Ready."
