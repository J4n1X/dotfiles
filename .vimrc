" get Vim-Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'

" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc


call plug#end()

" set theme
color gruvbox
" set background-style
set bg=dark

" COQ needs to run on start for autocompletion
let g:coq_settings = { 'auto_start': 'shut-up' }

set nocompatible
filetype indent plugin on
set fileformat=unix
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=2
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set pastetoggle=<F3>
