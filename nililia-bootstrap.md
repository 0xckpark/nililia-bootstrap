# /nililia-bootstrap — Project Harness Initializer

Sets up a battle-tested development harness for new or existing projects.
Generates file structure in the current directory. Never overwrites existing files — asks to merge.

---

## Step 1: Gather Info

Ask the user:

1. **Project name** (e.g. my-saas, billing-api)
2. **Tech stack** (e.g. Next.js + Supabase + CDK)
3. **One-line description** (e.g. "Translation SaaS platform infrastructure")
4. **Sub-directories** (e.g. apps/admin, apps/worker, api, infra — skip if none)
5. **Primary language** (typescript / python / go)
6. **Target platforms** (choose all that apply):
   - `claude-code` — Claude Code (default, always included)
   - `cursor` — Cursor IDE
   - `vscode` — VS Code + GitHub Copilot
   - `all` — all of the above

Proceed to Step 2 after answers.

---

## Step 2: Preview Structure

Show the user the structure below and ask **"Generate with this structure?"**
Add sub-directory CLAUDE.md slots if applicable.
Add platform-specific files based on Step 1 answer #6.

```
project-root/
├── CLAUDE.md                     ← 30-line navigation only
├── LESSONS.md                    ← failure → knowledge loop
├── .claude/
│   ├── settings.local.json       ← permissions + env vars
│   ├── MEMORY.md                 ← session state pointers
│   ├── rules/
│   │   ├── global.md             ← 5-stage workflow + model routing
│   │   ├── security.md           ← secrets · permissions · commit guard
│   │   └── quality.md            ← read-first · cache protect · honest output
│   ├── agents/
│   │   ├── reviewer.md           ← code review (read-only)
│   │   ├── planner.md            ← planning + agent teams
│   │   ├── researcher.md         ← investigation (no edits)
│   │   └── test-engineer.md      ← test writing + coverage
│   ├── commands/
│   │   ├── clean-memory.md       ← /clean-memory
│   │   └── session-handoff.md    ← /session-handoff
│   └── hooks.json                ← session-end + pre-edit automation
├── scripts/
│   ├── session-end.sh            ← LESSONS/MEMORY reminder
│   ├── pre-edit-check.sh         ← read-before-write warning
│   └── verify-harness.sh         ← harness integrity test
├── docs/
│   └── api-cost-optimization.md  ← Batch API + Prompt Caching guide
│
│  [if cursor selected]
├── .cursorrules
├── .cursor/rules/global.mdc
├── .cursor/rules/quality.mdc
│
│  [if vscode selected]
├── .github/copilot-instructions.md
├── .vscode/settings.json
│
└── [sub-directories]/
    └── CLAUDE.md                 ← sub-harness
```

Proceed to Step 3 after confirmation.

---

## Step 3: Generate Files

Generate all files below with user answers filled in.

---

### 3-1. CLAUDE.md (root — 30 lines max)

```markdown
# {project_name}

> {one_line_description}

## Stack
{tech_stack}

## Models
- **Opus**: architecture, core logic, review, analysis
- **Sonnet**: file generation, config, DDL, UI, formatting

## Rules
@.claude/rules/global.md
@.claude/rules/security.md
@.claude/rules/quality.md

## Sub-Harnesses
| Area | Path |
|------|------|
{rows per sub-directory}

## References
- LESSONS.md — accumulated learnings
- .claude/MEMORY.md — session state
```

---

### 3-2. LESSONS.md

```markdown
# LESSONS — {project_name}

> Every failure becomes system knowledge. Same mistake never happens twice.

## Rules
- Record errors/failures immediately
- Update before every session end (session-end hook auto-reminds)
- Read this file at start of every new session
- Tag items applied to rules/ as [APPLIED]

---

### [DATE] Session Title
**Problem**: 
**Cause**: 
**Solution**: 
**Lesson**: 
**Applied**: Added to rules/? Y/N
```

