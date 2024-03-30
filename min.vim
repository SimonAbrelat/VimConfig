" GENERAL CONFIG
" better leader
let g:mapleader=" "
let g:maplocalleader=" "
" numbering
set number
set relativenumber
" history
set history=500
" filetypes
filetype indent on
filetype plugin on
set nocompatible
" prevents folding
set nofoldenable
" checks for outside changes
set autoread
" new window to right
set splitright
" no back ups
set nobackup
set nowb
set noswapfile
" files
set path+=**
set wildmenu

" SYNTAX
syntax on
set termguicolors
" colorscheme
colo slate " get a better one later
" cursor
set ruler
set cursorline
augroup CustomCursorLine
    au!
    au ColorScheme * :hi clear CursorLine
    au ColorScheme * :hi! CursorLine guibg=none ctermbg=none gui=underline cterm=underline
augroup END

" TEXT
" invisiables
set listchars=tab:>-
set list
" font
set expandtab " Tabs -> spaces
set smarttab
" 1 tab == 4 spcaes
set shiftwidth=4
set tabstop=4
set shiftround
" line breaks
set lbr
set tw=125
" indent
set ai
set si
set wrap

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------
" General
nmap Q <Nop>

" Window Management
" saving and closing
map <leader>ww :w<CR>
map <leader>wq :q<CR>
map <leader>we :wq<CR>
map <leader>wr :source $MYVIMRC<CR>
map <leader>wc :e $MYVIMRC<CR>
" Pane management
map <leader>wh <C-W>h
map <leader>wj <C-w>j
map <leader>wk <C-W>k
map <leader>wl <C-W>l
map <leader>ws :split <CR>
map <leader>wv :vsplit <CR>
" Tabs
map <leader>tn :tabnew<CR>
map <leader>tt :tabnew +te<CR>
map <leader>t1 1gt
map <leader>t2 2gt
map <leader>t3 3gt
map <leader>t4 4gt
map <leader>t5 5gt
map <leader>t6 6gt
map <leader>t7 7gt
map <leader>t8 8gt
map <leader>t9 9gt
map <leader>t0 10gt
" Terminal exit
tnoremap <Esc> <C-\><C-n>

" Editing
" scope aware moves
vnoremap J :m '>+1<CR>gv=gv"
vnoremap K :m '<-2<CR>gv=gv"
" center the screen
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n nzzzv
nmap N Nzzzv
nnoremap <expr> ' "'" . nr2char(getchar()) . 'zz'
nnoremap <expr> ` "`" . nr2char(getchar()) . 'zz'
" better yanks and deletes
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>d "_d
vmap <leader>d "_d
nmap <leader>p "+p
vmap <leader>p "+p

" Buffers
nmap <leader>bl :ls<CR>
nmap <leader>bs :sp<CR>:ls<CR>:b
nmap <leader>bv :vsp<CR>:ls<CR>:b
nmap <leader>bb :ls<CR>:b

" Finder
nmap <leader>nn :topleft vsp<CR>:Ex<CR>
nmap <leader>np :topleft vsp<CR>:Ex<CR><C-W>p
nmap <leader>nc <C-W><C-T><C-W>c<C-W>p
nmap <leader>nl <C-W><C-T>
let g:netrw_liststyles=3
