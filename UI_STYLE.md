# UI_STYLE.md — PicoPet

Calm, palette-only, one-accent UI. All color via `var(--ctp-*)` — never raw
hex. See `catppuccin.md` for palette entries. Longer rationale in
`VISUAL_STYLE.md`.

## Flavors

`latte` (light) · `frappé` (dark warm) · `macchiato` (dark cool) ·
`mocha` (dark inky). Default `mocha`; fall back to `latte` if no stored
pref and `prefers-color-scheme: light`. Persist in `localStorage`.
Switch via `<html data-flavor="...">`; each flavor is a
`:root[data-flavor="..."] { --ctp-*: …; }` block.

## Semantic tokens

| Token                  | Role                          | Palette    |
|------------------------|-------------------------------|------------|
| `--ctp-bg`             | page background               | `base`     |
| `--ctp-surface`        | card / panel                  | `mantle`   |
| `--ctp-surface-raised` | modal / elevated*             | `crust`    |
| `--ctp-border`         | hairlines, dividers           | `surface1` |
| `--ctp-muted`          | muted bg, disabled            | `surface0` |
| `--ctp-text`           | primary text                  | `text`     |
| `--ctp-text-muted`     | secondary text                | `subtext1` |
| `--ctp-text-subtle`    | captions, placeholders        | `subtext0` |
| `--ctp-accent`         | primary (buttons, focus)      | `mauve`    |
| `--ctp-accent-alt`     | links, info                   | `blue`     |
| `--ctp-success`        | happy / full / OK             | `green`    |
| `--ctp-warning`        | caution / low stat            | `yellow`   |
| `--ctp-danger`         | hungry / error / destructive  | `red`      |

*Latte inverts: `raised`→`base`, `surface`→`mantle`.

Accent roles: mauve=primary, pink=play, blue=rest/info, green=happy,
yellow=caution, red=urgent. **One accent per view.** Promote one; demote
others to `--ctp-text-muted`.

## Scales

**Type**: sm 0.875rem · md 1rem (body) · lg 1.25rem (section) ·
xl 1.75rem (hero). Weight 400/500/600 only. Line-height 1.5 body /
1.25 heading. Prose ≤ 60–70ch.

**Font**: system stack, no webfonts.
`ui-sans-serif, system-ui, -apple-system, "Segoe UI", "Inter",
"Helvetica Neue", Arial, sans-serif`

**Space** (`--space-N`, 4px base): 1=4 · 2=8 · 3=12 · 4=16 · 6=24 · 8=32 ·
12=48 · 16=64. No arbitrary px.

**Radius**: sm 6 · md 10 · lg 16. Cards → md.

**Border**: 1px `--ctp-border` only. No doubles.

**Shadow**: single token `--shadow-1: 0 1px 2px rgba(0,0,0,.06)`. Don't
stack. Use surface color for depth, not shadows.

**Motion**: 150ms hover, 200ms state, 300ms view.
Ease `cubic-bezier(.2,0,0,1)`. Honor `prefers-reduced-motion: reduce`.

## Layout

Single column, max 48rem, centered, generous vertical padding. Fluid via
`clamp()` and `grid auto-fit minmax`. Touch targets ≥ 44×44px.

## Components

| Component   | Spec                                                            |
|-------------|-----------------------------------------------------------------|
| Primary btn | filled `--ctp-accent`, text `--ctp-bg`                          |
| Secondary   | 1px `--ctp-border`, transparent bg, text `--ctp-text`           |
| Destructive | filled `--ctp-danger`                                           |
| Card        | `--ctp-surface` + `--ctp-border` + `--radius-md` + `--space-6`  |
| Input       | card treatment; focus ring 2px `--ctp-accent` outside border    |
| Pet portrait| centered, largest on page; emoji or flat SVG; no shadow/gradient|
| Status bar  | `--space-1` tall; fill green→yellow→red by value                |

Never 3 button colors in one view.

## A11y

- Color never the only signal — pair with icon or label.
- All four flavors pass WCAG AA body text/bg.
- Every interactive element has a visible focus state.
- `aria-live` for user-triggered state changes.

## Hard no

- Raw hex in components.
- Shadow stacks.
- Decorative animation.
- Second typeface.
- Large surfaces in accent colors.
- Gradients, patterns, illustrations without discussion.
