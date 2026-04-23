---
name: prisma-migrations
description: How to safely ship schema changes on uigen.
---

Always:
1. `prisma migrate dev --create-only` first
2. Review SQL before applying
3. Backfill in a separate step
4. Never drop a column same PR
5. Run `npx prisma generate` after migration
6. Update affected server actions in src/actions/
7. Every new field access must check getSession()
