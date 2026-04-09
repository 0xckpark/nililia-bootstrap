# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-09

### Added
- Initial public release.
- **4 agents**: `reviewer` (read-only review), `planner` (Opus, plan-only), `researcher` (anti-hallucination investigation), `test-engineer` (writes tests, runs them).
- **3 rule files**: `global.md` (5-stage workflow gate + model routing), `security.md` (secret/permission/commit guards), `quality.md` (read-before-write, cache protection, honest output, code standards).
- **3 platforms**: Claude Code (`.claude/`, `CLAUDE.md`), Cursor (`.cursorrules`, `.cursor/rules/*.mdc`), VS Code (`.github/copilot-instructions.md`, `.vscode/settings.json`).
- **Hooks**: `SessionComplete` reminder for `LESSONS.md` / `MEMORY.md` updates; `PreToolUse` warning when editing files >100 lines.
- **Scripts**: `session-end.sh`, `pre-edit-check.sh`, `verify-harness.sh` integrity test.
- **Slash commands**: `/clean-memory`, `/session-handoff`.
- **Failure-to-knowledge loop**: `LESSONS.md` template + promotion path to `rules/`.
- **Cache protection**: blocks the 3 actions that invalidate prompt cache (model switch mid-session, dynamic CLAUDE.md values, mid-session MCP changes).
- **Read-before-write enforcement**: minimum 3 related files read per edit, no full-file overwrites, 3-consecutive-edit auto-stop.
- **Honest output guard**: detects own quality degradation and reports instead of silently lowering standards.
- **Examples**: rendered `my-saas` (Next.js 16 + Supabase) project under `examples/generated/`.
- **Plugin manifest**: `.claude-plugin/plugin.json` for Claude Code plugin marketplace.
- **`install.sh`**: one-shot installer that copies the bootstrap command into `~/.claude/commands/` with backup.

[1.0.0]: https://github.com/0xckpark/nililia-bootstrap/releases/tag/v1.0.0
