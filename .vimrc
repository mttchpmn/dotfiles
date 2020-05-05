"  mttchpmn       _
"          __   _(_)_ __ ___  _ __ ___
"          \ \ / / | '_ ` _ \| '__/ __|
"           \ V /| | | | | | | | | (__
"          (_)_/ |_|_| |_| |_|_|  \___|
"

"#################################################
" BASIC SETUP

" Use Utf-8
set encoding=utf8

" Enable syntax highlighting
syntax on

" Set color scheme
colorscheme delek

" Show line numbers
set number

" Always show status bar
set laststatus=2

" Show last command
set showcmd

" Show mode
set showmode

" Highlight current line
set cursorline

" Colorise 81st column to keep lines short
set colorcolumn=81

" Show current position
set ruler

" Wrap lines
set wrap

" Show filename in window title
set title

" Enable mouse support
set mouse=a

" Load filetype-specific indent files
filetype indent on

" Enable visual autocomplete for command menu
set wildmenu

" Only redraw when necessary
set lazyredraw

" Highlight matching [{()}] characters
set showmatch

" Automatically read file when changed on disk
set autoread

" Don't skip lines if they are wrapped
nmap j gj
nmap k gk

" Proper backspace behaviour
set backspace=indent,eol,start

" Allow for buffers in background
set hidden


"#################################################
" SPACES & TABS

" Indenting
set autoindent
set smartindent

" Set number of spaces per tab
set tabstop=2 " Visual mode
set softtabstop=2 " Editing

" Turn tabs into spaces
set expandtab


"#################################################
" SEARCHING

" Search as characters are entered
set incsearch

" Highlight matches
set hlsearch

" Case insensitive
set ignorecase

" Switch to case sensitive if query is uppercase
set smartcase

" Stop highlighting with ,+space
nnoremap <leader><space> :nohlsearch<CR> " ?


"#################################################
" LEADER SHORTCUTS

" Set leader to comma key
let mapleader=","

" Set jj to send <esc> key
inoremap jj <esc>

" Save file
nnoremap<leader>w :w!<CR>

" Save Vim session (Reopen with `vim -S`)
nnoremap<leader>s :mksession<CR>


"#################################################
" STATUS LINE

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"#################################################
" TMUX

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif