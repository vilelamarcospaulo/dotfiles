function set_title_precmd () {
  str=$(echo $PWD | sed 's/.*\///')
  echo -ne "\033]0;$str\007"
}
function set_title_preexec () {
  str=$(echo $PWD | sed 's/.*\///')
  echo -ne "\033]0;$1 | $str\007"
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
