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
