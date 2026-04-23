---
name: security-checklist
description: Step-by-step security checklist for uigen code reviews.
---

# Security Review Checklist

## 1. Authentication
- [ ] Every `src/actions/*.ts` calls `getSession()` at the top
- [ ] Every `src/app/api/*/route.ts` calls `verifySession(request)`
- [ ] Unauthenticated requests return `{ success: false, error: "Unauthorized" }`
- [ ] JWT secret is not hardcoded — uses `process.env.JWT_SECRET`

## 2. Authorization
- [ ] Server actions filter by `session.userId` (no cross-user data access)
- [ ] Project CRUD operations check `userId` ownership
- [ ] No admin endpoints exposed without role check

## 3. Input Validation
- [ ] Email format validated before database write
- [ ] Password minimum length enforced (8+ chars)
- [ ] File paths sanitized (no `../` traversal in virtual FS)
- [ ] Message content length-limited before AI API call

## 4. XSS Prevention
- [ ] No `dangerouslySetInnerHTML` with user-controlled content
- [ ] React auto-escapes JSX — verify no raw HTML insertion
- [ ] Markdown renderer uses safe subset (no raw HTML pass-through)
- [ ] Preview iframe is sandboxed (`sandbox` attribute set)

## 5. Injection
- [ ] All database queries use Prisma (no raw SQL)
- [ ] No `eval()` or `Function()` with user input
- [ ] No shell command construction from user input
- [ ] Babel transform input is sanitized before compilation

## 6. Secrets Management
- [ ] `.env` is in `.gitignore`
- [ ] `ANTHROPIC_API_KEY` never sent to client (server-only)
- [ ] No secrets in `console.log()` or error messages
- [ ] JWT secret has sufficient entropy (not "development-secret-key" in prod)

## 7. Dependencies
- [ ] `npm audit` shows 0 critical/high vulnerabilities
- [ ] `bcrypt` (native module) listed in `serverExternalPackages`
- [ ] No deprecated packages with known CVEs

## 8. HTTP Security
- [ ] Auth cookies: `httpOnly: true, secure: true, sameSite: "lax"`
- [ ] No CORS misconfiguration (Next.js defaults are safe)
- [ ] Rate limiting on `/api/chat` (prevent API key abuse)
- [ ] Error responses don't leak stack traces or internal paths
