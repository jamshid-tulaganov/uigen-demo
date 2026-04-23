---
description: Pre-ship checklist for uigen — lint, test, type-check, then commit.
---

1. Run `npm run lint` — fix any errors.
2. Run `npx tsc --noEmit` — fix type errors.
3. Run `npm test` — all tests must pass.
4. If all green, stage changes and create a commit.
5. Do NOT push — ask the user first.
