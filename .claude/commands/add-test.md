---
description: Write Vitest tests for the specified file.
---

Write tests for $ARGUMENTS.

1. Read the target file and existing tests in `__tests__/`.
2. Create `__tests__/<Name>.test.tsx` with:
   - Happy path, edge cases, error states
   - `vi.mock()` for next/navigation, @/lib/prisma, @/lib/auth
3. Run `npx vitest run <test-path>` and fix failures.
