# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#alias rm="gomi -s"
alias rm="rm"
alias sshx="ssh -2 -C -Y"
alias cp="cp"
alias cat='bat'
alias repos='ghq list -p | peco'
alias gorepo='cd $(repos)'
alias sharedir='du -h -d 1 | sort -rh'
alias tmuxnew='tmux new -s `basename $PWD`'

export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PIPENV_VENV_IN_PROJECT="true"
export PATH="/usr/local/opt/opencv3/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# for lab / experiences.
export PATH="$HOME/workspace/klab/lp_solve:$PATH"
export PATH="$HOME/workspace/klab/syncha-0.3.1.1:$PATH"
alias chapas="java -jar $HOME/workspace/klab/chapas-0.742/chapas.jar -I RAW"
alias frost="java -jar $HOME/workspace/klab/FROST_JAR/frost.jar"

#export http_proxy=http://proxy.uec.ac.jp:8080/
#export https_proxy=$http_proxy
#export all_proxy=$http_proxy

# show cmd history with peco
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
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
