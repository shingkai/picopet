# PicoPet

A tiny, calm virtual-pet web app.

This repo currently contains planning documents, style guides, and build
scaffolding only — no application code. The application will be implemented
against the plan described in `PLAN.md`.

## Layout

```
picopet/
├── AGENTS.md         Dense agent-facing guide (read this first)
├── UI_STYLE.md       Dense visual reference
├── PLAN.md           Project plan — scope, architecture, milestones
├── CODING_STYLE.md   Extended code style rationale
├── VISUAL_STYLE.md   Extended design rationale
├── catppuccin.md     Raw Catppuccin palette (4 flavors)
├── Makefile          Root build runner
├── frontend/         Vue 3 + Vite scaffolding
└── backend/          Rust + axum scaffolding
```

Two-tier docs: `AGENTS.md` + `UI_STYLE.md` are the compressed
lookup-reference versions — load these into agent context. The
`CODING_STYLE.md` / `VISUAL_STYLE.md` / `PLAN.md` long forms hold the
rationale for human readers.

## Quick start

```sh
make build     # lint + build both components
make lint      # lint only, no build
```

Per-component builds:

```sh
cd frontend && npm install && npm run build
cd backend  && make build
```

## Rules of engagement

- Start from `AGENTS.md` and `UI_STYLE.md`.
- Palette tokens only — never a hand-typed hex.
- Lint gates builds; both `Makefile` targets and `package.json` scripts
  are wired this way. Don't bypass.
