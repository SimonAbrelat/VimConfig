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
" GENERIC KEY BINDINGS
nmap j gj
nmap k gk
" Good Practices
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
" pane split maps
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <buffer> <C-s> :sp<CR>
map <buffer> <C-v> :vsp<CR>
" Saving and fast actions
map <buffer> <leader>w :w<CR>
map <buffer> <leader>q :q!<CR>
map <buffer> <leader>e :wq<CR>
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

if has('nvim') || has('termguicolors')
  set termguicolors
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/autoload/plugged')

" Environment
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'

" Langs
Plug 'sheerun/vim-polyglot'

" Colors
Plug 'lifepillar/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'

call plug#end()

colorscheme gruvbox8_hard

" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

" ALE
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}
let g:ale_linters = {
\   'cpp': ['clang'],
\   'python': ['flake8'],
\   'java': ['javac'],
\}

" FZF
map <C-p> :Files<CR>
let g:fzf_layout = { 'down': '~20%' }

" RAINBOW
au VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]
let g:rainbow#blacklist = ["#fab005", "#d79921", "#fabd2f"] " removes yellows
