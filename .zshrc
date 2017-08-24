# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#alias rm="gomi -s"
alias rm="rm"
alias sshx="ssh -2 -C -Y"
alias cp="cp"
#alias emacs="emacs &"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="/usr/local/opt/opencv3/bin:$PATH"

# for lab / experiences.
export PATH="$HOME/workspace/klab/lp_solve:$PATH"
export PATH="$HOME/workspace/klab/syncha-0.3.1.1:$PATH"
alias chapas="java -jar $HOME/workspace/klab/chapas-0.742/chapas.jar -I RAW"
alias frost="java -jar $HOME/workspace/klab/FROST_JAR/frost.jar"