---

### 3-3. .claude/settings.local.json

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(npx *)",
      "Bash(node *)",
      "Bash(cat *)",
      "Bash(ls *)",
      "Bash(find *)",
      "Bash(grep *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git add *)",
      "Bash(git commit *)"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(git push --force)",
      "Bash(git reset --hard)"
    ]
  },
  "env": {
    "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-6"
  }
}
```

---

### 3-4. .claude/MEMORY.md

```markdown
# MEMORY — {project_name}

> Store pointers only. No data here. 150 chars max per entry.

## Current State
- Phase: 
- Last work: 
- Next up: 

## Key Locations
| Item | Path |
|------|------|

## Session Log
| Date | Summary | Handoff |
|------|---------|---------|
```

---

### 3-5. .claude/rules/global.md

```markdown
# Workflow + Execution Strategy

## 5-Stage Gate (mandatory)
For any new feature, design, or build request:

1. **Explore** — ask questions, understand requirements
2. **Specify** — write spec → user confirms: "Is this spec correct?"
3. **Plan** — write execution plan → user confirms: "Proceed with this plan?"
4. **Execute** — implement approved plan only
5. **Review** — check results + update LESSONS.md

### Exceptions
- Simple questions → answer directly
- Bug fixes → plan → execute only
- Strategy/analysis → explore → specify only

### Core Rules
- User confirmation required at every stage transition
- Never advance without explicit approval
- Long outputs: confirm section by section
- File creation / code execution: confirm before running

## Model Routing
- Opus (lead): source analysis, core logic, architecture, review
- Sonnet (subagent): file generation, config, DDL, UI
- Simple (1-3 files): lead inline
- Medium (5-10 files): delegate to subagent
- Complex (10+ files): Agent Teams parallel

## Harness Structure
- Root CLAUDE.md = 30-line navigation max
- Sub CLAUDE.md = directory-specific, auto-loaded on entry
- @ references = must-read files only. Don't @ everything — token waste
- Rules in rules/, knowledge in skills/, never dump everything in CLAUDE.md
```

---

### 3-6. .claude/rules/security.md

```markdown
# Security

## Forbidden
- No hardcoded secrets / API keys / tokens
- .env must be in .gitignore
- No git push --force
- No --no-verify commits

## Principles
- Always validate/escape user input
- Minimize IAM permissions
- Apply RLS on database
- Check git diff for secret exposure before commit
- Verify license on new dependencies
```

---

### 3-7. .claude/rules/quality.md

```markdown
# Quality

## Read Before Write
- Read at least 3 related files before editing (target, callers, tests)
- No full-file overwrites — targeted edits only
- 3 consecutive edits on same file → stop and re-plan

## Record Failures
- When output is rejected, record in LESSONS.md:
  - What was rejected
  - User feedback
  - Correct direction
- On repeated mistakes: read LESSONS.md first

## Honest Output
- Never lower quality to please the user
- Maintain same focus after repeated rejections
- If own output quality degrades, stop and report:
  "Quality degradation detected. Likely context length issue. Recommend /compact or /clear."
- Accuracy > agreement. Push back with evidence when user is wrong.

## Cache Protection
- No model switching mid-session
- No timestamps/dates in CLAUDE.md
- MCP server changes only before session start
- No system prompt structure changes mid-session

## Session Management
- /compact at milestones (never mid-implementation — variable name loss)
- After 3-4 compacts: summarize session then /clear
- Check /context at 60%, compact before 95% auto-trigger
- /clear when switching to unrelated tasks

## Code Standards
- Functions ≤ 20 lines, nesting ≤ 3 levels
- Tests with every new feature
- Follow existing patterns — get approval before introducing new ones
```

---

### 3-8. .claude/agents/reviewer.md

```markdown
---
name: reviewer
description: Multi-angle code review
model: sonnet
tools: [Read, Glob, Grep]
disallowedTools: [Write, Edit, Bash]
maxTurns: 30
---

