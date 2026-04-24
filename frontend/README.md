# PicoPet — Frontend

Vue 3 + Vite + TypeScript.

## Scripts

| Command             | What it does                                           |
|---------------------|--------------------------------------------------------|
| `npm run dev`       | Start the Vite dev server.                             |
| `npm run lint`      | Run ESLint + Prettier check. Fails on any violation.   |
| `npm run lint:fix`  | Auto-fix what's fixable.                               |
| `npm run typecheck` | Run `vue-tsc` without emitting.                        |
| `npm run build`     | `lint` + `typecheck` + `vite build`. All must pass.    |
| `npm run preview`   | Serve the built bundle locally.                        |

The `prebuild` hook guarantees the build fails if linting or typechecking
fails. There is no way to ship a build that skips the checks.

See `../AGENTS.md` and `../UI_STYLE.md` for the compressed style reference,
or `../CODING_STYLE.md` and `../VISUAL_STYLE.md` for extended rationale.
