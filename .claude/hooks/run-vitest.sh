#!/bin/bash
# PostToolUse hook: run vitest on changed test-adjacent files
# Fires after every Edit|Write on .ts/.tsx files

FILE="$CLAUDE_FILE_PATH"

# Skip non-TS files
if [[ ! "$FILE" =~ \.(ts|tsx)$ ]]; then
  exit 0
fi

# Skip generated files
if [[ "$FILE" =~ src/generated/ ]]; then
  exit 0
fi

# Find matching test file
DIR=$(dirname "$FILE")
BASE=$(basename "$FILE" | sed 's/\.\(ts\|tsx\)$//')
TEST_FILE="$DIR/__tests__/$BASE.test.tsx"

if [ -f "$TEST_FILE" ]; then
  echo "Running tests for $BASE..."
  npx vitest run "$TEST_FILE" --reporter=dot 2>&1 | tail -5
fi
