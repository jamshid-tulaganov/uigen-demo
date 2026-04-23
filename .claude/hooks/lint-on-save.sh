#!/bin/bash
# PostToolUse hook: lint changed files

FILE="$CLAUDE_FILE_PATH"

if [[ ! "$FILE" =~ \.(ts|tsx|js|jsx)$ ]]; then
  exit 0
fi

# Skip generated files
if [[ "$FILE" =~ src/generated/ ]]; then
  exit 0
fi

npx next lint --file "$FILE" 2>&1 | tail -3
