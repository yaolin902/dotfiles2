set nocompatible
filetype off
set autoread

set termguicolors
colorscheme slate

set foldenable
set foldlevelstart=10
set foldmethod=syntax

syntax enable
filetype plugin indent on
set autoindent
set copyindent
set shiftround

set number
set relativenumber

set hidden
set nowrap

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

set viminfo='0,:0,<0,@0,f0
set nobackup
set nowb
set noswapfile

set backspace=indent,eol,start

set ruler
set showcmd

set noerrorbells
set visualbell
set t_vb=

set incsearch
set hlsearch
set ignorecase
set smartcase

set history=1000
set undolevels=1000

set showmatch
set guioptions-=T

set splitright
set splitbelow

set ai
set si

set path+=**
set wildmenu
set wildcharm=<Tab>
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

set title

set shell=/usr/bin/zsh

set encoding=utf-8

let g:netrw_banner=0
let g:netrw_liststyle=3

" statusline
set laststatus=2

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c 

" mappings

let g:mapleader="\<Space>"

nnoremap <Leader>q :q!<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>t :horizontal terminal<CR>
nnoremap <Leader>e :topleft vs<CR>:e .<CR>
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>N :tabnext<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

map <C-w>f <C-w>vgf
