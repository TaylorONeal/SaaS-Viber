#!/usr/bin/env python3
"""Documentation integrity checker for the SaaS-Viber template.

Validates that every local link in the Markdown docs resolves to a real file,
while tolerating the intentional fill-in placeholders that make this a template
(e.g. `[PRD-XXX]`, `[YOUR_APP_NAME]`). Dependency-free: standard library only,
so it runs anywhere Python 3 is available and needs no `npm install`.

Usage:
    python3 scripts/check-docs.py          # check, exit 1 on broken links
    python3 scripts/check-docs.py --orphans # also report docs nothing links to

CI runs this on every push/PR (see .github/workflows/docs-check.yml).
"""
from __future__ import annotations

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SKIP_DIRS = {".git", "node_modules", "dist", "build"}

LINK_RE = re.compile(r"\]\(([^)]+)\)")
HTML_COMMENT_RE = re.compile(r"<!--.*?-->", re.DOTALL)

# A link target is an intentional template placeholder (not a broken link) if it
# contains any of these markers. Adopters replace these with real paths.
PLACEHOLDER_MARKERS = ("PRD-XXX", "YOUR_", "[", "{", "filename", "your-")


def iter_markdown_files():
    for base, dirs, files in os.walk(ROOT):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        for name in files:
            if name.endswith(".md"):
                yield os.path.join(base, name)


def is_external(link: str) -> bool:
    return link.startswith(("http://", "https://", "#", "mailto:", "tel:"))


def is_placeholder(link: str) -> bool:
    return any(marker in link for marker in PLACEHOLDER_MARKERS)


def check_links():
    broken = []
    md_files = list(iter_markdown_files())
    linked_targets = set()

    for md in md_files:
        text = open(md, encoding="utf-8", errors="ignore").read()
        # Commented-out links are template examples, not live references.
        text = HTML_COMMENT_RE.sub("", text)
        base = os.path.dirname(md)
        for match in LINK_RE.finditer(text):
            link = match.group(1).strip()
            if is_external(link) or is_placeholder(link):
                continue
            path = link.split("#")[0].split("?")[0]
            if not path:
                continue
            target = os.path.normpath(os.path.join(base, path))
            if path.endswith(".md"):
                linked_targets.add(target)
            if not os.path.exists(target):
                broken.append((os.path.relpath(md, ROOT), link))

    return broken, md_files, linked_targets


def main() -> int:
    show_orphans = "--orphans" in sys.argv
    broken, md_files, linked_targets = check_links()

    if broken:
        print(f"FAIL: {len(broken)} broken local link(s):\n")
        for src, link in sorted(set(broken)):
            print(f"  {src}  ->  {link}")
        print("\nFix the path, or if it is a fill-in placeholder, use the "
              "[YOUR_...] / PRD-XXX convention so it is recognized as intentional.")
    else:
        print(f"OK: all local Markdown links resolve ({len(md_files)} files checked).")

    if show_orphans:
        all_md = {os.path.normpath(p) for p in md_files}
        orphans = sorted(all_md - linked_targets)
        print(f"\n{len(orphans)} doc(s) not reached by any Markdown link "
              "(may be intentional -- many are referenced as inline `code`):")
        for o in orphans:
            print(f"  {os.path.relpath(o, ROOT)}")

    return 1 if broken else 0


if __name__ == "__main__":
    raise SystemExit(main())
