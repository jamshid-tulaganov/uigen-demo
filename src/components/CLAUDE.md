# Components Rules

## Structure
- Every component gets its own file: `<ComponentName>.tsx`
- Feature folders group related components: `chat/`, `editor/`, `preview/`, `auth/`
- Shared UI primitives live in `ui/` (shadcn/ui managed — don't manually edit)
- Tests go in `__tests__/<ComponentName>.test.tsx` next to the component

## Component Conventions
- Always define a `Props` interface: `interface ComponentNameProps { ... }`
- Use `"use client"` only when the component uses hooks, event handlers, or browser APIs
- Export components as named exports (no default exports)
- Use `cn()` for merging Tailwind classes conditionally

## Do NOT
- Create wrapper components that just pass props through
- Add `React.memo` unless you've measured a re-render problem
- Import from `@/components/ui/` inside `ui/` itself (circular dep risk)
