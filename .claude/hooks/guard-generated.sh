#!/bin/bash
# PreToolUse hook: block edits to auto-generated files
# Exit code 2 = cancel the tool use

FILE="$CLAUDE_FILE_PATH"

if [[ "$FILE" =~ src/generated/prisma ]]; then
  echo "BLOCKED: src/generated/prisma/ is auto-generated."
  echo "Run 'npx prisma generate' instead of editing directly."
  exit 2
fi
