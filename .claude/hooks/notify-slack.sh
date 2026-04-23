#!/bin/bash
# Stop hook: notify when Claude finishes a task
# In CI: post to Slack webhook. Locally: terminal notification.

MESSAGE="Claude Code finished on branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"

if [ -n "$SLACK_WEBHOOK_URL" ]; then
  # CI mode: post to Slack
  curl -s -X POST "$SLACK_WEBHOOK_URL" \
    -H 'Content-Type: application/json' \
    -d "{\"text\": \"$MESSAGE\"}" > /dev/null 2>&1
else
  # Local mode: terminal notification
  echo "$MESSAGE"
  # macOS notification (optional)
  which osascript > /dev/null 2>&1 && \
    osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\""
fi
