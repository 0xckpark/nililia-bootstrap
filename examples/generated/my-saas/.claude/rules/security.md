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

## my-saas specific
- Supabase service_role key: server-only (never bundled into Next.js client code)
- All Postgres tables MUST have RLS enabled before merge
- Auth callbacks: validate `redirectTo` against allowlist (open redirect guard)
- File uploads: enforce mime-type + size limits at Storage policy level, not just client
