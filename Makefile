# Let's make!

UNAME_S    := $(shell uname -s)
BREW       := $(shell which brew 2> /dev/null)
GIT				 := $(shell which git 2> /dev/null)
CURL			 := $(shell which curl 2> /dev/null)
ROOT			 := $(shell pwd)

export ROOT

ifeq ($(UNAME_S),Darwin)
	BREW_COMPILER := /usr/bin/ruby -e
	BREW_SOURCE := https://raw.githubusercontent.com/Homebrew/install/master/install
else
	BREW_COMPILER := sh -c
	BREW_SOURCE := https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh
endif

ifeq ($(BREW), )
	BREW_COMMAND := yes ' ' | $(BREW_COMPILER) "$$(curl -fsSL $(BREW_SOURCE))"
endif

# export path of brew command.
ifeq ($(UNAME_S),Darwin)
	EXPORT_BREW := eval $$(/usr/local/bin/brew shellenv)
else
	EXPORT_BREW := eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
endif

NEOBUNDLE_COMMAND := sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)" # git required.

.PHONY: all init deploy clean test build_brew install_brew_formulae check_requirements \
setup_vim setup_zsh setup_tmux setup_latex_japanese install_pyenv install_tools_on_go install_tools_on_python done

all: init deploy done

check_requirements:
ifeq ($(GIT), )
	@echo 'git required, but not found.'
	false
endif
ifeq ($(CURL), )
	@echo 'curl required, but not found.'
	false
endif

# brew, mas, | zsh(zprezto), vim, tmux, ...
init: check_requirements build_brew install_brew_formulae setup_zsh setup_vim setup_tmux

# dotfiles installation.
deploy: clean
	@echo 'make symbolic-links'

	# zsh
	ln -s $(ROOT)/.zshrc $$HOME/.zshrc

	# git
	ln -s $(ROOT)/.gitconfig $$HOME/.gitconfig
	ln -s $(ROOT)/.gitignore_global $$HOME/.gitignore_global
	ln -s $(ROOT)/.GIT_COMMIT_TEMPLATE.txt $$HOME/.GIT_COMMIT_TEMPLATE.txt

	# vim
	ln -s $(ROOT)/.vimrc $$HOME/.vimrc

	# intellij
	ln -s $(ROOT)/.ideavimrc $$HOME/.ideavimrc

	# tmux
	ln -s $(ROOT)/tmux/tmux_template/.tmux.conf $$HOME/.tmux.conf
	ln -s $(ROOT)/tmux/.tmux.conf.local $$HOME/.tmux.conf.local

	# vscode (only macos)
	# vscodeがうっかり生成することがあるので -f
ifeq ($(UNAME_S),Darwin)
	ln -sf $(ROOT)/vscode/settings.json $$HOME/Library/Application\ Support/Code/User/settings.json
	ln -sf $(ROOT)/vscode/keybindings.json $$HOME/Library/Application\ Support/Code/User/keybindings.json
	$(ROOT)/vscode/bin/install_extensions.sh
endif

	# tools on python
	## atcoder-tools
	ln -s $(ROOT)/.atcodertools.toml $$HOME/.atcodertools.toml

	# tools based on the XDG Base Directory Specification
	mkdir -p $$HOME/.config
	## alacritty
	ln -s $(ROOT)/.config/alacritty $$HOME/.config/alacritty
	## karabiner-elements
	ln -s $(ROOT)/.config/karabiner $$HOME/.config/karabiner
	## peco
	ln -s $(ROOT)/.config/peco $$HOME/.config/peco

# clean dotfiles already deployed.
clean:
	@echo 'remove symbolic-links'

	# zsh
	rm -rf $$HOME/.zshrc &> /dev/null

	# git
	rm -rf $$HOME/.gitconfig &> /dev/null
	rm -rf $$HOME/.gitignore_global &> /dev/null
	rm -rf $$HOME/.GIT_COMMIT_TEMPLATE.txt &> /dev/null

	# vim
	rm -rf $$HOME/.vimrc &> /dev/null

	# intellij
	rm -rf $$HOME/.ideavimrc &> /dev/null

	# tmux
	rm -rf $$HOME/.tmux.conf &> /dev/null
	rm -rf $$HOME/.tmux.conf.local &> /dev/null

	# vscode (only macos)
ifeq ($(UNAME_S),Darwin)
	rm -rf $$HOME/Library/Application\ Support/Code/User/settings.json &> /dev/null
	rm -rf $$HOME/Library/Application\ Support/Code/User/keybindings.json &> /dev/null
endif

	# tools on python
	## atcoder-tools
	rm -rf $$HOME/.atcodertools.toml &> /dev/null

	# tools based on the XDG Base Directory Specification
	## alacritty
	rm -rf $$HOME/.config/alacritty &> /dev/null
	## karabiner-elements
	rm -rf $$HOME/.config/karabiner &> /dev/null
	## peco
	rm -rf $$HOME/.config/peco &> /dev/null

build_brew:
	# setup Homebrew.
	$(BREW_COMMAND)

install_brew_formulae:
	# install tools from brew, cask, mas by brew-bundle.
	# brew-bundle will automatically skip cask & mas on Linux (https://github.com/Homebrew/homebrew-bundle/blob/master/README.md).
	$(EXPORT_BREW) && brew bundle --file=$(ROOT)/packages/Brewfile
ifeq ($(UNAME_S),Darwin)
	$(EXPORT_BREW) && brew bundle --file=$(ROOT)/packages/Brewfile.macos
endif

setup_zsh:
	# install zprezto
	$(EXPORT_BREW) && zsh $(ROOT)/zsh/prezto/setup.sh

setup_vim:
	# install NeoBundle
	$(NEOBUNDLE_COMMAND)

setup_tmux:
	# install tpm
	mkdir -p $$HOME/.tmux/plugins/
	git clone https://github.com/tmux-plugins/tpm $$HOME/.tmux/plugins/tpm

setup_latex_japanese:
	$(ROOT)/tex/bin/setup.sh

install_pyenv:
	# setup global python environment.

install_tools_on_python:
	# pip install ...

install_tools_on_go:
	# go get ...

done:
	@echo 'done.'

test:
	@echo 'this is test message.'
ifeq ($(UNAME_S),Darwin)
	@echo 'os: macOS'
else
	@echo 'os: not macOS'
endif
