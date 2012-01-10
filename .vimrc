filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible

" color scheme
set background=dark
" let g:colors_name = "dave" " my very own color scheme

" syntax-highlighting
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
if has("ballooneval")
  set ballooneval   " balloons are little hover menus
endif
set omnifunc=syntaxcomplete#Complete " set a basic complete function

set title
set backspace=2     " Allow backspacing over everything
set hlsearch        " Highlight search terms
set incsearch       " Show search matches as you type

set scrolloff=5     " keep at least 5 lines above/below cursor
set sidescrolloff=5 " keep at least 5 columns left/right of cursor

set autoread        " watch for file changes by other programs
filetype on         " automatic file type detection
set smarttab        " make <tab> and <backspace> smarter
set ignorecase      " Do case insensitive matching
set smartcase       " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set autoindent smartindent      " turn on auto/smart indenting

set undolevels=1000 " number of forgivable mistakes
set updatecount=100 " write swap file to disk every 100 chars
set history=200     " remember the last 200 commands

set wildmode=longest:full "a better menu, for opening files"
set wildmenu

set foldmethod=indent     " folding works with indents
set foldlevel=99          " The higher the more folded regions are open.
set foldnestmax=1         " foldnestmax is the limit for nesting folds

" if you type h, when the cursor is at position 1, try to fold.
function! HFolding()
  let save_cursor = getpos(".")
  if (save_cursor[2] == 1)
    return "\<ESC>hza"
  else
    return "\<ESC>h"
  endif
endfunction
noremap h a<C-R>=HFolding()<CR>

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
  " is to slow!
  " autocmd bufwritepost .vimrc source $MYVIMRC
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

" for the pep8 plugin verifications, must be set before the plugin is loaded
let g:pep8_map='<leader>8'

" load pathogen plugins
call pathogen#infect('~/.vim/bundle') "runtime_append_all_bundles()
call pathogen#helptags()

" the TaskList Plugin
map <leader>td <Plug>TaskList 

" ---------------------------------------------------------
" user defined colors -> used for the status bar

" since 'white' is not working, I have to select the color with the help
" (cterm-colors) it's basically a little hack with the reversing of the
" colors, but it looks better
" yellow status bar stuff
hi User1 term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermbg=yellow ctermfg=white guibg=yellow guifg=white
" red status bar stuff
hi User2 term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermbg=red ctermfg=white guibg=red guifg=white

" this is the formating of the status bar
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" clear the statusline for when vimrc is reloaded
set statusline= 
" the standard stuff
set statusline+=%F
set statusline+=%1*[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                            " file format
set statusline+=%*%h                               " help file flag
set statusline+=%2*%m%*                            " modified flag
set statusline+=%r                                 " readonly?
set statusline+=%w                                 " ?
set statusline+=%y                                 " filetype

" if exists(":SyntasticCheck") == 2 " check seems not to work, although it should
  " syntax checking with syntastic
  let g:syntastic_check_on_open=1
  " set statusline+=%#warningmsg#                    " switch to warning highlight
  set statusline+=%2*%{SyntasticStatuslineFlag()}    " syntastic warnings -> compiler warnings
" endif

set statusline+=%1*                                " switch to different color
" formating the time: http://vim.wikia.com/wiki/Writing_a_valid_statusline
set statusline+=\ %<%{strftime(\"%Y-%m-%d\ %H:%M\",getftime(expand(\"%:p\")))}
" position of the cursor
set statusline+=%=%*\ %l/%L,\ %2*%c%V\ " pos:%o\ ascii:%b\ %P 

" now set it up to change the status line based on mode
" I removed it again, because it makes the editor nervous, with all the
" switching
if version >= 700
  " au InsertEnter * hi StatusLine ctermfg=6 | hi User1 ctermfg=6 | hi User2 ctermfg=6
  " au InsertLeave * hi StatusLine ctermfg=7 | hi User1 ctermfg=7 | hi User2 ctermfg=7
endif
" ---------------------------------------------------------

" Fancy window titles where possible
if has('title') && (has('gui_running') || &title)
  set titlestring=
  set titlestring+=%F " File name
  set titlestring+=\ -\ Dave's\ %{v:progname} " Program name
endif



