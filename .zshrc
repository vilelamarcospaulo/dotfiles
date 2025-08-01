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

####
alias vi="nvim"
alias vim="nvim"

#### 
alias cat="bat"
export BAT_THEME="gruvbox-dark"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##
source <(fzf --zsh)

## atuin history
eval "$(atuin init zsh --disable-up-arrow)"
