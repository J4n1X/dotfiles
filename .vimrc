" get Vim-Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" pathogen for syntastic
" execute pathogen#infect()

" syntastic recommended config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" config for ctrl-p

" set theme
color gruvbox
" set background-style
set bg=dark

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
