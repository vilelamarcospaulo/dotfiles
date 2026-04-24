# codemonkey:start

You are the codemonkey assistant. Start a new development initiative.

Arguments: `$ARGUMENTS` (ignored — this command takes no arguments, it runs an intake loop)

---

## Paths

- Initiative root: `~/workspace/initiative/`
- Active list: `~/workspace/initiative/.active`
- Index: `~/workspace/initiative/INITIATIVES.md`
- Templates: `~/workspace/initiative/templates/`
- Workspace: `~/workspace/`

---

## Intake Loop

Gather the following one group at a time. Do not front-load all questions at once.

1. **Type** — DISCOVERY, EPIC, FEATURE, FIX, or TASK. Explain each briefly if the user is unsure.
2. **Name** — short kebab-case identifier (e.g. `reversal-logic`, `accrual-fix`).
3. **Goal** — one or two sentences. What are we doing and why?
4. **Services involved** — which services in `~/workspace/` will be touched or investigated?
5. **References** — Jira ticket(s), Slack threads, PRDs, previous PRs, parent EPIC, discovery doc. Anything relevant.
6. **For FEATURE/EPIC**: acceptance criteria or definition of done.
7. **For FIX**: root cause (known or suspected) and reproduction steps.

After gathering, summarize everything and ask the user to confirm before proceeding. If anything is unclear or missing, ask a follow-up.

---

## Conflict Check (warn only, do not block)

1. Read `.active`.
2. For each active initiative, read its `CLAUDE.md` to get services.
3. If the new initiative shares a service with an active one AND both are code-changing types (FEATURE, FIX, TASK, EPIC), warn:
   > "Warning: `{active-initiative}` is already active on `{service}`. You can proceed, but be aware of the overlap."
4. DISCOVERY never conflicts. Always proceed for DISCOVERY.

---

## Scaffold

1. Create `~/workspace/initiative/{name}/`.
2. Copy the appropriate template from `~/workspace/initiative/templates/{TYPE}.md` to `~/workspace/initiative/{name}/CLAUDE.md`.
3. Fill in all static fields with the information gathered.
4. Add `{name}` to `.active` (append a new line).
5. Add a row to `INITIATIVES.md`:
   `| {name} | {TYPE} | in-progress | {services} | {today} |`
6. Patch each service's `CLAUDE.md` (see **Service Patching** below).
7. `cd ~/workspace/initiative && git add . && git commit -m "feat: initialize {name} ({TYPE})"`

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
