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

" Wrap lines
set wrap

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

" Stop highlighting matches with ,+space
nnoremap <leader><space> :nohlsearch<CR>


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

" Functions (pinched from https://shapeshed.com/vim-statuslines/)
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? l:branchname : ''
endfunction

" Custom statusline 
" run `:help statusline` for additional flags
" run `:highlight` for available color modifiers

set statusline=%#StatusLineTerm#      " Green bg white fg
set statusline+=\                     " Space delimiter
set statusline+=%{StatuslineGit()}    " Git information
set statusline+=\                     " Space delimiter
set statusline+=%#PmenuSel#           " Blue bg white fg
set statusline+=\ %F                  " Full Filepath
set statusline+=%{&modified?'[+]':''} " Show [+] if file modified
set statusline+=\                     " Space delimiter
set statusline+=(%L\ Lines)           " Total lines
set statusline+=%=                    " Delimiter for left / right sides of statusline
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}  " utf-8
set statusline+=\[%{&fileformat}\]\                          " unix
set statusline+=%#Statement#          " Black bg blue fg
set statusline+=\                     " Space delimiter
set statusline+=\ %Y                " Filetype
set statusline+=%#ModeMsg#            " Black bg white fg
set statusline+=\ \|\                 " ' | ' delimiter
set statusline+=%#WarningMsg#         " Black bg red fg
set statusline+=\ %l:%c               " Line number: column number
set statusline+=%#ModeMsg#            " Black bg white fg
set statusline+=\ \|\                 " ' | ' delimiter
set statusline+=%#MoreMsg#           " Black bg green fg
set statusline+=\ %p%%                " Percentage through file
set statusline+=\                     " Space delimiter
" set statusline+=%*                    " Default colors


"#################################################
" TMUX

" Allow cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif