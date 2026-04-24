# codemonkey — System Overview

Initiative management system for development work. Lives at `~/workspace/initiative/`.

## Purpose

Give Claude full context about ongoing work across sessions. Each initiative is a folder with a `CLAUDE.md` that captures what we're building, why, which services are involved, and the current state of the work.

## Folder Structure

```
~/workspace/initiative/
  .active                    # list of active initiative names (one per line)
  INITIATIVES.md             # index: all initiatives with status at a glance
  templates/                 # CLAUDE.md templates per type
  {initiative-name}/
    CLAUDE.md                # static context + dynamic state (owned by Claude)
    findings.md              # (DISCOVERY only) output document
```

## Initiative Types

| Type | Purpose | Produces code? |
|---|---|---|
| DISCOVERY | Investigate viability, costs, feasibility | No — findings.md only |
| EPIC | Large project containing features | Coordinates child initiatives |
| FEATURE | End-to-end capability from a PRD | Yes — multiple PRs across services |
| FIX | Correct something broken | Yes — one PR |
| TASK | Add something small and scoped | Yes — one PR |

## CLAUDE.md Structure

Every initiative CLAUDE.md has two sections:

### Static (filled at creation, rarely changes)
- Type and goal
- Services involved with @-references to their CLAUDE.md files
- Jira ticket(s)
- Slack thread links
- Previous PRs referenced
- Parent initiative reference (for FEATURE inside EPIC)
- Discovery reference (if spawned from a DISCOVERY)

### Dynamic (managed by Claude via `codemonkey sync`)
- Current status: `in-progress` | `blocked` | `waiting` | `done`
- Subtasks with individual status
- Blockers and what we're waiting on
- Decisions made and rationale
- Last session summary
- What to pick up next

## Service CLAUDE.md Patching

When an initiative is loaded, Claude adds a managed block to each related service's CLAUDE.md:

```
<!-- codemonkey:active -->
- initiative-name (TYPE) — TICKET
<!-- /codemonkey:active -->
```

This block is updated (not removed) as initiatives change. Loading a new initiative appends to the block.

## Conflict Rules

Code-changing types (FEATURE, FIX, TASK, EPIC) on the same service at the same time = conflict.
DISCOVERY never conflicts.

- `start` → warns on conflict, proceeds anyway
- `load` → no conflict check, just loads

## INITIATIVES.md Format

```markdown
| Initiative | Type | Status | Services | Last Updated |
|---|---|---|---|---|
| reversal-logic | FEATURE | in-progress | credit-ledger | 2026-04-24 |
| accrual-investigation | DISCOVERY | done | credit-ledger, nazare | 2026-04-20 |
```

## Skill Commands

| Command | Behavior |
|---|---|
| `/codemonkey:start` | Intake loop — keep asking until type, goal, services, tickets, refs are solid. Warn on conflicts. Scaffold folder + CLAUDE.md. Update .active and INITIATIVES.md. Patch service CLAUDE.mds. Commit. |
| `/codemonkey:load {name}` | Read initiative CLAUDE.md. Give briefing. Add to .active. Patch service CLAUDE.mds. Commit. |
| `/codemonkey:list [--include-finished]` | Read INITIATIVES.md. Render status table. Hide finished by default. |
| `/codemonkey:status {name}` | Deep read of initiative CLAUDE.md. Output: summary, open tasks, blockers, missing context, what's next. |
| `/codemonkey:include [{name}]` | Prompt user for additional context. Append to dynamic section of current or named initiative. Commit. |
| `/codemonkey:sync [{name}]` | Reflect on current session. Update dynamic section: tasks, decisions, blockers, next steps. Update INITIATIVES.md status. Commit with message describing what changed. |

## Git Discipline

Every write operation commits to the initiative git repo with a meaningful message:
- `feat: initialize {name} ({type})`
- `chore: load {name}`
- `chore: sync {name} — {one-line summary}`
- `chore: include context in {name}`
