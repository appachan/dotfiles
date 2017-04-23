scriptencoding utf-8
set backspace=indent,eol,start "backspace
set clipboard=unnamed,unnamedplus
set nocompatible
filetype on
set synmaxcol=200
set clipboard=unnamed,autoselect

" texのconcealを無効化
set conceallevel=0
let g:tex_conceal=''
let g:vim_json_syntax_conceal=0

" show candidats of command
set wildmenu
set history=5000

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif
    " originalrepos on github
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'VimClojure'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'jpalardy/vim-slime'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'alpaca-tc/alpaca_powertabline'
    NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
    NeoBundle 'Lokaltog/powerline-fontpatcher'
    NeoBundle 'kchmck/vim-coffee-script',
    NeoBundle 'thinca/vim-quickrun',
    NeoBundle 'gabrielelana/vim-markdown',
    NeoBundle 'Yggdroot/indentLine',
    NeoBundle 'rhysd/vim-gfm-syntax',
    NeoBundle 'elzr/vim-json'
    "NeoBundle 'https://bitbucket.org/kovisoft/slimv'

    filetype plugin indent on     " required!
    filetype indent on
    call neobundle#end()

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

noremap <C-j> <esc>
noremap! <C-j> <esc>

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set number
set cursorline
syntax on
set showmatch
set background=dark
"colorscheme seoul256
colorscheme iceberg
"colorscheme railscasts
"colorscheme badwolf
"colorscheme BusyBee
"colorscheme gruvbox
"colorscheme jellybeans
"colorscheme lucius
"colorscheme molokai
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set list
set virtualedit=block
set whichwrap+=h,l,<,>,[,],b,s

if has("mac")
  set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
elseif has("unix")
  set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%
endif


" Settings for CoffeeScript
" set FileType
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
au BufRead,BufNewFile,BufReadPre *.md set filetype=markdown
au BufRead,BufNewFile,BufReadPre *.ts set filetype=typescript
" auto compile when written
"autocmd BufWritePost *.coffee silent make!
" show error
autocmd QuickFixCmdPost * nested cwindow | redraw!
" show result *.js with Ctrl-c
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

" in reading Markdown,
"autocmd FileType html,markdown colorscheme jellybeans
autocmd FileType html,markdown hi clear SpellBad
" in reeding tex-like file,
"autocmd FileType tex,eruby colorscheme jellybeans

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