# Code Review Agent

Review code changes and report issues. Never modify code.

## Criteria (≥80% confidence only)
1. **Security**: hardcoded secrets, injection, XSS, unvalidated input
2. **Quality**: duplication, complexity, missing error handling
3. **Consistency**: pattern deviation, naming violations
4. **Performance**: unnecessary loops, N+1 queries, memory leaks
5. **Tests**: missing tests, uncovered edge cases

## Output
- **File**: path
- **Lines**: range
- **Severity**: critical / warning / suggestion
- **Detail**: problem + fix direction

Consolidate similar issues. Security first. No praise.
```

---

### 3-9. .claude/agents/planner.md

```markdown
---
name: planner
description: Analyze tasks and build execution plans
model: opus
tools: [Read, Glob, Grep, WebSearch]
disallowedTools: [Write, Edit, Bash]
maxTurns: 20
---

# Planning Agent

Analyze requests, study codebase, produce plans. Never modify code.

## Procedure
1. Scope — affected files, dependencies, side effects
2. Research — how similar features were built
3. Plan — files, changes, order, risks
4. Team (if complex) — assign files per teammate, Phase 0 shared files

## Output
```
## Plan: {task}
### Scope: N files, {complexity}
### Execution Order
1. {file} — {change}
### Risks
- {risk} → {mitigation}
### Team (complex only)
- Phase 0: {shared}
- A: {files} / B: {files}
```

10+ files → always suggest team. Warn on API/interface changes.
```

---

### 3-10. .claude/agents/researcher.md

```markdown
---
name: researcher
description: Investigate packages, APIs, and patterns
model: sonnet
tools: [Read, Glob, Grep, WebSearch, WebFetch]
disallowedTools: [Write, Edit, Bash]
maxTurns: 25
---

# Research Agent

Investigate libraries, APIs, patterns. Structured reports only. Never modify code.

## Procedure
1. Clarify investigation scope
2. Search codebase for existing usage
3. Search web for best practices + version compatibility
4. Cross-reference with our stack version

## Output
```
## Research: {topic}
### Findings: {with sources}
### Recommendation: {primary + fallback}
### Risks: {compatibility / deprecation / license}
### References: {URLs or file paths}
```

## Anti-Hallucination
- Verify package exists on npm/pypi before recommending
- Always check version compatibility
- Say "unverified" when unsure — never fabricate
- Official docs over blog posts
```

---

### 3-11. .claude/agents/test-engineer.md

```markdown
---
name: test-engineer
description: Write and validate tests
model: sonnet
tools: [Read, Write, Edit, Bash, Glob, Grep]
disallowedTools: []
maxTurns: 40
---

# Test Engineer Agent

Write tests, run them, report coverage. May create/edit test files.

## Procedure
1. Read implementation, understand behavior
2. Identify cases: happy path, edge cases, error cases
3. Write tests following existing project patterns
4. Run and fix failures
5. Report coverage

## Output
```
## Tests: {feature}
### Files: {created/modified}
### Cases: ✅ pass / ❌ fail + reason
### Coverage: statements X%, branches X%, functions X%
```

## Rules
- Detect and follow existing test framework
- AAA: Arrange → Act → Assert
- One assertion per test when possible
- Never modify source to pass tests — report the issue
- Mock externals, never call real APIs
```

---

### 3-12. .claude/hooks.json

```json
{
  "hooks": {
    "SessionComplete": [
      {
        "type": "command",
        "command": "bash scripts/session-end.sh \"$SESSION_ID\"",
        "description": "Remind to update LESSONS/MEMORY on session end"
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "type": "command",
        "command": "bash scripts/pre-edit-check.sh \"$TOOL_INPUT\"",
        "description": "Warn before editing large files"
      }
    ]
  }
}
```

---

### 3-13. scripts/session-end.sh

```bash
#!/bin/bash
LESSONS_FILE="LESSONS.md"
MEMORY_FILE=".claude/MEMORY.md"

