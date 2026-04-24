# PicoPet — Project Plan

## Overview

PicoPet is a small web app for keeping a virtual pet. The user adopts a pet,
names it, and cares for it over time (feed, play, rest). The app is deliberately
tiny: a single pet, a handful of interactions, and a calm visual style.

This document is the high-level plan. It defines scope, architecture, and the
shape of the codebase — not concrete implementation. A detailed implementation
plan (per-phase tasks, tickets, milestones) will be derived from this document
in a later step.

## Goals

- **Small**: one user, one pet, a few interactions. No accounts, no social
  features, no gamification treadmill.
- **Simple**: idiomatic Vue on the frontend, idiomatic Rust on the backend.
  Minimal dependencies. Code should read like a tutorial.
- **Clean**: minimalistic UI drawn from the Catppuccin palette. Generous
  whitespace, restrained color, calm typography.
- **Honest**: state is persisted; the pet's condition evolves with real time
  (not just on user interaction).

## Non-Goals

- Multiplayer, social, accounts, auth.
- Real-time (WebSocket) updates. Polling is fine.
- Mobile-native packaging.
- Animations beyond subtle transitions.
- A server-side rendering pipeline.

## Architecture

Two components, clean split:

```
picopet/
├── frontend/        Vue 3 + Vite SPA
├── backend/         Rust HTTP API
├── catppuccin.md    Palette reference
├── CODING_STYLE.md  Language-agnostic code style rules
├── VISUAL_STYLE.md  Design system rules + palette application
└── PLAN.md          (this file)
```

The frontend is a static SPA. It talks to the backend over a small JSON HTTP
API. The backend owns all pet state and time-based logic.

### Frontend — Vue 3 + Vite

- **Framework**: Vue 3 with Composition API + `<script setup>`.
- **Build**: Vite.
- **Language**: TypeScript.
- **State**: Pinia (or a single composable — decide at implementation time
  based on actual complexity; default to a composable until you need more).
- **Routing**: vue-router only if >1 top-level view is needed. Start without.
- **HTTP**: `fetch` — no axios.
- **Styling**: plain CSS with custom properties sourced from the Catppuccin
  palette. No Tailwind, no CSS-in-JS. Scoped styles per component.
- **Linting/formatting**: ESLint (flat config) + Prettier, wired to run before
  the build script via npm script chaining.

### Backend — Rust

- **HTTP framework**: `axum`. Idiomatic, small, async-ready.
- **Async runtime**: `tokio`.
- **Storage**: SQLite via `sqlx` with compile-time query checking. Single file
  on disk — no migrations layer needed initially beyond a startup `CREATE TABLE
  IF NOT EXISTS`.
- **Serialization**: `serde` / `serde_json`.
- **Time**: `chrono` or `time` (pick one, use it everywhere).
- **Config**: env vars via `std::env`. No config framework.
- **Linting/formatting**: `rustfmt` + `clippy -D warnings`, wired to run before
  `cargo build` via a Makefile (or cargo alias).

### Data model (initial sketch, to be confirmed in implementation plan)

A `pet` row with:
- `id` (primary key)
- `name`
- `species` (enum: one or two choices — keep small)
- `born_at` (timestamp)
- `last_fed_at`, `last_played_at`, `last_slept_at`
- Derived state (hunger, mood, energy) is computed from those timestamps at
  read time — not stored. This keeps persistence simple and invariants
  trivially correct.

### API surface (initial sketch)

- `GET /api/pet` — returns the pet + derived state, or 404 if none.
- `POST /api/pet` — adopt a pet (name, species).
- `POST /api/pet/feed` — feed the pet.
- `POST /api/pet/play` — play with the pet.
- `POST /api/pet/sleep` — put the pet to sleep.
- `DELETE /api/pet` — release/retire.

All responses JSON. All errors: `{ "error": "message" }` with appropriate
status codes.

## Milestones

These are coarse — the implementation plan will subdivide them.

1. **M0 — Scaffolding** *(this repo's current state after initial setup)*
   Style guides, palette, build scripts, linters. No app code.

2. **M1 — Backend skeleton**
   Cargo project, axum "hello world" behind a `/api/health` route, SQLite
   connection, build+lint pipeline green.

3. **M2 — Frontend skeleton**
   Vite + Vue + TS project, empty single-page app styled with Catppuccin
   variables, build+lint pipeline green.

4. **M3 — Adopt + read**
   `POST /api/pet` and `GET /api/pet` wired end-to-end. User can adopt a pet
   and see it on the page.

5. **M4 — Interactions**
   Feed / play / sleep endpoints and UI. Derived state computed server-side
   from timestamps.

6. **M5 — Visual polish**
   Palette flavor picker (latte/frappé/macchiato/mocha), responsive layout,
   subtle transitions. Accessibility pass.

7. **M6 — Persistence + deploy notes**
   Document how to run locally, how to persist the SQLite file, how to serve
   the built frontend from the backend in production.

## Build & lint philosophy

- **Fail fast**: lint/format violations block the build. No commits that
  `cargo build` or `npm run build` would reject.
- **One command per component**: `cd frontend && npm run build` or
  `cd backend && make build` are the canonical entry points.
- **Root convenience**: a top-level `Makefile` fans out to both.

See `CODING_STYLE.md` for the rules the linters enforce, and the `frontend/`
and `backend/` scaffolding for the actual scripts.

## Out of scope for this plan

- Exact file layouts inside `frontend/src/` and `backend/src/` — decided at
  implementation time.
- Specific Pinia vs. composable decision — decided at implementation time.
- Deployment target — left open; plan assumes local dev + a single VPS as
  the likely target.
