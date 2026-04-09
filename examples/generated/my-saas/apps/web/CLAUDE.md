# apps/web — my-saas

> Directory-specific. Root CLAUDE.md + rules/ auto-inherited.

## Role
Next.js 16 App Router frontend. Server Components by default. Client Components only when needed (forms, interactivity, browser APIs).

## Local Rules
- All data fetching in Server Components or Route Handlers — never expose Supabase service_role to the browser
- Use `@/lib/supabase/server` for SSR/RSC, `@/lib/supabase/client` for "use client" components
- Tailwind only — no CSS modules, no CSS-in-JS
- Server Actions for mutations; revalidate with `revalidatePath` / `revalidateTag`
- No dynamic imports of heavy libs in the root layout (keep First Load JS small)

## Key Files
| File | Role |
|------|------|
| app/layout.tsx | Root layout, fonts, providers |
| app/(marketing)/page.tsx | Public landing |
| app/(app)/dashboard/page.tsx | Authed dashboard |
| lib/supabase/server.ts | SSR Supabase client (cookies-based) |
| lib/supabase/client.ts | Browser Supabase client |
| middleware.ts | Auth session refresh |
