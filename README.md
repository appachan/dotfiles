# dotfiles
![platform support](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey)
[![mit license](https://img.shields.io/github/license/appachan/dotfiles)](https://github.com/appachan/dotfiles/blob/master/LICENSE)

[![support vim](https://img.shields.io/badge/support-vim-brightgreen.svg)](https://www.vim.org)
[![support zsh](https://img.shields.io/badge/support-zsh-blue.svg)](https://www.zsh.org/)
[![support tmux](https://img.shields.io/badge/support-tmux-green.svg)](https://github.com/tmux/tmux)
[![support vscode](https://img.shields.io/badge/support-vscode-blue.svg)](https://github.com/microsoft/vscode)
![support platex](https://img.shields.io/badge/support-platex-yellow.svg)
[![support peco](https://img.shields.io/badge/support-peco-green.svg)](https://github.com/peco/peco)
[![support karabiner](https://img.shields.io/badge/support-karabiner-green.svg)](https://github.com/tekezo/Karabiner-Elements)
[![support alacritty](https://img.shields.io/badge/support-alacritty-green.svg)](https://github.com/jwilm/alacritty)

![require git](https://img.shields.io/badge/requirements-git-blue)
![require curl](https://img.shields.io/badge/requirements-curl-blue)

## Installation
```
$ sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev # for Ubuntu.
$ xcode-select --install # for macOS.
$ git clone --recursive https://github.com/appachan/dotfiles.git
$ cd dotfiles
$ make
```

### platex
```
$ cd tex/
$ sudo bash setup.sh # and copy ./jlisting.sty to a proper destination.
```