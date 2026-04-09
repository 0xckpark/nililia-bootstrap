# Contributing

Issues and PRs are welcome. This harness stays minimal on purpose — please read the rules below before opening a PR.

## Rules

1. **Solve real, recurring problems only.** If a rule, agent, or feature doesn't fix something that has happened more than once in actual project work, it doesn't belong here. Speculative additions get rejected.

2. **New rules and agents must declare the problem they solve.** Every PR that adds or modifies a file under `.claude/rules/` or `.claude/agents/` must include in the PR description:
   - **Problem**: what failure mode this addresses
   - **Evidence**: where it has happened before (link to issue, LESSONS.md entry, or session log)
   - **Why a rule, not docs**: why automation/enforcement is needed instead of just documentation

3. **Follow existing patterns.** Match the structure, tone, and length of existing files. Don't introduce new conventions without discussing in an issue first. Markdown files stay terse — no decorative emoji, no marketing prose.

4. **Keep it small.** A PR that doubles the file count needs an exceptional justification. The whole point of this project is that 15 files you actually follow beat 156 you ignore.

## Workflow

1. Open an issue first for anything beyond a typo fix — we'd rather discuss the problem before you write code.
2. Branch from `main`. One concern per PR.
3. Run `bash scripts/verify-harness.sh` (or the example's copy) before pushing.
4. Reference the issue in the commit message.
5. Be ready to defend the inclusion. "It might be useful" is not enough.

## What we won't merge

- More agents "just in case"
- Rules without an incident behind them
- Restructures of file layout without a clear migration story
- Anything that increases the harness's token footprint without proportional value
