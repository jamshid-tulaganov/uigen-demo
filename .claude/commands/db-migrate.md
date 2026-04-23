---
description: Create and apply a Prisma schema migration for uigen.
---

Create and apply a Prisma database migration: $ARGUMENTS

## Steps
1. Read current schema: `prisma/schema.prisma`
2. Apply the requested schema changes
3. Generate migration: `npx prisma migrate dev --name <descriptive-name>`
4. Regenerate Prisma client: `npx prisma generate`
5. Update any affected server actions in `src/actions/` or API routes in `src/app/api/`
6. Update TypeScript types if needed
7. Verify with `npx prisma studio` that the schema looks correct

## Rules
- Always use descriptive migration names (e.g., `add_user_avatar_field`)
- Never edit files in `src/generated/prisma/` — they are auto-generated
- Every server action/API that accesses new fields must check `getSession()`
- Back up the database before destructive migrations: `cp prisma/dev.db prisma/dev.db.bak`
