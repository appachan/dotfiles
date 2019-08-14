# Let's make!

UNAME_S    := $(shell uname -s)
BREW       := $(shell which brew 2> /dev/null)
ROOT			 := $(shell pwd)

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

.PHONY: all init deploy test build_brew

#all: init deploy done
#all: deploy
all: test

# brew, mas, | zsh(zprezto), vim, tmux, ...
init:
	@echo 'start initializing...'

# clean dotfiles already deployed.
clean:
	@echo 'remove symbolic-links'

	# zsh
	unlink $(HOME)/.zshrc 2> /dev/null

	# git
	unlink $(HOME)/.gitconfig 2> /dev/null
	unlink $(HOME)/.gitignore_global 2> /dev/null
	unlink $(HOME)/.GIT_COMMIT_TEMPLATE.txt 2> /dev/null

	# vim
	unlink $(HOME)/.vimrc 2> /dev/null

	# intellij
	unlink $(HOME)/.ideavimrc 2> /dev/null

	# tmux
	unlink $(HOME)/.tmux.conf 2> /dev/null
	unlink $(HOME)/.tmux.conf.local 2> /dev/null

	# vscode (only macos)
ifeq ($(UNAME_S),Darwin)
	unlink $(HOME)/Library/Application\ Support/Code/User/settings.json 2> /dev/null
	unlink $(HOME)/Library/Application\ Support/Code/User/keybindings.json 2> /dev/null
endif

	# tools on python
	## atcoder-tools
	unlink $(HOME)/.atcodertools.toml 2> /dev/null

	# tools based on the XDG Base Directory Specification
	## alacritty
	unlink $(HOME)/.config/alacritty 2> /dev/null
	## karabiner-elements
	unlink $(HOME)/.config/karabiner 2> /dev/null
	## peco
	unlink $(HOME)/.config/peco 2> /dev/null

# dotfiles installation.
deploy: clean
	@echo 'make symbolic-links'

	# zsh
	ln -s $(ROOT)/.zshrc $(HOME)/.zshrc

	# git
	ln -s $(ROOT)/.gitconfig $(HOME)/.gitconfig
	ln -s $(ROOT)/.gitignore_global $(HOME)/.gitignore_global
	ln -s $(ROOT)/.GIT_COMMIT_TEMPLATE.txt $(HOME)/.GIT_COMMIT_TEMPLATE.txt

	# vim
	ln -s $(ROOT)/.vimrc $(HOME)/.vimrc

	# intellij
	ln -s $(ROOT)/.ideavimrc $(HOME)/.ideavimrc

	# tmux
	ln -s $(ROOT)/tmux/tmux_template/.tmux.conf $(HOME)/.tmux.conf
	ln -s $(ROOT)/tmux/.tmux.conf.local $(HOME)/.tmux.conf.local

	# vscode (only macos)
	# vscodeがうっかり生成することがあるので -f
ifeq ($(UNAME_S),Darwin)
	ln -sf $(ROOT)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	ln -sf $(ROOT)/vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json
	$(ROOT)/vscode/bin/install_extensions.sh
endif

	# tools on python
	## atcoder-tools
	ln -s $(ROOT)/.atcodertools.toml $(HOME)/.atcodertools.toml

	# tools based on the XDG Base Directory Specification
	mkdir -p $(HOME)/.config
	## alacritty
	ln -s $(ROOT)/.config/alacritty $(HOME)/.config/alacritty
	## karabiner-elements
	ln -s $(ROOT)/.config/karabiner $(HOME)/.config/karabiner
	## peco
	ln -s $(ROOT)/.config/peco $(HOME)/.config/peco

test:
	@echo 'this is test message.'
ifeq ($(UNAME_S),Darwin)
	@echo 'os: macOS'
else
	@echo 'os: not macOS'
endif

build_brew:
	# setup Homebrew.
	$(BREW_COMMAND)

install_brew_formulae:
	# install tools from brew, cask, mas by brew-bundle.
	# brew-bundle will automatically skip cask & mas on Linux (https://github.com/Homebrew/homebrew-bundle/blob/master/README.md).
	brew bundle --file=$(ROOT)/packages/Brewfile

install_pyenv:
	# setup global python environment.

install_tools_on_python:
	# pip install ...

install_tools_on_go:
	# go get ...