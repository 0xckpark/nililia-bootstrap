#!/bin/bash
LESSONS_FILE="LESSONS.md"
MEMORY_FILE=".claude/MEMORY.md"

echo ""
echo "═══════════════════════════════════════"
echo "  Session End Checklist"
echo "═══════════════════════════════════════"

if [ -f "$LESSONS_FILE" ]; then
  LAST_MOD=$(stat -c %Y "$LESSONS_FILE" 2>/dev/null || stat -f %m "$LESSONS_FILE" 2>/dev/null)
  NOW=$(date +%s)
  DIFF=$(( (NOW - LAST_MOD) / 60 ))
  if [ "$DIFF" -gt 30 ]; then
    echo "⚠ LESSONS.md last modified ${DIFF}m ago. Record this session's learnings?"
  else
    echo "✓ LESSONS.md recently updated"
  fi
fi

[ -f "$MEMORY_FILE" ] && echo "⚠ Update MEMORY.md with current state"

echo ""
echo "  1. Record learnings → LESSONS.md"
echo "  2. Update state → MEMORY.md"
echo "  3. Handoff doc if needed → docs/"
echo "═══════════════════════════════════════"
