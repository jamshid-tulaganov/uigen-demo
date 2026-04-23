#!/bin/bash
# PostToolUse hook: log every file edit for observability

FILE="$CLAUDE_FILE_PATH"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] edited: $FILE" >> .claude/edit-log.txt
