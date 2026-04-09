#!/usr/bin/env bash
# nililia-bootstrap installer
# Copies nililia-bootstrap.md into ~/.claude/commands/ so /nililia-bootstrap is available globally.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="${SCRIPT_DIR}/nililia-bootstrap.md"
TARGET_DIR="${HOME}/.claude/commands"
TARGET_FILE="${TARGET_DIR}/nililia-bootstrap.md"

if [ ! -f "${SOURCE_FILE}" ]; then
  echo "✗ Source file not found: ${SOURCE_FILE}" >&2
  echo "  Run this script from the repository root." >&2
  exit 1
fi

mkdir -p "${TARGET_DIR}"

if [ -f "${TARGET_FILE}" ]; then
  TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
  BACKUP_FILE="${TARGET_FILE}.${TIMESTAMP}.bak"
  cp "${TARGET_FILE}" "${BACKUP_FILE}"
  echo "ℹ Existing file backed up: ${BACKUP_FILE}"
fi

cp "${SOURCE_FILE}" "${TARGET_FILE}"

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ nililia-bootstrap installed"
echo "═══════════════════════════════════════"
echo "  Location: ${TARGET_FILE}"
echo ""
echo "  Open Claude Code and run:"
echo "      /nililia-bootstrap"
echo "═══════════════════════════════════════"
