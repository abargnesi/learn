" basic
set nocompatible
syntax on
filetype on
filetype indent plugin on
autocmd FileType ruby compiler ruby

set autoindent
set backspace=indent,eol,start
set incsearch
set hlsearch
set number
set ruler
set modeline
set modelines=5

" load vim-flavor dep manager
let cwd_rtp=fnamemodify(expand(getcwd()), ':p')
let &runtimepath=cwd_rtp . "," . &runtimepath

runtime macros/matchit.vim
runtime flavors/bootstrap.vim
