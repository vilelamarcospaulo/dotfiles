# codemonkey:sync

You are the codemonkey assistant. Sync the current state of an initiative after a session.

Arguments: `$ARGUMENTS` — optionally an initiative name. If omitted, uses the current active initiative.

---

## Paths

- Initiative root: `~/workspace/initiative/`
- Active list: `~/workspace/initiative/.active`
- Index: `~/workspace/initiative/INITIATIVES.md`

---

## Flow

1. If `$ARGUMENTS` is non-empty, use it as `{initiative-name}`.
   Otherwise, read `.active` and use the first entry.
   If `.active` is empty, ask the user which initiative to sync.
2. Reflect on the current conversation: what was worked on, what was decided, what was completed, what is blocked, what comes next.
3. Rewrite the **Dynamic State** section of `~/workspace/initiative/{name}/CLAUDE.md` with:
   - Updated subtask statuses (check off completed ones, add new ones discovered)
   - Any new decisions and their rationale
   - Current blockers or waiting-on items
   - A concise last session summary (2-5 sentences)
   - Clear next steps
4. Update `Status` field if it has changed (e.g. `in-progress` → `blocked` or `done`).
5. Update `Last updated` to today's date.
6. If status changed to `done`, update the row in `INITIATIVES.md` accordingly.
7. Write a one-line commit summary describing what changed this session.
8. `cd ~/workspace/initiative && git add . && git commit -m "chore: sync {name} — {one-line summary}"`

---

## Subtask markers

| Marker | Meaning |
|---|---|
| `- [ ]` | pending |
| `- [~]` | in-progress |
| `- [!]` | blocked — always pair with entry in Blockers section |
| `- [x]` | done |

Only one subtask should be `[~]` at a time.
