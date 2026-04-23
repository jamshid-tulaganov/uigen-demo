---
name: security-analysis
description: Security checklist for uigen server actions and API routes.
---

Always check:
1. getSession() called before any DB operation
2. No raw SQL — use Prisma parameterized queries
3. No dangerouslySetInnerHTML with user input
4. ANTHROPIC_API_KEY never exposed to client
5. httpOnly cookies for auth tokens
6. Input validation before database writes
7. No secrets in git (check .env is in .gitignore)
