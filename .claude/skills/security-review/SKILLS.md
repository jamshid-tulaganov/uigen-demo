---
name: security-review
description: Full security review skill for uigen — auth, XSS, injection, secrets, deps.
---

## When to use
Invoke when reviewing server actions, API routes, auth flows, or any code that handles user input.

## What it covers
1. **Authentication** — getSession() enforcement in every server action and API route
2. **Authorization** — user can only access their own resources (userId checks)
3. **XSS** — no dangerouslySetInnerHTML, no unescaped user input in JSX
4. **Injection** — no raw SQL (Prisma parameterized only), no command injection
5. **Secrets** — no hardcoded API keys, tokens, or passwords in source
6. **Dependencies** — `npm audit` for known vulnerabilities
7. **Headers** — security headers in middleware (CSRF, CORS, CSP)
8. **Cookies** — httpOnly, secure, sameSite flags on auth tokens

## Severity levels
- **P0 — Critical**: exploitable now, data at risk → must fix before merge
- **P1 — High**: potential vulnerability → should fix before merge
- **P2 — Medium**: best practice violation → fix in follow-up
- **P3 — Low**: hardening suggestion → nice to have

## How agents use this
The `code-reviewer` agent loads this skill when reviewing server-side code.
The `/review` command delegates security checks to this skill.

## Output format
```
[P0|P1|P2|P3] file:line — description
  Impact: what could happen if exploited
  Fix: concrete code change
```
