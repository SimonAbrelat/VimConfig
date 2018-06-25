" GENERAL CONFIG
" History
set history=500
" senses filetypes
filetype plugin on
filetype indent on
" checks for outside changes
set autoread
" better leader
" let leader = ";"
" fact save
nmap <leader>w :w!<cr>
" displays colors
syntax on

" UI
" curser
set cursorline
set ruler
" searching
set ignorecase
set smartcase
set hlsearch
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
" line breaks
set lbr
set tw=125
" indent
set ai
set si
set wrap

" GENERIC KEY BINDINGS
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/autoload/plugged')

" Misc
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LANGS
Plug 'vim-python/python-syntax'
Plug 'stevearc/vim-arduino'

" THEMES
Plug 'morhetz/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark

" ARDUINO KEY BINDINGS
nnoremap <buffer> <leader>m :ArduinoVerify<CR>
nnoremap <buffer> <leader>u :ArduinoUpload<CR>
nnoremap <buffer> <leader>d :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>b :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>p :ArduinoChooseProgrammer<CR>
let g:arduino_cmd = '/usr/share/arduino/arduino'
let g:arduino_dir = '~/.arduino15/'
let g:arduino_run_headless = 1

" SYNTASTIC
"let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checker = ["flake8"]
let g:syntastic_cpp_checker = ["clang++"]
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
