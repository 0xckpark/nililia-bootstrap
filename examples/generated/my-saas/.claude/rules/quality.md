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
- TypeScript strict mode (`any` forbidden)
- Functions ≤ 20 lines, nesting ≤ 3 levels
- Tests with every new feature (Vitest for unit, Playwright for E2E)
- Server Components by default; mark Client Components explicitly with "use client"
- Follow existing patterns — get approval before introducing new ones
