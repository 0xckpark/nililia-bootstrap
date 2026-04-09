# API Cost Optimization

> For direct Claude API calls (Edge Functions / server-side translation pipeline). Separate from Claude Code sessions.

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
| Quality review of translations | Opus | Judgment |
| Bulk subtitle translation | Sonnet | Cost |
| Language detection / classification | Haiku | Cheapest |

## my-saas integration points
- `supabase/functions/translate/` — Edge Function calls Anthropic API
  - Cache the glossary system prompt (project-wide style guide, terminology)
  - Use Batch API for >100 segments per request
- Track per-job cost in `translation_jobs.cost_usd` column for billing reconciliation
