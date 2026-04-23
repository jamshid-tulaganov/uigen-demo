---
description: Scaffold a new React component with test.
---

Generate a new React component: $ARGUMENTS

## Steps
1. Determine the component type and where it belongs:
   - UI primitives → `src/components/ui/`
   - Feature components → `src/components/<feature>/`
   - Page components → `src/app/`
2. Check if similar components already exist (avoid duplication)
3. Create the component following project conventions:
   - "use client" directive if it uses hooks/interactivity
   - Props interface with TypeScript
   - Tailwind CSS for styling (shadcn/ui patterns)
   - Use `cn()` from `@/lib/utils` for conditional classes
4. Add exports if needed
5. Write a basic test in `__tests__/` directory
6. Verify it renders: import it somewhere and check in the browser

## Conventions
- Use Radix UI primitives via shadcn/ui when applicable
- Use lucide-react for icons
- Follow existing component patterns in the codebase
