# ⚡ nililia-bootstrap

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/0xckpark/nililia-bootstrap?style=social)](https://github.com/0xckpark/nililia-bootstrap/stargazers)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-D97757?logo=anthropic&logoColor=white)](https://claude.com/claude-code)
[![Cursor](https://img.shields.io/badge/Cursor-Compatible-000000?logo=cursor&logoColor=white)](https://cursor.com)

One command. Full project harness. Zero bloat.

```
/nililia-bootstrap
```

<!-- TODO: Replace with actual recording -->
<!-- ![demo](./assets/demo.gif) -->

Answer 6 questions. Get a complete, opinionated harness — workflow gates, quality guards, 4 agents, hooks, session memory, and multi-platform support.

---

## The Problem

Claude Code degrades over long sessions. It repeats mistakes, edits without reading, and quietly lowers quality after repeated rejections. Most harnesses respond by adding more — more agents, more skills, more rules — until the harness itself eats your context window.

**This one does the opposite.** 15 files. 4 agents. 3 rule files. Every rule exists because a real problem happened more than once.

---

## What You Get

```
your-project/
├── CLAUDE.md                     # 30-line navigation (token-minimal)
├── LESSONS.md                    # failure → lesson → system knowledge
├── .claude/
│   ├── settings.local.json       # permissions + subagent model routing
│   ├── MEMORY.md                 # session state pointers (not data)
│   ├── rules/
│   │   ├── global.md             # 5-stage workflow gate + execution strategy
│   │   ├── security.md           # secret · permission · commit guards
│   │   └── quality.md            # read-first · cache protect · honest output
│   ├── agents/
│   │   ├── reviewer.md           # multi-angle code review (read-only)
│   │   ├── planner.md            # planning + Agent Teams composition
│   │   ├── researcher.md         # investigation with anti-hallucination
│   │   └── test-engineer.md      # test writing + coverage reporting
│   ├── commands/
│   │   ├── clean-memory.md       # /clean-memory
│   │   └── session-handoff.md    # /session-handoff
│   └── hooks.json                # session-end + pre-edit automation
├── scripts/
│   ├── session-end.sh            # LESSONS/MEMORY update reminder
│   ├── pre-edit-check.sh         # read-before-write warning
│   └── verify-harness.sh         # integrity test
├── docs/
│   └── api-cost-optimization.md  # Batch API + Prompt Caching guide
│
│  [Cursor support]
├── .cursorrules
├── .cursor/rules/{global,quality}.mdc
│
│  [VS Code support]
├── .github/copilot-instructions.md
└── .vscode/settings.json
```

---

## Key Features

### 5-Stage Workflow Gate
Every non-trivial task follows: **Explore → Specify → Plan → Execute → Review**.  
User confirmation required at each transition. No skipping.

### Read-Before-Write
Minimum 3 related files read before any edit. Full-file overwrites forbidden. 3 consecutive edits on the same file → automatic stop and re-plan.

### Honest Output Guard
Prevents quality degradation after repeated rejections. The agent monitors its own output quality and stops to report when it detects decline. Accuracy always beats agreement.

### Cache Protection
Blocks the 3 actions that invalidate prompt cache (= 5x cost spike): model switching mid-session, dynamic values in CLAUDE.md, MCP changes after session start.

### Failure-to-Knowledge Loop
Rejected output → automatic LESSONS.md entry → recurring patterns promoted to rules/ → same mistake permanently blocked.

### 4 Specialized Agents
| Agent | Role | Can Edit? |
|-------|------|-----------|
| `reviewer` | Multi-angle code review | ❌ Read-only |
| `planner` | Task analysis + Agent Teams | ❌ Read-only |
| `researcher` | Package/API investigation | ❌ Read-only |
| `test-engineer` | Write & run tests | ✅ Test files only |

### Multi-Platform
| Platform | Files Generated |
|----------|----------------|
| Claude Code | `.claude/`, `CLAUDE.md`, hooks, scripts |
| Cursor | `.cursorrules`, `.cursor/rules/*.mdc` |
| VS Code | `.github/copilot-instructions.md`, `.vscode/settings.json` |

### Integrity Test
```bash
bash scripts/verify-harness.sh
```
Checks all expected files exist. Reports pass/fail count.

---

## Install

### Option A: Global (use anywhere)
```bash
mkdir -p ~/.claude/commands
cp nililia-bootstrap.md ~/.claude/commands/nililia-bootstrap.md
```

### Option B: Workspace (specific folder only)
```bash
mkdir -p .claude/commands
cp nililia-bootstrap.md .claude/commands/nililia-bootstrap.md
```

### Option C: Plugin Marketplace
```
/plugin marketplace add 0xckpark/nililia-bootstrap
/plugin install nililia-bootstrap
```

### Usage
```
claude
> /nililia-bootstrap
```

---

## Design Principles

| Principle | Implementation |
|-----------|---------------|
| CLAUDE.md is a map, not an encyclopedia | 30 lines max. Rules in rules/ |
| Memory stores pointers, not data | MEMORY.md: locations only, 150 chars/entry |
| Failures are assets | LESSONS.md → rules/ promotion path |
| Cache breaks cost 5x | No dynamic values, model switches, or MCP changes |
| Reading is cheaper than rewriting | Read:Edit 3:1 enforced |
| Narrow agents are accurate agents | reviewer=read-only, planner=no-write |

---

## Comparison

| | nililia-bootstrap | ECC | claude-bootstrap | Superpowers |
|---|---|---|---|---|
| Files | ~15 | 200+ | ~30 | ~40 |
| Setup time | 1 min | 10+ min | 5 min | 5 min |
| Token overhead | Minimal | High | Medium | Medium |
| Sycophancy guard | ✅ | ❌ | ❌ | ❌ |
| Cache protection | ✅ | ❌ | ❌ | ❌ |
| Read:Edit enforcement | ✅ | ❌ | ❌ | ❌ |
| Workflow gate | ✅ 5-stage | ❌ | ✅ TDD | ✅ Socratic |
| Failure→knowledge loop | ✅ | ✅ | ❌ | ✅ |
| Agent Teams support | ✅ | ✅ | ✅ | ❌ |
| Hooks | ✅ | ✅ | ✅ | ✅ |
| Agents | 4 | 38 | 6 | varies |
| Platforms | 3 | 6 | 1 | 1 |
| Integrity test | ✅ | ✅ | ❌ | ❌ |

---

## Philosophy

> More tools ≠ better output.  
> 156 skills you ignore < 3 rules you actually follow.

This harness is intentionally small. 15 files. 4 agents. 3 rule files.  
Every rule solves a problem that happened repeatedly in production.

The heaviest Claude Code harnesses add 50K+ tokens before you type a single character. This one adds ~3K.

---

## Marketplace Registration

To publish as a Claude Code plugin:

```bash
# 1. Create plugin manifest
mkdir -p .claude-plugin
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "nililia-bootstrap",
  "version": "1.0.0",
  "description": "Lightweight project harness with sycophancy guard, cache protection, and read-before-write enforcement",
  "commands": ["nililia-bootstrap.md"],
  "agents": ["reviewer.md", "planner.md", "researcher.md", "test-engineer.md"],
  "hooks": ["hooks.json"],
  "scripts": ["session-end.sh", "pre-edit-check.sh", "verify-harness.sh"]
}
EOF

# 2. Push to GitHub
git add -A && git commit -m "feat: initial release" && git push

# 3. Register on marketplace
# In Claude Code:
# /plugin marketplace add 0xckpark/nililia-bootstrap
```

---

## Contributing

Issues and PRs welcome. Keep it minimal — if a rule doesn't solve a recurring real-world problem, it doesn't belong here.

---

## License

MIT
