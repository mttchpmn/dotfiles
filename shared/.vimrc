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
colorscheme elflord

" Show line numbers
set number

" Always show status bar
set laststatus=2

" Show last command
set showcmd

" Don't show mode (we're showing it in statusline instead)
set noshowmode

" Highlight current line
set cursorline

" Set text width
set textwidth=79

" Always open files to the right, or below current file
set splitright
set splitbelow

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

" Stop highlighting matches
nnoremap <leader>\ :nohlsearch<CR>


"#################################################
" COMMAND REMAPS

" Set leader to space key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Launch terminal
nnoremap<leader>t :vert term<CR>

" Save Vim session (Reopen with `vim -S`)
nnoremap<leader>s :mksession<CR>

" Make vertical split and switch into it (VSCode style)
nnoremap<C-\> <C-w>v<C-w>l

" ALternative tab commands
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tx :tabclose<CR>

" Set jj to send <esc> key
inoremap jk <esc>


" Use Ctrl+hjkl keys to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split file right
nnoremap <leader>v <C-w>v

" Split file below
nnoremap <leader>s <C-w>s

" Open new file right
nnoremap <leader>n :vnew<CR>

" Open new file below
nnoremap <leader><S-n> :new<CR>

" Quit current window
nnoremap <leader>q :quit<CR>

" Open file
nnoremap <C-o> :e<space>

" Open directory
nnoremap <C-S-o> :Ex<CR>


"#################################################
" STATUS LINE

" Git functions (pinched from https://shapeshed.com/vim-statuslines/)
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ?'  '.l:branchname.' ' : ''
endfunction


" Mode function pinched from http://tdaly.co.uk/projects/vim-statusline-generator/
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

" Custom statusline 
" run `:help statusline` for additional flags
" run `:highlight` for available color modifiers

" Define custom colors use `%1*` to call color1 etc and `%*` to reset to default
hi User1 ctermbg=green ctermfg=black   guibg=green guifg=black
hi User2 ctermbg=black ctermfg=blue    guibg=black guifg=blue
hi User3 ctermbg=black ctermfg=white   guibg=black guifg=white
hi User4 ctermbg=black ctermfg=red     guibg=black guifg=red
hi User5 ctermbg=black ctermfg=green   guibg=black guifg=green
hi User6 ctermbg=blue  ctermfg=white   guibg=blue  guifg=white
hi User7 ctermbg=black  ctermfg=magenta   guibg=black  guifg=magenta

" set statusline=%#StatusLineTerm#      " Green bg white fg
set statusline=                    
set statusline+=%1*                    
set statusline+=%{StatuslineGit()}    " Git information
set statusline+=%7*                    " Default colors
set statusline+=\                     " Space delimiter
set statusline+=%{StatuslineMode()}
set statusline+=\                     " Space delimiter
set statusline+=%6*                    " Default colors
set statusline+=\ %F                  " Full Filepath
set statusline+=%{&modified?'[+]':''} " Show [+] if file modified
set statusline+=\                     " Space delimiter
set statusline+=(%L\ Lines)           " Total lines
set statusline+=%=                    " Delimiter for left / right sides of statusline
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}   " utf-8
set statusline+=\[%{&fileformat}\]\                          " unix
set statusline+=%2*         
set statusline+=\                     " Space delimiter
set statusline+=\ %Y                  " Filetype
set statusline+=%3*           
set statusline+=\ \|\                 " ' | ' delimiter
set statusline+=%4*        
set statusline+=\ %l:%c               " Line number: column number
set statusline+=%3*            
set statusline+=\ \|\                 " ' | ' delimiter
set statusline+=%5*           
set statusline+=\ %p%%                " Percentage through file
set statusline+=\                     " Space delimiter


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
