#!/bin/bash
# UserPromptSubmit hook: inject git context before Claude reads the prompt

BRANCH=$(git branch --show-current 2>/dev/null)
STATUS=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

echo "Branch: $BRANCH | Uncommitted files: $STATUS"
