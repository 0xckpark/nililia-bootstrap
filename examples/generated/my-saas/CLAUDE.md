# my-saas

> Translation SaaS platform with Next.js + Supabase

## Stack
Next.js 16 + Supabase (Postgres + Auth + Storage) + TypeScript + Tailwind

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
| Web app (Next.js App Router) | apps/web/CLAUDE.md |
| Database & Edge Functions | supabase/CLAUDE.md |

## References
- LESSONS.md — accumulated learnings
- .claude/MEMORY.md — session state
