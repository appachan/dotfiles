# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

case ${OSTYPE} in
    darwin*)
        eval $(/opt/homebrew/bin/brew shellenv)
        ;;
    linux*)
        eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        ;;
esac

alias rm="rm"
alias sshx="ssh -2 -C -Y"
alias cp="cp"
alias cat='bat'
alias repos='ghq list -p | peco'
alias gorepo='cd $(repos)'
alias sharedir='du -h -d 1 | sort -rh'
alias tmuxnew='tmux new -s `basename $PWD`'

export PATH="$HOME/.go/bin:$PATH"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin/:$PATH"

export PIPENV_VENV_IN_PROJECT="true"

# show cmd history with peco
function peco-select-history() {
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# 環境ごとに個別の設定ファイル
if [[ -s "$HOME/separated_rc.zsh" ]]; then
  source "$HOME/separated_rc.zsh"
fi

# enable asdf
. $(brew --prefix asdf)/libexec/asdf.sh

# enable mise
eval "$(mise activate zsh)"

# enable direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# completion
autoload bashcompinit && bashcompinit
## brew-related completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# load device-specific configures
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
