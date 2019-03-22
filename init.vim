" GENERAL CONFIG
" History
set history=500
" senses filetypes
filetype plugin on
filetype indent on
" prevents folding
set nofoldenable
" checks for outside changes
set autoread
" displays colors
syntax on
set splitbelow
set splitright

" UI
" curser
set cursorline
set guicursor=
augroup CustomCursorLine
    au!   
    au ColorScheme * :hi clear CursorLine
    au ColorScheme * :hi! CursorLine gui=underline cterm=underline
augroup END
set ruler
" searching
set ignorecase
set smartcase
set nohlsearch
set incsearch
" Errors
set noerrorbells
set novisualbell
" Line nnumbers
set number
set relativenumber

" FILES
set nobackup
set nowb
set noswapfile

" TEXT
" invisiables
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:.
set list
" font
set expandtab " Tabs -> spaces
set smarttab
" 1 tab == 2 spcaes
set shiftwidth=2
set tabstop=2
set shiftround
" line breaks
set lbr
set tw=125
" indent
set ai
set si
set wrap


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
map <buffer> <leader>f :e<CR>
" Saving and fast actions
map <buffer> <leader>w :w<CR>
map <buffer> <leader>q :q!<CR>
map <buffer> <leader>e :wq<CR>
" Copy
nmap Y y$

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/autoload/plugged')

" Environment
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Writing
Plug 'junegunn/goyo.vim'
Plug 'rhysd/vim-grammarous'
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-lexical'

" Langs
Plug 'sheerun/vim-polyglot'
Plug 'SimonAbrelat/Vim-Symbols'

" Themes
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'
Plug 'chriskempson/base16-vim'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
"colorscheme base16 
" set background=dark

" GOYO
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set nocursorline
  set noruler
  set tw=80
  set scrolloff=999
  Ditto
endfunction
function! s:goyo_leave()
  set showmode
  set showcmd
  set cursorline
  set ruler
  set tw=125
  set scrolloff=5
  NoDitto
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <buffer> <leader>g :Goyo<CR>
let g:goyo_width = 80

" CTRL - P
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2vjr'

" LEXICAL
augroup lexical
  autocmd!
  autocmd! BufEnter *.{tex} call lexical#init()
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
let g:lexical#spelllang = ['en_us']
let g:lexical#thesaurus = ['~/.config/nvim/spell/mthesaur.txt']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']

" Latex
fu! Writting_Enter()
  set linebreak
  set tw=110
  Ditto
endfu
fu! Writting_Leave()
  set nospell
  NoDitto
endfu
autocmd! BufEnter *.{tex} call Writting_Enter()
autocmd! BufLeave *.{tex} call Writting_Leave()

" ALE
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\ 'cpp': ['clang'],
\ 'rust': ['rustc'],
\ 'python': ['mypy'],
\ 'haskell': ['ghc']
\}
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" NERDTREE
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='distinguished'

" Deoplete
let g:deoplete#enable_at_startup = 1

" NerdCommenter
let g:NERDSpaceDelims = 1
nmap c :call NERDComment(0,"toggle")<CR>

" Java
fu! Java_Enter()
  set.shiftwidth=2¬
  set.tabstop=2¬
endfu
fu! Java_Leave()
  set.shiftwidth=2¬
  set.tabstop=2¬
endfu
autocmd! BufEnter *.{java} call Writting_Enter()
autocmd! BufLeave *.{java} call Writting_Leave()
