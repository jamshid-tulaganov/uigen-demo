---
description: Quick bug diagnosis and fix for uigen.
---

Debug: $ARGUMENTS

1. Identify the error source (stack trace, component, route).
2. Read the relevant file — never guess.
3. Common uigen gotchas:
   - Native modules (bcrypt) → `serverExternalPackages` in next.config.ts
   - "Failed to fetch" → unhandled throw in server action
   - Preview blank → `/App.jsx` missing in virtual FS
4. Fix root cause. Run test to verify.
