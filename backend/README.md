# PicoPet — Backend

Rust + axum + sqlx on SQLite.

## Targets

| Command        | What it does                                              |
|----------------|-----------------------------------------------------------|
| `make build`   | `fmt --check` + `clippy -D warnings` + `cargo build`.     |
| `make check`   | Lint only — formatting + clippy, no build.                |
| `make fmt`     | Apply `rustfmt` in place.                                 |
| `make lint`    | `clippy --all-targets -- -D warnings`.                    |
| `make test`    | Lint, then `cargo test --all-features`.                   |
| `make run`     | `cargo run`.                                              |
| `make clean`   | `cargo clean`.                                            |

The `build` target depends on `fmt-check` and `lint`. The build cannot
succeed if either fails — there is no bypass.

See `../AGENTS.md` for the compressed rule set, or `../CODING_STYLE.md`
for extended rationale.

## Implementation note

No source is committed yet. `src/` will be populated in milestone M1 (see
`../PLAN.md`). Until then, `make build` will fail with "no targets" — this
is expected.
