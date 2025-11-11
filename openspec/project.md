# Project Context

## Purpose
Personal dotfiles repository for macOS development environment configuration. This project maintains a consistent, version-controlled setup across machines with automated installation and symlink-based configuration management.

## Tech Stack

### Core Tools
- **Neovim** - Primary text editor configured with Lua
- **WezTerm** - Terminal emulator with custom keybindings and themes
- **AeroSpace** - Tiling window manager for macOS
- **Atuin** - Shell history sync and search
- **Homebrew** - Package manager for macOS
- **Git** - Version control with custom aliases

### Development Languages (via LSP)
- **Clojure** - Primary functional programming language (clojure_lsp)
- **Go** - Systems programming (gopls)
- **Python** - Scripting and automation (pylsp with black, isort)
- **TypeScript/JavaScript** - Web development (ts_ls)
- **Lua** - Neovim configuration (lua_ls)

### Neovim Plugin Stack
- **Blink.cmp** - Completion engine
- **Conjure** - Clojure REPL integration
- **Treesitter** - Syntax highlighting and parsing
- **LSP Config** - Language server protocol integration
- **Neogit** - Git interface
- **Neotest** - Test runner integration
- **FZF** - Fuzzy finding
- **Paredit** - Structural editing for Lisp languages
- **Lualine** - Status line
- **Mini.nvim** - Various small utilities
- **Noice** - Enhanced UI components

## Project Conventions

### Code Style
- **Indentation**: 2 spaces (Lua, Clojure, general configs)
- **Line Length**: 80 characters max (colorcolumn set)
- **Clipboard**: Unified with system clipboard (`unnamedplus`)
- **Spell Check**: Enabled with US English dictionary
- **File Organization**: Modular Lua configuration with `core/` and `plugins/` separation

### Lua Configuration Structure
```
config/nvim/lua/
├── core/           # Core Neovim configuration
│   ├── remap.lua   # Key remappings
│   ├── lazy.lua    # Plugin manager setup
│   ├── lsp/        # LSP-specific configuration
│   └── clojure.lua # Clojure-specific settings
└── plugins/        # Individual plugin configurations
```

### Architecture Patterns
- **Symlink-based deployment**: `init.sh` creates symlinks from `config/` to `~/.config/`
- **Modular configuration**: Each tool has its own directory under `config/`
- **Plugin-per-file**: Each Neovim plugin configured in separate file
- **Lazy loading**: Plugins managed with lazy.nvim for fast startup
- **LSP-first**: Language support via Language Server Protocol
- **Spec-driven development**: Using OpenSpec for change management

### Neovim Editor Settings
- Line numbers enabled (absolute, not relative)
- Sign column always visible (2 columns)
- Cursor line highlighting
- Smart indentation
- Treesitter-based folding (starting at level 20)
- No swap files, persistent undo in `~/.vim/undodir`
- Scroll offset of 8 lines

### Testing Strategy
- **Neotest** integration for running tests from editor
- LSP-based linting and diagnostics
- Language-specific tools:
  - Python: black (formatter), isort (import sorter)
  - Go: staticcheck, unused params analysis
  - Clojure: clojure-lsp diagnostics

### Git Workflow
- **Branch Strategy**: main/master as primary branches
- **Custom Aliases**:
  - `git sync`: Auto-detect and pull from main/master
  - `git clear`: Delete all branches except main/master
- **OpenSpec Integration**: Spec-driven development workflow
  - Proposals in `openspec/changes/`
  - Specifications in `openspec/specs/`
  - Archive completed changes with timestamps

## Domain Context

### Clojure Development
- Custom keyword handling: `-`, `/`, and `.` removed from `iskeyword`
- Conjure for REPL-driven development
- Paredit for structural editing
- Rainbow parentheses for visual clarity
- Project detection via: `project.clj`, `deps.edn`, `build.boot`, `shadow-cljs.edn`, `bb.edn`

### Terminal Environment
- **WezTerm Keybindings**:
  - `Ctrl+Cmd+F`: Toggle fullscreen
  - `Cmd+K`: Clear scrollback and viewport
  - `Cmd+Right/Left`: End/Home navigation
  - `Alt+Right/Left`: Word-based navigation
  - `Cmd+Backspace`: Clear entire line
- **AeroSpace Window Management**:
  - Accordion layout mode with 30px padding
  - Auto-orientation based on monitor aspect ratio
  - 5px gaps (inner and outer)
  - Keyboard-driven tiling workflow

## Important Constraints

### Platform
- **macOS only**: Uses Homebrew, AeroSpace (macOS-specific window manager)
- Shell: zsh (macOS default at `/opt/homebrew/bin/zsh`)

### Installation Requirements
- Homebrew must be available
- Internet connection for package installation
- Write access to `~/.config/` directory
- Existing configs are removed/overwritten by `init.sh`

### Configuration Management
- **Destructive symlink creation**: Existing configs removed before linking
- **No backup strategy**: `init.sh` uses `rm -rf` on existing configs
- **Single source of truth**: All configs must exist in repo before running setup

## External Dependencies

### Package Managers
- **Homebrew**: Primary package manager for Neovim, WezTerm, AeroSpace
- **Atuin installer**: Curl-based installation from `setup.atuin.sh`

### Language Servers (installed separately)
- clojure_lsp
- gopls
- lua_ls
- pylsp (with black and isort plugins)
- ts_ls

### Neovim Plugin Manager
- **lazy.nvim**: Plugin management and lazy loading

### Optional Integrations
- **Atuin cloud sync**: Shell history synchronization (requires account)
- **Git remotes**: OpenSpec change tracking and archival workflow
