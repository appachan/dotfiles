call plug#begin('~/.vim/plugged')

Plug 'asvetliakov/vim-easymotion'
Plug 'tpope/vim-surround'

call plug#end()

let mapleader = "\<Space>"

noremap <C-j> <esc>
noremap! <C-j> <esc>

set clipboard+=unnamedplus
set number
colorscheme iceberg
