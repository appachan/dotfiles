# Let's make!

UNAME_S    := $(shell uname -s)
BREW       := $(shell which brew 2> /dev/null)
GIT				 := $(shell which git 2> /dev/null)
CURL			 := $(shell which curl 2> /dev/null)
ROOT			 := $(shell pwd)

export ROOT

ifeq ($(UNAME_S),Darwin)
	BREW_COMPILER := /bin/bash -c
	BREW_SOURCE := https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
else
	BREW_COMPILER := sh -c
	BREW_SOURCE := https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh
endif

ifeq ($(BREW), )
	BREW_COMMAND := yes ' ' | $(BREW_COMPILER) "$$(curl -fsSL $(BREW_SOURCE))"
endif

# export path of brew command.
ifeq ($(UNAME_S),Darwin)
	EXPORT_BREW := eval $$(/opt/homebrew/bin/brew shellenv)
else
	EXPORT_BREW := eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
endif

NEOBUNDLE_COMMAND := sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)" # git required.

.PHONY: all init deploy clean test build_brew install_brew_formulae check_requirements \
setup_vim setup_neovim setup_zsh setup_tmux done

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

	# vim
	ln -s $(ROOT)/.vimrc $$HOME/.vimrc

	# jetbranins
	ln -s $(ROOT)/.ideavimrc $$HOME/.ideavimrc

	# tmux
	ln -s $(ROOT)/tmux/tmux_template/.tmux.conf $$HOME/.tmux.conf
	ln -s $(ROOT)/tmux/.tmux.conf.local $$HOME/.tmux.conf.local

	# tools based on the XDG Base Directory Specification
	mkdir -p $$HOME/.config
	## alacritty
	ln -s $(ROOT)/.config/alacritty $$HOME/.config/alacritty
	## karabiner-elements
	ln -s $(ROOT)/.config/karabiner $$HOME/.config/karabiner
	## peco
	ln -s $(ROOT)/.config/peco $$HOME/.config/peco
	## starship
	ln -s $(ROOT)/.config/starship.toml $$HOME/.config/starship.toml
	## gitui
	ln -s $(ROOT)/.config/gitui $$HOME/.config/gitui
	## neovim
	ln -s $(ROOT)/.config/nvim $$HOME/.config/nvim
	## mise
	ln -s $(ROOT)/dot_config/mise $$HOME/.config/mise
	## ccstatusline
	ln -s $(ROOT)/dot_config/ccstatusline $$HOME/.config/ccstatusline

# clean dotfiles already deployed.
clean:
	@echo 'remove symbolic-links'

	# zsh
	rm -rf $$HOME/.zshrc &> /dev/null

	# git
	rm -rf $$HOME/.gitconfig &> /dev/null

	# vim
	rm -rf $$HOME/.vimrc &> /dev/null

	# jetbranins
	rm -rf $$HOME/.ideavimrc &> /dev/null

	# tmux
	rm -rf $$HOME/.tmux.conf &> /dev/null
	rm -rf $$HOME/.tmux.conf.local &> /dev/null

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
	$(EXPORT_BREW) && brew bundle --file=$(ROOT)/Brewfile

setup_zsh:
	# install zprezto
	$(EXPORT_BREW) && zsh $(ROOT)/zsh/prezto/setup.sh

setup_vim:
	# install NeoBundle
	$(NEOBUNDLE_COMMAND)
	
setup_neovim:
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

setup_tmux:
	# install tpm
	mkdir -p $$HOME/.tmux/plugins/
	git clone https://github.com/tmux-plugins/tpm $$HOME/.tmux/plugins/tpm

done:
	@echo 'done.'

test:
	@echo 'this is test message.'
ifeq ($(UNAME_S),Darwin)
	@echo 'os: macOS'
else
	@echo 'os: not macOS'
endif
