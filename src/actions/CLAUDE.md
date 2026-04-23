# Server Actions Rules

## Every server action MUST:
1. Start with `"use server"` directive
2. Call `getSession()` and handle unauthorized case
3. Return `{ success: boolean; error?: string; data?: T }` pattern
4. Wrap database operations in try/catch
5. Use Prisma for all database access (never raw SQL)

## Naming
- One action per file: `src/actions/<verb>-<noun>.ts`
- Examples: `create-project.ts`, `get-projects.ts`, `update-project.ts`
- Action function name matches file: `createProject()`, `getProjects()`

## Validation
- Validate all input parameters before database operations
- Return user-friendly error messages (not Prisma error objects)
- Never expose internal IDs or stack traces in error responses
