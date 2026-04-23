---
name: test-coverage
description: Vitest + RTL testing patterns for uigen components.
---

Test stack: Vitest + React Testing Library + vi.mock()

Mocking patterns:
```
vi.mock("next/navigation", () => ({ useRouter: () => ({ push: vi.fn() }) }));
vi.mock("@/lib/prisma", () => ({ prisma: { user: { findUnique: vi.fn() } } }));
vi.mock("@/lib/auth", () => ({ getSession: vi.fn() }));
```

File layout: `src/components/<feature>/__tests__/<Name>.test.tsx`

Every test file needs: happy path + edge case + error state.
Run with: `npx vitest run <path>`
