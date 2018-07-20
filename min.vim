" GENERAL CONFIG
filetype indent on
filetype plugin on
set nocompatible 
set nofoldenable
set autoread
set history=500

" SYNTAX
syntax on
set ruler
set cursorline

" TEXT
" Tab
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
" characters
" set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:.
" set list
" lines
set lbr
set tw=125
" indent
set ai
set si

" FILES
set path+=**
set wildmenu
" :b to autocomplete to any buffer

" NUMBERING
set number
set relativenumber

" NO BACK UPS
set nobackup
set nowb
set noswapfile

" MAPPING
" Good practices
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
" Saving and Closing
map <buffer> <leader>w :w<CR>
map <buffer> <leader>q :q<CR>
map <buffer> <leader>e :wq<CR>
" Pane management
map <C-h> <C-W>h
map <C-j> <C-w>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <buffer> <C-c> :split <CR>
map <buffer> <C-v> :vsplit <CR>
" File navegation
map <buffer> <C-f> :e <CR>
map <buffer> <C-n> :exec Folder()<CR>

function Folder()
    :vsplit
    :Ex
endfunction
