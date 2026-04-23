# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

UIGen is an AI-powered React component generator with live preview. Users describe components in a chat interface, Claude generates code via tool calls, and the result renders in a live iframe preview. All generated files live in an in-memory virtual file system (no disk I/O).

## Commands

```bash
npm run setup          # First-time setup: install deps, generate Prisma client, run migrations
npm run dev            # Start dev server with Turbopack (http://localhost:3000)
npm run build          # Production build
npm run lint           # ESLint
npm test               # Run all tests (Vitest)
npx vitest run <path>  # Run a single test file
npx prisma studio      # Browse database
npm run db:reset       # Reset database (destructive)
```

Environment: set `ANTHROPIC_API_KEY` in `.env` for real AI generation. Without it, a `MockLanguageModel` returns static responses.

## Architecture

### Three-Panel Layout
The main UI (`src/app/main-content.tsx`) is a resizable three-panel layout: **Chat** (left) | **Code Editor** (center) | **Preview** (right).

### AI Generation Flow
1. User sends message via `ChatInterface` -> `ChatContext` calls `POST /api/chat`
2. API route (`src/app/api/chat/route.ts`) uses Vercel AI SDK's `streamText` with Claude
3. Claude has two tools: `str_replace_editor` (create/edit files) and `file_manager` (list/delete files)
4. Tool calls modify the virtual file system; results stream back to the client
5. `FileSystemContext` updates, triggering re-render of editor and preview

### Virtual File System
`src/lib/file-system.ts` implements `VirtualFileSystem` — a Map-based in-memory tree. All AI-generated files live here. It serializes to JSON for persistence in the `Project.data` column.

### Preview System
`PreviewFrame` compiles JSX to JS using `@babel/standalone` (see `src/lib/transform/jsx-transformer.ts`), then renders in a sandboxed iframe. The entrypoint is always `/App.jsx`.

### State Management
Two React Contexts drive the app:
- `ChatContext` (`src/lib/contexts/chat-context.tsx`) — messages, streaming state, AI interaction
- `FileSystemContext` (`src/lib/contexts/file-system-context.tsx`) — virtual files, selected file, file operations

### Auth & Persistence
JWT sessions in httpOnly cookies (`src/lib/auth.ts`). Server actions in `src/actions/` handle sign up/in/out and project CRUD. Prisma with SQLite stores users and projects. Anonymous users can generate components without signing up.

## Key Conventions

- Path alias: `@/*` maps to `./src/*`
- UI components: shadcn/ui in `src/components/ui/` (Radix primitives + Tailwind)
- Generated component rules (from the system prompt): root file must be `/App.jsx`, use Tailwind for styling, import non-library files with `@/` alias
- Tests use Vitest + React Testing Library with `vi.mock()` for external deps
- The dev server requires `node-compat.cjs` loaded via `NODE_OPTIONS`

## Patterns
 - Prisma client is generated to src/generated/prisma/ — never edit these files. Run `npx prisma generate` after schema changes.
 - every server section must check the getSession() in action/API

## Coding Rules

### TypeScript
- No `any` types in new code — use proper types or `unknown` with type guards
- All component props must have an interface (not inline)
- Server actions return `{ success: boolean; error?: string; data?: T }`

### React & Next.js
- Components that use hooks or browser APIs must have `"use client"` directive
- Server components are the default — only add `"use client"` when needed
- Use `next/navigation` (not `next/router`) for App Router
- Native Node modules (bcrypt, etc.) must be listed in `serverExternalPackages` in `next.config.ts`

### Styling
- Tailwind CSS only — no CSS modules, styled-components, or inline styles
- Use `cn()` from `@/lib/utils` for conditional classes
- Follow shadcn/ui patterns: Radix primitives + Tailwind + CVA

### Security
- Never expose `ANTHROPIC_API_KEY` or any secrets to the client
- All server actions and API routes must verify `getSession()` before database access
- Sanitize user input before rendering (XSS prevention)
- Use parameterized queries (Prisma handles this)

