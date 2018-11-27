# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#alias rm="gomi -s"
alias rm="rm"
alias sshx="ssh -2 -C -Y"
alias cp="cp"
alias emacs='emacs -nw'
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

# for lab / experiences.
export PATH="$HOME/workspace/klab/lp_solve:$PATH"
export PATH="$HOME/workspace/klab/syncha-0.3.1.1:$PATH"
alias chapas="java -jar $HOME/workspace/klab/chapas-0.742/chapas.jar -I RAW"
alias frost="java -jar $HOME/workspace/klab/FROST_JAR/frost.jar"

#export http_proxy=http://proxy.uec.ac.jp:8080/
#export https_proxy=$http_proxy
#export all_proxy=$http_proxy

# 環境ごとに個別の設定ファイル
if [[ -s "$HOME/separated_rc.zsh" ]]; then
  source "$HOME/separated_rc.zsh"
fi
