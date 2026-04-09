# supabase — my-saas

> Directory-specific. Root CLAUDE.md + rules/ auto-inherited.

## Role
Postgres schema, migrations, RLS policies, Edge Functions, Storage buckets.

## Local Rules
- Every new table requires: (1) RLS enabled (2) at least one policy (3) migration test
- Migrations are forward-only — never edit a merged migration, write a new one
- Edge Function secrets via `supabase secrets set`, never committed
- Generated types: run `pnpm types:gen` after every migration; commit `apps/web/types/database.ts`
- Test migrations against `supabase db reset` locally before pushing to remote
- No `service_role` key inside Edge Function code — use the auth context from the request

## Key Files
| File | Role |
|------|------|
| migrations/ | Versioned schema changes (timestamp prefix) |
| functions/translate/index.ts | Translation pipeline Edge Function |
| seed.sql | Local development seed data |
| config.toml | Local CLI configuration |
| .gitignore | Excludes .branches/, .temp/ |
