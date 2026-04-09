# LESSONS — nililia-bootstrap

> Every failure becomes system knowledge. Same mistake never happens twice.

This project dogfoods itself — the harness template lives here, and we use it to maintain itself. Lessons recorded here are candidates for promotion into `.claude/rules/` or into the generated templates in `nililia-bootstrap.md`.

## Rules
- Record errors/failures immediately
- Update before every session end (session-end hook auto-reminds)
- Read this file at start of every new session
- Tag items applied to rules/ as [APPLIED]

---

### 2026-04-09 Initial repo bootstrap + marketplace setup
**Problem**: Six separate issues surfaced while taking the repo from empty folder to a working Claude Code marketplace plugin. Recorded together because they all belong to the same bootstrap session.

---

#### 1. `.gitignore` unanchored pattern swallowed example fixtures
**Problem**: `.claude/` pattern in root `.gitignore` also matched `examples/generated/my-saas/.claude/`, silently excluding 13 example files from the `c52128b` commit. Caught only because `git ls-files --others --exclude-standard` was run after staging to verify file count.
**Cause**: Git gitignore patterns without a leading `/` match at any depth. `.claude/` means "any directory named `.claude` anywhere in the tree", not "the `.claude` directory at repo root".
**Solution**: Change `.claude/` to `/.claude/` — the leading slash anchors the pattern to the repo root only. Nested `.claude/` dirs inside `examples/`, `fixtures/`, `test-data/` stay tracked.
**Lesson**: When gitignoring a tool-local directory (`.claude/`, `.cursor/`, `.vscode/`), always anchor with `/` unless you genuinely want every nested match excluded. The symptom is invisible on the author's machine — the files just never reach the remote.
**Applied**: N — promotion candidate. Good fit for `.claude/rules/quality.md` under a new "gitignore hygiene" section, or for the `## Post-Processing` step in `nililia-bootstrap.md` (Step 4).

---

#### 2. `gh` CLI not on PATH after winget install in same shell
**Problem**: After `winget install --id GitHub.cli` succeeded, `gh --version` still returned `command not found`. Multiple retries, same result.
**Cause**: Windows PATH env var is evaluated when a shell starts. winget updates the registry/system PATH but already-running shells don't pick up the change until restart.
**Solution**: Use the absolute path `/c/Program Files/GitHub CLI/gh.exe` for the rest of the session. New sessions get the updated PATH automatically.
**Lesson**: After installing a CLI via system package manager mid-session, never assume the new binary is immediately callable by name. Always verify with an absolute-path invocation first, and only switch to bare name once you've restarted the shell.
**Applied**: N — environment-specific, not worth a rule.

---

#### 3. `cmd.exe /c "winget ..."` produced empty output
**Problem**: Initial attempt to drive winget via `cmd.exe /c "winget install ..."` returned an empty stdout despite exit 0. No way to tell if it worked.
**Cause**: Git Bash on Windows + `cmd.exe /c` with an interactive/spinner-heavy command doesn't reliably capture the child process's stdout through the layered pipe.
**Solution**: Switched to `powershell.exe -NoProfile -Command "winget ..."`. PowerShell handles the output stream cleanly and returns the full install log.
**Lesson**: In Git Bash on Windows, prefer `powershell.exe -NoProfile -Command` over `cmd.exe /c` for any command whose output you need to inspect.
**Applied**: N — environment-specific workaround.

---

#### 4. Bash script CRLF warnings were a false alarm
**Problem**: `git add` on `install.sh` and `examples/.../scripts/*.sh` emitted `LF will be replaced by CRLF` warnings, raising concern that shell scripts would break on Linux/macOS (shebang corruption).
**Cause**: Default `core.autocrlf=true` on Git for Windows converts LF→CRLF in the working tree but stores LF in the repository blob. The warning describes the working-tree conversion, not the blob.
**Solution**: Verified with `git show :install.sh | xxd` — line endings in the staged blob were `0a` (LF) only, not `0d 0a`. Also set executable bit with `git update-index --chmod=+x install.sh`.
**Lesson**: CRLF warnings from git on Windows are informational about working-tree state. To verify what actually gets committed, inspect the staged blob directly (`git show :path | xxd`). Don't panic-configure `.gitattributes` without first confirming there's a real problem.
**Applied**: N — developer-awareness item, not a rule.

---

#### 5. `plugin.json` alone is not enough for `/plugin marketplace add`
**Problem**: `/plugin marketplace add 0xckpark/nililia-bootstrap` failed with `Marketplace file not found at .../.claude-plugin/marketplace.json`. A valid `plugin.json` does not double as a marketplace manifest.
**Cause**: Claude Code treats `marketplace.json` and `plugin.json` as two different schemas. The marketplace command looks specifically for `.claude-plugin/marketplace.json`, which is a catalog file listing one or more plugins (with each plugin's `source`, `name`, `version`, etc.). `plugin.json` describes a single plugin's internals.
**Solution**: Added `.claude-plugin/marketplace.json` with `owner`, `plugins[]`, and `source: "./"` pointing the single plugin entry at the same repo root. Schema verified against https://code.claude.com/docs/en/plugin-marketplaces.md before writing.
**Lesson**: A Claude Code plugin repo that wants to be `/plugin marketplace add`-able needs BOTH `plugin.json` (plugin manifest) AND `marketplace.json` (catalog), even for a single-plugin repo. Missing `marketplace.json` is the default state and fails silently on the publisher side — the error only shows up when someone tries to install.
**Applied**: N — should be added to `nililia-bootstrap.md` Step 3 as a new section 3-25 (`.claude-plugin/marketplace.json`) so generated projects that want to ship as plugins get it out of the box. Promotion candidate.

---

#### 6. `nililia-bootstrap.md` at repo root is not auto-discovered as a slash command
**Problem**: The plugin is installable via marketplace, but the `/nililia-bootstrap` command may not be exposed after `/plugin install` because `nililia-bootstrap.md` lives at the repo root, not at `commands/nililia-bootstrap.md`. UNVERIFIED — flagged for next-session check.
**Cause**: Claude Code plugin convention auto-discovers slash commands from `commands/` directory under the plugin root. A markdown file at repo root is not scanned.
**Solution**: Pending verification. If verified, fix = either (a) move `nililia-bootstrap.md` → `commands/nililia-bootstrap.md` (and update README install paths in 2 places), or (b) keep root file as canonical docs and add a copy at `commands/nililia-bootstrap.md`.
**Lesson**: (pending)
**Applied**: N — blocked on verification.

---

## Promotion Candidates

Lessons above tagged as promotion candidates, to be acted on in a future session:

1. **Lesson #1** → Add gitignore-hygiene rule to `.claude/rules/quality.md` AND to `nililia-bootstrap.md` Step 4 (Post-Processing).
2. **Lesson #5** → Add new section 3-25 to `nililia-bootstrap.md` for `.claude-plugin/marketplace.json`, so any generated project with plugin ambitions gets both manifests.
3. **Lesson #6** → After verification, document the `commands/` directory convention in `nililia-bootstrap.md` and in README install instructions.
