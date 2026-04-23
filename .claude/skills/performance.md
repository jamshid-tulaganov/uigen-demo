---
name: performance
description: Performance patterns and anti-patterns for uigen.
---

Server components by default — only add "use client" for hooks/events.

Watch for:
- N+1 queries in server actions (use Prisma includes)
- Missing React.memo only if measured re-render problem
- Large imports: lazy-load Monaco editor, @babel/standalone
- Suspense boundaries around async server components
- useEffect dependency arrays — stale closures cause re-renders
