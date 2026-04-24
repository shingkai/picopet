# PicoPet — Coding Style

Write the boring, idiomatic choice. Prefer the formatter's opinion to yours.
For a dense agent-facing summary, see `AGENTS.md`.

## Universal

- Simplest thing that works. No speculative abstractions, no flags for
  unwritten features, no dead code.
- Validate at system boundaries (HTTP handlers, forms, untrusted DB reads).
  Trust your own types inside.
- Errors propagate; don't swallow them. Typed errors over string errors.
  Handlers map internal errors to HTTP status at the edge.
- Comments answer **why**. Default: no comment. Delete done TODOs.
- Tests target behavior. Don't mock your own code.
- The formatter wins every argument.

## Frontend — Vue 3 + TypeScript

- Composition API, `<script setup lang="ts">`, one component per file
  (`PascalCase.vue`). Order: `<script setup>` → `<template>` → `<style scoped>`.
- Props via `defineProps<Interface>()`. Emits via `defineEmits<...>()`.
  Never unchecked `$emit`.
- Local state is `ref`/`reactive`. Reach for a composable (or Pinia) only
  when 2+ components share it. `computed` over `watch` when it'll do.
- `strict: true` TS. No `any` — `unknown` at boundaries, narrow. `type` for
  unions, `interface` for extendable shapes; don't mix in one file.
- Types live next to the code that produces them, not in a god-file.
- Imports: stdlib/Vue → third-party → `@/…` → relative, blank line between
  groups. Absolute for cross-dir, relative for same-dir.
- CSS scoped per component; global only in `src/styles/` (tokens, resets,
  type). All colors via `var(--ctp-*)` — no raw hex. See `UI_STYLE.md`.
- ESLint (flat) + Prettier + `vue-tsc`. `npm run build` runs all three first.

## Backend — Rust

- `cargo fmt` and `cargo clippy -- -D warnings` are canonical.
- `Result<T, E>` for anything fallible. `?` freely. No `panic!` in lib code;
  `expect` only at startup with a useful message. `unwrap()` requires a
  safety comment or it's a bug.
- `main.rs` is thin (config, build app, run). Logic lives in modules —
  sketch: `config`, `db`, `pet`, `api`.
- Wire types (`serde` request/response structs) live in `api`, separate from
  domain types. Renames in one shouldn't ripple through the other.
- Newtypes for IDs/units where confusion is possible (`PetId(i64)`), not for
  every primitive.
- `tokio` runtime, no mixing. Don't hold a `MutexGuard` across `.await` —
  prefer channels; use `tokio::sync::Mutex` only when you must.
- `sqlx::query!` / `query_as!` (compile-checked). SQL lives next to the call
  site, not in `.sql` files. Transactions for multi-row atomicity.

## Git

- Small, focused commits; each commit passes lint + build.
- Imperative subject. Body explains why.
- No WIP on `main`.

## When stuck

- Copy an existing pattern before inventing one.
- If a simple-sounding change grows past ~50 lines, pause and question the
  problem.
