filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible

" syntax-highlighting
set background=dark
syntax on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set tabstop=2       " Tab-Breite
set softtabstop=2   " Tab-Breite
set shiftwidth=2
set expandtab
set nu              " Zeilennummerierung
set nowrap          " Zeilenumbruch deaktivieren

" Liste unten
set ruler
set laststatus=2
set showmode

set title
set backspace=2     " Allow backspacing over everything
set hlsearch        " Highlight search terms
set incsearch       " Show search matches as you type

set scrolloff=5     " keep at least 5 lines above/below cursor
set sidescrolloff=5 " keep at least 5 columns left/right of cursor

set autoread        " watch for file changes by other programs
filetype on         " automatic file type detection
set smarttab                    " make <tab> and <backspace> smarter
set ignorecase      " Do case insensitive matching
set smartcase       " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set autoindent smartindent      " turn on auto/smart indenting

set undolevels=1000 " number of forgivable mistakes
set updatecount=100 " write swap file to disk every 100 chars
set history=200     " remember the last 200 commands

set wildmode=longest:full "a better menu, for opening files"
set wildmenu

set cul                                           " highlight current line
hi CursorLine term=none cterm=none ctermbg=0      " adjust color

" definition of the completion field
set completeopt=menuone,longest,preview

" Tabs wechseln
map <C-n> :tabnext<Enter>
map <C-p> :tabprevious<Enter>
map <C-t> :tabnew<Space>
" Indent
"map <C-i> 0i<Tab><Esc>
" Split wechseln
"map + <C-w>w
" Split-Grösse ändern
"map <C-j> <C-w>+
"map <C-k> <C-w>-
"map <C-h> <C-w><
"map <C-l> <C-w>>

" faster scrolling with control
map <C-j> 5j
map <C-k> 5k
map <C-l> 5l
map <C-h> 5h

" special settings!
imap jj <ESC>
noremap , ;
noremap ; ,
let mapleader="ö"

" Y should have the same behaviour like D, but instead Y is the same as yy, fix this:
map Y y$

" jump to next row in editor instead of next line
noremap j gj
noremap k gk

" execute stuff
map <F12> :map <F5> :w<lt>Enter> :!./<lt>Enter>
imap <F12> <ESC><F12>
imap <F11> <ESC><F11>
imap <F10> <ESC><F10>
imap <F9> <ESC><F9>
imap <F8> <ESC><F8>
imap <F7> <ESC><F7>
imap <F6> <ESC><F6>
imap <F5> <ESC><F5>
set pastetoggle=<F2>

" aliase setzen
command! Q      q
command! W      w
command! Wq     wq
command! WQ     wq


" Auto-reload vimrc on save
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" quickly edit the python settings
map <leader>vp :tabnew ~/.vim/ftplugin/python.vim<cr>

map <leader>vv :tabnew ~/.vimrc<cr>        " quickly edit this file
map <leader>vs :source ~/.vimrc<cr>        " quickly source this file

if has("autocmd")
  filetype plugin on
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType html setlocal nosmartindent 

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

  " close preview if its still open after insert
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

