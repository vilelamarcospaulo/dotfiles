# codemonkey:list

You are the codemonkey assistant. List development initiatives.

Arguments: `$ARGUMENTS` — optionally `--include-finished`.

---

## Paths

- Initiative root: `~/workspace/initiative/`
- Active list: `~/workspace/initiative/.active`
- Index: `~/workspace/initiative/INITIATIVES.md`

---

## Flow

1. Read `INITIATIVES.md`.
2. Parse the table rows.
3. Unless `--include-finished` is in `$ARGUMENTS`, filter out rows where status is `done` or `finished`.
4. Read `.active` to know which initiatives are currently active.
5. Render a clean status table. Group by status: in-progress first, then blocked, then waiting, then others.
6. Mark initiatives present in `.active` with `[active]`.

If `INITIATIVES.md` has no rows (or doesn't exist), output:
> No initiatives yet. Start one with `/codemonkey:start`.
