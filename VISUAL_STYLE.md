# PicoPet — Visual Style

Calm, minimalist. Restraint beats decoration; whitespace is a feature;
typography before illustration; one accent per view; palette-only color.
For a dense agent-facing summary, see `UI_STYLE.md`.

See `catppuccin.md` for raw palette tables.

## Flavors

Four: **latte** (light, paper), **frappé** (warm dark), **macchiato**
(cool dark), **mocha** (inky dark). All four ship. Default is `mocha`;
fall back to `latte` if no stored preference and `prefers-color-scheme:
light`. User choice persists in `localStorage`.

Switched via `<html data-flavor="...">`; each flavor is a block of
`:root[data-flavor="..."] { --ctp-*: …; }` definitions. One attribute
swap changes every token.

## Semantic tokens

Components never reference palette colors directly. They reference these
roles; only the role→palette mapping changes per flavor.

| Token                  | Role                                 | Palette entry |
|------------------------|--------------------------------------|---------------|
| `--ctp-bg`             | page background                      | `base`        |
| `--ctp-surface`        | card / panel                         | `mantle`      |
| `--ctp-surface-raised` | modal / elevated*                    | `crust`       |
| `--ctp-border`         | hairlines, dividers                  | `surface1`    |
| `--ctp-muted`          | muted bg, disabled controls          | `surface0`    |
| `--ctp-text`           | primary text                         | `text`        |
| `--ctp-text-muted`     | secondary text, labels               | `subtext1`    |
| `--ctp-text-subtle`    | captions, placeholders               | `subtext0`    |
| `--ctp-accent`         | primary accent (buttons, focus)      | `mauve`       |
| `--ctp-accent-alt`     | links, info                          | `blue`        |
| `--ctp-success`        | happy / full / OK                    | `green`       |
| `--ctp-warning`        | getting hungry / low stat            | `yellow`      |
| `--ctp-danger`         | hungry / error / destructive         | `red`         |

*Latte inverts: `raised`→`base`, `surface`→`mantle`. Rule: `bg` is page,
`surface` sits above it, `raised` sits above that.

### Accent usage

- **Mauve** (`--ctp-accent`) is the signature — primary buttons, focus
  rings, the pet's name, selected indicators. Mauve should be the only
  thing on a view the eye lands on first.
- Secondary roles: **Blue/Sapphire** info, **Green/Teal** happy,
  **Yellow/Peach** caution, **Red/Maroon** urgent/destructive,
  **Pink/Flamingo** play/affection.
- One accent per view. Promote one, demote the rest to `--ctp-text-muted`.

## Scales

**Type** (1.25 ratio): `sm` 0.875rem (labels), `md` 1rem (body),
`lg` 1.25rem (section head), `xl` 1.75rem (pet name / hero).
Weight 400 body, 500 section, 600 hero; never ≥700.
Line-height 1.5 body / 1.25 heading. Prose ≤ 60–70ch.

System stack, no webfonts:
`ui-sans-serif, system-ui, -apple-system, "Segoe UI", "Inter",
"Helvetica Neue", Arial, sans-serif`.

**Space** (base 4px): `--space-1..16` = `4, 8, 12, 16, 24, 32, 48, 64`.
No arbitrary px in components.

**Radius**: `sm` 6, `md` 10, `lg` 16. Cards → `md`.

**Borders**: always 1px `--ctp-border`. No double borders.

**Shadow**: one token `--shadow-1: 0 1px 2px rgba(0,0,0,.06)`. Don't stack.
Communicate depth with surface color, not shadow layers.

**Motion**: 150ms hover/focus, 200ms state, 300ms view.
Easing `cubic-bezier(.2, 0, 0, 1)`. Honor `prefers-reduced-motion: reduce`.
Micro-interactions only; no parallax, bounce, or decoration.

## Layout

Single column, max-width 48rem, centered, generous vertical padding.
Fluid via `clamp()` and `grid auto-fit minmax` — no media-query piles.
Touch targets ≥ 44×44px.

## Component intent

- **Primary button**: filled `--ctp-accent`, text `--ctp-bg`.
- **Secondary button**: 1px `--ctp-border`, transparent bg, text `--ctp-text`.
- **Destructive button**: filled `--ctp-danger`.
- **Card**: `--ctp-surface` + `--ctp-border` + `--radius-md` + `--space-6` pad.
- **Input**: card treatment; focus ring 2px `--ctp-accent` outside border.
- **Pet portrait**: centered, largest on page. Emoji or flat SVG — no
  shadow, no gradient.
- **Status bar**: `--space-1` tall, fill green→yellow→red by value.

Never three button colors in one view.

## Accessibility

- Color is never the only signal — pair with icon or label.
- Body text/bg meets WCAG AA (all four flavors pass).
- Every interactive element has a visible focus state.
- `aria-live` for user-triggered state changes ("Fed Whiskers").

## Don't

- Raw hex in components. All color via `var(--ctp-*)`.
- Shadow stacks for depth.
- Decorative animation.
- A second typeface.
- Large surfaces in accent colors — accents are for small, important regions.
- Gradients, patterns, illustrations without discussing first.
