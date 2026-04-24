# codemonkey:load

You are the codemonkey assistant. Load an existing initiative and give a briefing.

Arguments: `$ARGUMENTS` — the initiative name to load.

---

## Paths

- Initiative root: `~/workspace/initiative/`
- Active list: `~/workspace/initiative/.active`
- Workspace: `~/workspace/`

---

## Flow

1. Parse `$ARGUMENTS` as `{initiative-name}`.
2. Verify `~/workspace/initiative/{name}/` exists. If not, list available initiative folders and stop.
3. Read the initiative's `CLAUDE.md`.
4. Output a clear briefing:
   - Type, goal, status
   - Services involved
   - Open subtasks (pending and in-progress)
   - Blockers or waiting-on
   - What to pick up next
5. Add `{name}` to `.active` if not already present.
6. Patch each service's `CLAUDE.md` (see **Service Patching** below).
7. `cd ~/workspace/initiative && git add . && git commit -m "chore: load {name}"`

---

## Service Patching

1. Read the service's `CLAUDE.md` at `~/workspace/{service}/CLAUDE.md`.
2. Look for an existing `<!-- codemonkey:active -->` block.
3. If the block exists: add the initiative to the list inside it (if not already present).
4. If the block does not exist: append it at the very end of the file.

Block format:
```
<!-- codemonkey:active -->
- {initiative-name} ({TYPE}) — {Jira ticket or N/A}
<!-- /codemonkey:active -->
```

Multiple active initiatives on the same service each get their own line inside the block.

---

## Auto-Sync (active for the rest of this session)

After loading, keep the initiative state up to date automatically. Trigger a silent sync after any of these:

- A subtask is completed
- A subtask transitions to in-progress or blocked
- A significant decision is made
- A blocker is discovered or resolved
- A PR is opened or merged
- A new subtask is discovered

**Do this silently** — do not announce it. Just update and commit:
`cd ~/workspace/initiative && git add . && git commit -m "chore: sync {name} — {one-line description}"`

### Subtask markers

| Marker | Meaning |
|---|---|
| `- [ ]` | pending |
| `- [~]` | in-progress |
| `- [!]` | blocked — pair with entry in Blockers section |
| `- [x]` | done |

Only one subtask should be `[~]` at a time.
