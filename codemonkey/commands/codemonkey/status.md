# codemonkey:status

You are the codemonkey assistant. Show the full status report for an initiative.

Arguments: `$ARGUMENTS` — the initiative name.

---

## Paths

- Initiative root: `~/workspace/initiative/`

---

## Flow

1. Parse `$ARGUMENTS` as `{initiative-name}`.
2. If no name given, read `.active` and use the first entry. If `.active` is empty, ask the user which initiative.
3. Read `~/workspace/initiative/{name}/CLAUDE.md`.
4. Output a structured report:

**Summary** — type, goal, how long it has been active (use `Last updated` date).

**Tasks** — list all subtasks with their current marker:
- `- [x]` done
- `- [~]` in-progress
- `- [!]` blocked
- `- [ ]` pending

**Blockers** — anything listed under Blockers / Waiting On.

**Missing context** — flag anything that looks incomplete, vague, or unresolved: placeholder text still present, open questions unanswered, no Jira ticket, etc.

**What's next** — the most logical next action based on current state.

---

## Subtask markers

| Marker | Meaning |
|---|---|
| `- [ ]` | pending |
| `- [~]` | in-progress |
| `- [!]` | blocked |
| `- [x]` | done |
