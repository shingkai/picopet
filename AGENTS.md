# AGENTS.md — PicoPet

Small virtual-pet web app. Vue 3 + Vite frontend, Rust (axum + sqlx/SQLite)
backend. Read this file first. For design, read `UI_STYLE.md`. For deeper
rationale, `CODING_STYLE.md` / `VISUAL_STYLE.md` / `PLAN.md`.

## Layout

```
frontend/       Vue 3 + Vite + TS SPA
backend/        Rust axum HTTP API
PLAN.md         Architecture, API sketch, milestones
UI_STYLE.md     Compressed visual reference
CODING_STYLE.md Extended coding rules
VISUAL_STYLE.md Extended design rules
catppuccin.md   Palette tables (4 flavors)
```

## Commands

| Do                | Run                                  |
|-------------------|--------------------------------------|
| Build everything  | `make build`                         |
| Lint everything   | `make lint`                          |
| Frontend build    | `cd frontend && npm run build`       |
| Frontend lint     | `cd frontend && npm run lint`        |
| Frontend dev      | `cd frontend && npm run dev`         |
| Backend build     | `cd backend  && make build`          |
| Backend lint      | `cd backend  && make check`          |
| Backend run       | `cd backend  && make run`            |

`build` = lint + typecheck/fmt-check + compile. Lint failures block builds.
Do not bypass.

## Stack

| Part     | Lang | Framework          | Linter/formatter                  |
|----------|------|--------------------|-----------------------------------|
| Frontend | TS   | Vue 3 + Vite       | ESLint flat + Prettier + vue-tsc  |
| Backend  | Rust | axum + tokio + sqlx| rustfmt + clippy -D warnings      |

State: SQLite file. Serialization: serde. HTTP client: `fetch`. No axios.

## Frontend rules

- `<script setup lang="ts">` + Composition API. One component / file,
  `PascalCase.vue`. Order: script → template → style scoped.
- `defineProps<I>()`, `defineEmits<…>()`. Never bare `$emit`.
- Local state: `ref`/`reactive`. Shared: composable; Pinia only if needed.
- `computed` over `watch` when it'll do.
- `strict: true` TS. No `any` — `unknown` + narrow at boundaries.
- Imports: stdlib/Vue → third-party → `@/…` → relative, blank line between.
- CSS scoped per component. Global only in `src/styles/`. Color **only**
  via `var(--ctp-*)` — see UI_STYLE.md. No raw hex. No Tailwind.

## Backend rules

- `Result<T, E>` everywhere fallible. `?` freely.
- No `panic!` in lib code; `expect` only at startup with a message.
  `unwrap()` requires a safety comment.
- `main.rs` is thin — config, build app, run. Modules: `config`, `db`,
  `pet`, `api`.
- Wire types (`serde`) live in `api`, separate from domain types.
- `sqlx::query!` / `query_as!` (compile-checked). SQL inline, not in files.
- `tokio` only. Never hold `MutexGuard` across `.await`; prefer channels.
- Newtypes for confusable IDs (`PetId(i64)`), not every primitive.

## Universal

- Validate at boundaries (HTTP, forms). Trust your types inside.
- Errors propagate; typed over string; handlers map to HTTP at edge.
- Comments answer *why*. Default: no comment. No TODOs left over.
- No dead code, no speculative branches, no flags for unwritten features.
- Formatter wins. Don't hand-format.
- Copy existing patterns before inventing new ones.
- If a "simple" change grows past ~50 lines, question the problem.

## Git

- Small commits; each passes lint + build.
- Imperative subject. No WIP on `main`.

## Do not

- Write raw hex colors.
- Add dependencies not already listed in `package.json` / `Cargo.toml`
  without clearing scope first.
- Bypass lint/format gates.
- Mix `type` and `interface` in one TS file.
- Write code in any file outside `frontend/src/` or `backend/src/` unless
  changing scaffolding.
