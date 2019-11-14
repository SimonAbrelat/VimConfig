" GENERAL CONFIG
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

" SYNTAX
syntax on
" cursor
set cursorline
set guicursor=
augroup CustomCursorLine
    au!
    au ColorScheme * :hi clear CursorLine
    au ColorScheme * :hi! CursorLine gui=underline cterm=underline
augroup END
set ruler

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
map <C-n> :exec Folder()<CR>
" Tabs
map <leader>f :tabnew<CR>
map <leader>r :tabnew +te<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
" Copy
nmap Y y$
" Terminal exit
tnoremap <Esc> <C-\><C-n>
" Jumplist
nnoremap <expr> k (v:count > 1 ? "m" . v:count : '') .'gk'
nnoremap <expr> j (v:count > 1 ? "m" . v:count : '') .'gj'
map <buffer> <C-n> :exec Folder()<CR>

function Folder()
    :vsplit
    :Ex
endfunction
