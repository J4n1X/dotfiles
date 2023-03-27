" get Vim-Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

" set theme
color gruvbox
" set background-style
set bg=dark

let g:deoplete#enable_at_startup = 1

" deoplete configuration
inoremap <TAB>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
