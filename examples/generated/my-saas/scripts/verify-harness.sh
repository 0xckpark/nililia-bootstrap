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

echo "[Sub-Harnesses]"
check "apps/web/CLAUDE.md"
check "supabase/CLAUDE.md"

echo ""
echo "═══════════════════════════════════════"
echo "  ${PASS} passed, ${FAIL} failed"
echo "═══════════════════════════════════════"
[ "$FAIL" -gt 0 ] && echo "  Run /nililia-bootstrap to fix." && exit 1