### File Organization
- Feature components: `src/components/<feature>/<Component>.tsx`
- Tests next to code: `src/components/<feature>/__tests__/<Component>.test.tsx`
- Server actions: `src/actions/<action-name>.ts` (one action per file)
- API routes: `src/app/api/<route>/route.ts`

### Git & PR Guidelines
- Branch naming: `feature/<name>`, `fix/<name>`, `refactor/<name>`
- Commits: imperative mood, max 72 chars, explain "why" not "what"
- PRs: link to issue, include test plan, keep under 400 lines changed

## Custom Commands

These slash commands are available in Claude Code:

| Command | Usage | Description |
|---------|-------|-------------|
| `/add-test` | `/add-test src/lib/auth.ts` | Generate Vitest tests for a file |
| `/fast-debug` | `/fast-debug "Failed to fetch on sign in"` | Quick bug diagnosis and fix |
| `/refactor` | `/refactor src/components/chat/MessageList.tsx` | Refactor for readability |
| `/gen-component` | `/gen-component UserAvatar` | Scaffold a new React component |
| `/db-migrate` | `/db-migrate "add avatar field to User"` | Create Prisma migration |
| `/review-code` | `/review-code feature/auth` | Review code changes |
| `/architect` | `/architect "add user avatars"` | Design implementation plan (no code) |
| `/reviewer` | `/reviewer feature/auth` | Thorough code review with checklist |
| `/tester` | `/tester src/lib/auth.ts` | QA agent — find bugs, write tests |
| `/security-audit` | `/security-audit all` | Security vulnerability scan |
| `/perf-check` | `/perf-check src/components/chat/` | Performance bottleneck analysis |
| `/explain` | `/explain "AI generation flow"` | Codebase explainer (in Uzbek) |

## Agent Roles

Three specialized agents are available as commands and run in GitLab CI on merge requests:

| Agent | Role | CI Job | Blocks MR? |
|-------|------|--------|------------|
| **Reviewer** | Code quality, security, React patterns | `claude-reviewer` | Yes (on CRITICAL) |
| **Tester** | Test coverage gaps, generate missing tests | `claude-tester` | No |
| **Docs** | Changelog, API docs, breaking changes | `claude-docs` | No |

## Built-in Skills

These are Claude Code's built-in skills (not custom commands):

| Skill | Trigger | What it does |
|-------|---------|-------------|
| `/init` | Setup | Generate CLAUDE.md from codebase analysis |
| `/review` | PR review | Review a pull request |
| `/security-review` | Security | Audit pending changes on current branch |
| `/simplify` | Refactor | Review changed code for quality |
| `/insights` | Analytics | Report on your Claude Code sessions |
| `/team-onboarding` | Onboarding | Create a guide from your usage patterns |

## Memory System

Claude Code remembers context across conversations via `~/.claude/projects/<hash>/memory/`:

| Type | Purpose | Example |
|------|---------|---------|
| `user` | Developer profile & preferences | "Responds in Uzbek, concise style" |
| `feedback` | Corrections & confirmed approaches | "Don't auto-push, ask first" |
| `project` | Ongoing work & decisions | "bcrypt needs serverExternalPackages" |
| `reference` | External resource pointers | "Prisma docs, shadcn/ui patterns" |

## Rules Hierarchy

Rules are loaded from multiple `CLAUDE.md` files (all are active simultaneously):

```
CLAUDE.md                    ← Team rules (committed to repo)
CLAUDE.local.md              ← Personal rules (gitignored)
src/components/CLAUDE.md     ← Component-specific rules
src/actions/CLAUDE.md        ← Server action rules
src/app/api/CLAUDE.md        ← API route rules
```

Sub-directory rules apply when Claude works on files in that directory.

## Hooks

Configured in `.claude/settings.json`:

| Hook | Trigger | Action |
|------|---------|--------|
| PreToolUse | Edit/Write | Blocks editing `src/generated/prisma/` |
| PostToolUse | Edit/Write | Runs TypeScript check on saved `.ts/.tsx` files |
| Notification | Any | Echoes Claude notifications to terminal |

