#!/usr/bin/env bash
# Install SaaS-Viber skills into another repo (or your personal skills folder).
#
# Claude Code discovers project skills in <repo>/.claude/skills/<name>/SKILL.md
# and personal skills in ~/.claude/skills/<name>/SKILL.md.
#
# Usage (from the root of the repo that should get the skill):
#   bash <(curl -fsSL https://raw.githubusercontent.com/TaylorONeal/SaaS-Viber/main/scripts/install-skills.sh) competitive-research-skill
#   bash install-skills.sh --global competitive-research-skill   # into ~/.claude/skills
#   bash install-skills.sh --list                                # show available skills
#   bash install-skills.sh --all                                 # every skill
#
# Options:
#   --global        install into ~/.claude/skills instead of ./.claude/skills
#   --dest DIR      install into DIR instead
#   --ref REF       branch, tag or commit of SaaS-Viber to install from (default: main)
#   --source DIR    use a local SaaS-Viber checkout instead of cloning
#   --list          list available skills and exit
#   --all           install every skill
#
# Re-running replaces the installed copy, so it doubles as an update command.
# Each install writes a .saas-viber-source file recording the ref and commit.
set -euo pipefail

REPO_URL="${SAAS_VIBER_REPO:-https://github.com/TaylorONeal/SaaS-Viber.git}"
REF="main"
DEST=".claude/skills"
SOURCE=""
LIST=0
ALL=0
SKILLS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --global) DEST="$HOME/.claude/skills"; shift ;;
    --dest) DEST="$2"; shift 2 ;;
    --ref) REF="$2"; shift 2 ;;
    --source) SOURCE="$2"; shift 2 ;;
    --list) LIST=1; shift ;;
    --all) ALL=1; shift ;;
    -h|--help) sed -n '2,24p' "$0"; exit 0 ;;
    -*) echo "Unknown option: $1" >&2; exit 2 ;;
    *) SKILLS+=("$1"); shift ;;
  esac
done

TMP=""
cleanup() { if [ -n "$TMP" ]; then rm -rf "$TMP"; fi; }
trap cleanup EXIT

if [ -z "$SOURCE" ]; then
  TMP="$(mktemp -d)"
  git clone --quiet --depth 1 --branch "$REF" --filter=blob:none --sparse "$REPO_URL" "$TMP/saas-viber" 2>/dev/null \
    || git clone --quiet --depth 1 --filter=blob:none --sparse "$REPO_URL" "$TMP/saas-viber"
  git -C "$TMP/saas-viber" sparse-checkout set skills >/dev/null
  if [ "$REF" != "main" ] && [ "$(git -C "$TMP/saas-viber" rev-parse --abbrev-ref HEAD)" != "$REF" ]; then
    git -C "$TMP/saas-viber" fetch --quiet --depth 1 origin "$REF"
    git -C "$TMP/saas-viber" checkout --quiet FETCH_HEAD
  fi
  SOURCE="$TMP/saas-viber"
fi

SKILLS_DIR="$SOURCE/skills"
COMMIT="$(git -C "$SOURCE" rev-parse --short HEAD 2>/dev/null || echo unknown)"

available() {
  for d in "$SKILLS_DIR"/*/; do
    [ -f "$d/SKILL.md" ] && basename "$d"
  done
}

if [ "$LIST" -eq 1 ]; then
  available
  exit 0
fi

if [ "$ALL" -eq 1 ]; then
  while IFS= read -r s; do SKILLS+=("$s"); done < <(available)
fi

if [ ${#SKILLS[@]} -eq 0 ]; then
  echo "No skill named. Available:" >&2
  available >&2
  exit 2
fi

mkdir -p "$DEST"
for s in "${SKILLS[@]}"; do
  if [ ! -f "$SKILLS_DIR/$s/SKILL.md" ]; then
    echo "Skipping $s: no skills/$s/SKILL.md in SaaS-Viber ($REF)." >&2
    continue
  fi
  rm -rf "${DEST:?}/$s"
  cp -R "$SKILLS_DIR/$s" "$DEST/$s"
  printf 'repo: %s\nref: %s\ncommit: %s\n' "$REPO_URL" "$REF" "$COMMIT" > "$DEST/$s/.saas-viber-source"
  echo "Installed $s -> $DEST/$s (SaaS-Viber $REF @ $COMMIT)"
done
