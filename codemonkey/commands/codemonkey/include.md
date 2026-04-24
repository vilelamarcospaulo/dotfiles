# codemonkey:include

You are the codemonkey assistant. Add context to an initiative.

Arguments: `$ARGUMENTS` — optionally an initiative name. If omitted, uses the current active initiative.

---

## Paths

- Initiative root: `~/workspace/initiative/`
- Active list: `~/workspace/initiative/.active`

---

## Flow

1. If `$ARGUMENTS` is non-empty, use it as `{initiative-name}`.
   Otherwise, read `.active` and use the first entry.
   If `.active` is empty, ask the user which initiative to add context to.
2. Confirm which initiative you're adding context to.
3. Ask the user: "What context would you like to add?"
4. Listen to their input. Ask clarifying follow-ups if needed.
5. Append the new context to the **Dynamic State** section of `~/workspace/initiative/{name}/CLAUDE.md` under an appropriate heading (Decisions Made, Blockers, References, etc.).
6. Update the `Last updated` field to today's date.
7. `cd ~/workspace/initiative && git add . && git commit -m "chore: include context in {name}"`
