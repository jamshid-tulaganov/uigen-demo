---
description: Refactor a file for readability without changing behavior.
---

Refactor $ARGUMENTS for better readability and maintainability.

## Steps
1. Read the target file(s) completely
2. Identify issues: large functions, duplicated logic, unclear naming, missing types
3. Plan changes — list what you'll change and why (don't change behavior)
4. Apply refactoring:
   - Extract repeated logic into well-named functions
   - Improve TypeScript types (replace `any` with proper types)
   - Simplify complex conditionals
   - Split large components (>150 lines) into smaller ones
5. Run `npm run lint` to check for issues
6. Run related tests: `npx vitest run <related-test>`

## Rules
- Do NOT change external behavior — refactoring only
- Do NOT add features or "improvements"
- Keep changes focused on the specified file(s)
- Preserve all existing exports and interfaces
