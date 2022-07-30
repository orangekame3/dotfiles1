#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# fzf function
# command history with fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
function fzf-history-widget() {
  local tac=${commands[tac]:-"tail -r"}
  BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf +s)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
# fzf-z-search move directory with z
fzf-z-search() {
  local res=$(z | sort -rn | cut -c 12- | fzf --preview 'tree -C {} | head -200')
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N fzf-z-search
bindkey '^f' fzf-z-search
# fbr - checkout git branch
#fbr() {
#  local branches branch
#  branches=$(git branch -vv) &&
#  branch=$(echo "$branches" | fzf +m) &&
#  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
#}
#
fbr() {
  git checkout $(git branch -a | tr -d " " | fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")
}
zle -N fbr
bindkey '^b' fbr
. ~/z/z.sh
# Customize to your needs...
autoload -Uz promptinit
promptinit
prompt pure
# git
alias g="git"
alias gl="git l"
alias gla="git la"
alias gg="git la"
alias ge="gg --color | emojify | less -r"
alias push="git push origin HEAD"
alias pull="git fetch -p && git pull"
alias new="git new"
# indexにaddしていないファイルを全て元に戻す
alias wipe="git checkout . && git clean -fd"
#alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

export PATH="$HOME/.local/bin:$PATH"
source ~/.nvm/nvm.sh
nvm use "v16.13.1"
export PATH="$HOME/.tfenv/bin:$PATH"
if [[ $(command -v exa) ]]; then
  alias e='exa -a'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons'
  alias la=ea
  alias ee='exa -aal --icons'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
fi
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
export PATH="$HOME/lib/flutter/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions
alias -g copy='| pbcopy;pbpaste'
alias now='date -Is'
eval "$(starship init zsh)"