echo ""
echo "═══════════════════════════════════════"
echo "  Session End Checklist"
echo "═══════════════════════════════════════"

if [ -f "$LESSONS_FILE" ]; then
  LAST_MOD=$(stat -c %Y "$LESSONS_FILE" 2>/dev/null || stat -f %m "$LESSONS_FILE" 2>/dev/null)
  NOW=$(date +%s)
  DIFF=$(( (NOW - LAST_MOD) / 60 ))
  if [ "$DIFF" -gt 30 ]; then
    echo "⚠ LESSONS.md last modified ${DIFF}m ago. Record this session's learnings?"
  else
    echo "✓ LESSONS.md recently updated"
  fi
fi

[ -f "$MEMORY_FILE" ] && echo "⚠ Update MEMORY.md with current state"

echo ""
echo "  1. Record learnings → LESSONS.md"
echo "  2. Update state → MEMORY.md"
echo "  3. Handoff doc if needed → docs/"
echo "═══════════════════════════════════════"
```

---

### 3-14. scripts/pre-edit-check.sh

```bash
#!/bin/bash
TOOL_INPUT="$1"
TARGET_FILE=$(echo "$TOOL_INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' 2>/dev/null)

if [ -n "$TARGET_FILE" ] && [ -f "$TARGET_FILE" ]; then
  LINE_COUNT=$(wc -l < "$TARGET_FILE")
  if [ "$LINE_COUNT" -gt 100 ]; then
    echo "⚠ ${TARGET_FILE} is ${LINE_COUNT} lines. Read callers and tests first?"
  fi
fi
```

---

### 3-15. scripts/verify-harness.sh

```bash
#!/bin/bash
echo "═══════════════════════════════════════"
echo "  Harness Integrity Check"
echo "═══════════════════════════════════════"

PASS=0; FAIL=0

check() {
  if [ -e "$1" ]; then echo "  ✓ $1"; PASS=$((PASS+1))
  else echo "  ✗ $1 MISSING"; FAIL=$((FAIL+1)); fi
}

echo "[Core]"
check "CLAUDE.md"
check "LESSONS.md"

echo "[Config]"
check ".claude/settings.local.json"
check ".claude/MEMORY.md"
check ".claude/rules/global.md"
check ".claude/rules/security.md"
check ".claude/rules/quality.md"
check ".claude/hooks.json"

echo "[Agents]"
check ".claude/agents/reviewer.md"
check ".claude/agents/planner.md"
check ".claude/agents/researcher.md"
check ".claude/agents/test-engineer.md"

echo "[Commands]"
check ".claude/commands/clean-memory.md"
check ".claude/commands/session-handoff.md"

echo "[Scripts]"
check "scripts/session-end.sh"
check "scripts/pre-edit-check.sh"
check "scripts/verify-harness.sh"

echo "[Docs]"
check "docs/api-cost-optimization.md"

[ -f ".cursorrules" ] && { echo "[Cursor]"; check ".cursorrules"; check ".cursor/rules/global.mdc"; check ".cursor/rules/quality.mdc"; }
[ -f ".github/copilot-instructions.md" ] && { echo "[VS Code]"; check ".github/copilot-instructions.md"; check ".vscode/settings.json"; }

echo ""
echo "═══════════════════════════════════════"
echo "  ${PASS} passed, ${FAIL} failed"
echo "═══════════════════════════════════════"
[ "$FAIL" -gt 0 ] && echo "  Run /nililia-bootstrap to fix." && exit 1
```

---

### 3-16. .claude/commands/clean-memory.md

```markdown
# /clean-memory

Clean up MEMORY.md and LESSONS.md:

1. **MEMORY.md**: archive completed items, prune 30d+ logs, update state
2. **LESSONS.md**: tag applied items [APPLIED], merge duplicates, suggest rules/ for recurring patterns
3. Report summary.
```

---

### 3-17. .claude/commands/session-handoff.md

```markdown
# /session-handoff

Generate handoff doc for next session or another developer.

Include: completed, in-progress, next-up, changed files, warnings, build/test/run commands.

Save to docs/handoff-{date}.md and add to MEMORY.md session log.
```

---

### 3-18. docs/api-cost-optimization.md

```markdown
# API Cost Optimization

> For direct Claude API calls (Lambda/server). Separate from Claude Code sessions.

## Prompt Caching (-90% input)
- `cache_control` on repeated system prompts
- Read: 10% price / Write: 125% (first time) / TTL: 5min default
- Min 1024 tokens (Sonnet/Opus)

## Batch API (-50%)
- Non-realtime bulk. 24hr delivery. For: translation, classification, data processing.

## Combined: -95% input (Batch + Caching)

## Model Selection
| Task | Model | Why |
|------|-------|-----|
| Quality review | Opus | Judgment |
| Bulk execution | Sonnet | Cost |
| Classification | Haiku | Cheapest |
```

---

### 3-19. .cursorrules (if cursor selected)

```markdown
## Read Before Write
- Read 3+ related files before editing. No full-file overwrites. Stop after 3 consecutive same-file edits.

## Workflow
- New features: explore → specify → plan → execute → review. User confirmation at each transition.

## Honest Output
- Never lower quality after rejections. Accuracy > agreement. Report quality degradation.

## Code
- Functions ≤ 20 lines, nesting ≤ 3. Tests with new features. Follow existing patterns.

## Security
- No hardcoded secrets. .env in .gitignore. Validate user input.
```

---

### 3-20. .cursor/rules/global.mdc (if cursor selected)

```markdown
---
description: Workflow and execution strategy
globs: ["**/*"]
---
5-Stage Gate: Explore → Specify → Plan → Execute → Review.
User confirmation at every transition. 10+ files → suggest parallel tracks.
```

---

### 3-21. .cursor/rules/quality.mdc (if cursor selected)

```markdown
---
description: Quality guardrails
globs: ["**/*"]
---
Read 3+ files before edit. No full rewrites. Stop after 3 consecutive same-file edits.
Record rejected outputs in LESSONS.md. Compact at milestones, clear on task switch.
```

---

### 3-22. .github/copilot-instructions.md (if vscode selected)

```markdown
# Copilot Instructions — {project_name}

## Workflow
Non-trivial tasks: explore → specify → plan → execute → review.

## Code Quality
- Read related files before editing
- Functions ≤ 20 lines, nesting ≤ 3
- Follow existing patterns. Tests with new features. No full-file overwrites.

## Security
- Never hardcode secrets. Validate user input. Check diff before commit.

## References
- LESSONS.md, .claude/MEMORY.md, docs/
```

---

### 3-23. .vscode/settings.json (if vscode selected)

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": { "source.fixAll": "explicit" },
  "files.exclude": { "**/.git": true, "**/node_modules": true, "**/.env": true },
  "github.copilot.chat.codeGeneration.instructions": [
    { "file": ".github/copilot-instructions.md" }
  ]
}
```

---

### 3-24. Sub CLAUDE.md (per sub-directory)

```markdown
# {sub_directory} — {project_name}

> Directory-specific. Root CLAUDE.md + rules/ auto-inherited.

## Role
{area description}

## Local Rules
- {from user answers}

## Key Files
| File | Role |
|------|------|
```

---

## Step 4: Post-Processing

1. `chmod +x scripts/*.sh`
2. Verify `.gitignore` includes `.claude/MEMORY.md`, `.claude/settings.local.json`
3. Run `bash scripts/verify-harness.sh`
4. Report generated file list
5. Guide on what to fill (sub CLAUDE.md, etc.)
6. "Next: Start working and record state in MEMORY.md."
