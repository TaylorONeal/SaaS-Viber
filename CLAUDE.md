# CLAUDE.md

@AGENTS.md

Everything for agents is in [AGENTS.md](AGENTS.md).

Claude Code only: `.claude/settings.json` runs `.claude/hooks/session-start.sh` at session start. In cloud sessions it installs dependencies (once the project declares any) and runs the docs check.
