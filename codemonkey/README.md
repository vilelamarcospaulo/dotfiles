# codemonkey

Initiative management system for Claude Code. Tracks development work across services with full context, state, and history.

## Install

```bash
unzip codemonkey.zip
cd codemonkey
chmod +x setup.sh
./setup.sh
```

This creates `~/workspace/initiative/` (git-initialized) and installs the `/codemonkey` skill into Claude Code.

## Usage

All commands are run inside Claude Code as `/codemonkey {subcommand}`.

| Command | Description |
|---|---|
| `/codemonkey start` | Start a new initiative. Claude will ask questions until context is complete. |
| `/codemonkey load {name}` | Load an existing initiative. Updates related services with active marker. |
| `/codemonkey list` | List all active initiatives with status. |
| `/codemonkey list --include-finished` | List all initiatives including finished ones. |
| `/codemonkey {name} status` | Full status of an initiative: summary, tasks, blockers, missing context. |
| `/codemonkey include` | Add more context to the currently loaded initiative. |
| `/codemonkey include {name}` | Add more context to a specific initiative. |
| `/codemonkey sync` | Claude updates the dynamic section of the current initiative after a work session. |
| `/codemonkey sync {name}` | Sync a specific initiative. |

## Initiative Types

| Type | Purpose | Output |
|---|---|---|
| DISCOVERY | Investigate viability of an idea | findings.md |
| EPIC | Large multi-sprint project | Coordination + child initiatives |
| FEATURE | End-to-end capability satisfying a PRD | Code across one or more services |
| FIX | Correct something broken | One PR, one service |
| TASK | Add something small and scoped | One PR, additive change |

## How it works

Each initiative lives in `~/workspace/initiative/{name}/` with a `CLAUDE.md` that has two parts:

- **Static** — type, goal, services, tickets, references. Filled at creation.
- **Dynamic** — tasks, blockers, decisions, last session summary. Managed by Claude via `sync`.

When you load an initiative, Claude patches the related services' `CLAUDE.md` files with an active marker so that context is visible when working inside those service folders.

All changes to the initiative folder are tracked in git. No remote is set up by default — add one if you want backup or sharing.
