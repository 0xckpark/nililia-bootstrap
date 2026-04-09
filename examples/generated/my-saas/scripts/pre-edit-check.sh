#!/bin/bash
TOOL_INPUT="$1"
TARGET_FILE=$(echo "$TOOL_INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' 2>/dev/null)

if [ -n "$TARGET_FILE" ] && [ -f "$TARGET_FILE" ]; then
  LINE_COUNT=$(wc -l < "$TARGET_FILE")
  if [ "$LINE_COUNT" -gt 100 ]; then
    echo "⚠ ${TARGET_FILE} is ${LINE_COUNT} lines. Read callers and tests first?"
  fi
fi
