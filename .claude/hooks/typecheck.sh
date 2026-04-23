#!/bin/bash
# PostToolUse hook: type-check after .ts/.tsx edits

FILE="$CLAUDE_FILE_PATH"

# Only check TypeScript files
if [[ ! "$FILE" =~ \.(ts|tsx)$ ]]; then
  exit 0
fi

# Skip generated files
if [[ "$FILE" =~ src/generated/ ]] || [[ "$FILE" =~ node_modules/ ]]; then
  exit 0
fi

echo "Type-checking $FILE..."
npx tsc --noEmit --pretty 2>&1 | head -10
