# The OSC title we emit here is the single source of truth for the WezTerm tab
# label (see config/wezterm/config/appearance.lua): it's the only per-pane signal
# that stays fresh for background/unfocused tabs. At the prompt we show just the
# directory; while a command runs we show "<command> ▕ <dir>".
#
# The "running" title is deferred by TITLE_DELAY seconds via a background timer:
# a fast command (ls, cd, git status) finishes before the timer fires, precmd
# cancels it, and the title never flips — so no blink. Only commands that run
# longer than the delay actually swap the title to "<command> ▕ <dir>".
TITLE_DELAY=0.3
typeset -g _title_timer_pid=""

function set_title_precmd () {
  # cancel a still-pending "running" title before it can fire
  [[ -n "$_title_timer_pid" ]] && kill "$_title_timer_pid" 2>/dev/null
  _title_timer_pid=""
  local dir=${PWD##*/}
  echo -ne "\033]0;$dir\007"
}

function set_title_preexec () {
  local dir=${PWD##*/}
  local cmd=${1%% *}   # first word of the command line
  cmd=${cmd##*/}       # strip any leading path (e.g. /usr/bin/ping -> ping)
  # defer the title swap; &! backgrounds and disowns (no job-control noise)
  { sleep "$TITLE_DELAY"; echo -ne "\033]0;$cmd ▕ $dir\007" } &!
  _title_timer_pid=$!
}

if [ -n "$ZSH_VERSION" ]; then
  DISABLE_AUTO_TITLE="true"
  precmd_functions+=(set_title_precmd)
  preexec_functions+=(set_title_preexec)
fi

## base alias
alias vi="nvim"
alias cat="bat"

## shell
### zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

### startship
eval "$(starship init zsh)"

### atuin 
eval "$(atuin init zsh --disable-up-arrow)"

### don't sleep on close
alias keep_awake="sudo sh -c \"pmset -a disablesleep 1; trap 'pmset -a disablesleep 0; echo Sleep re-enabled' EXIT INT TERM; echo 'Sleep disabled for 3600 seconds...'; sleep 3600\""
