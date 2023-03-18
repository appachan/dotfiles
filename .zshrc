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

# gcloud CLI via brew cask
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"
# enable asdf
. $(brew --prefix asdf)/libexec/asdf.sh


# starship
eval "$(starship init zsh)"
