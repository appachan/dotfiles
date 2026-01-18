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
alias cat='bat'
alias cp="cp"
alias sharedir='du -h -d 1 | sort -rh'
alias tmuxnew='tmux new -s `basename $PWD`'

export PATH="$HOME/.go/bin:$PATH"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin/:$PATH"

export PIPENV_VENV_IN_PROJECT="true"

# cr: change repository
cr() {
    local dir="$(ghq list -p | fzf)"
    [[ -n "$dir" ]] && cd "$dir"
}

# Ctrl + r: fuzzy search command history
function fzf-select-history() {
    local selected="$(history -nr 1 | awk '!a[$0]++' | fzf --query "$LBUFFER" | sed 's/\\n/\n/g')"
    if [[ -n "$selected" ]]; then
        BUFFER="$selected"
        CURSOR=$#BUFFER
    fi
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^R' fzf-select-history

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
