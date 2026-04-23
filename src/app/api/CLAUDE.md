# API Routes Rules

## Every API route MUST:
1. Verify authentication via `verifySession(request)` from `@/lib/auth`
2. Return proper HTTP status codes (200, 400, 401, 500)
3. Return JSON responses: `NextResponse.json({ ... })`
4. Handle errors gracefully with try/catch

## Streaming Routes (like /api/chat)
- Use Vercel AI SDK's `streamText` for AI responses
- Always set `maxTokens` to prevent runaway costs
- Tool definitions go in `src/lib/ai/tools.ts` (not inline in the route)

## Security
- Never log request bodies that might contain sensitive data
- Rate limiting should be handled at the middleware level
- CORS is handled by Next.js — don't add custom CORS headers
