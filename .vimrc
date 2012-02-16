"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: David Halter <davidhalter88@gmail.com>
"
" Plugins_included:
"     > minibufexpl - not yet used (colors are bad)
"     > fugitive - http://github.com/tpope/vim-fugitive
"       provides a great interface for interacting with git (blame, etc9)
"       KEY: see help files
"           info -> :help fugitive
"
"     > git.vim - https://github.com/tpope/vim-git
"       provides syntax highlighting for git configuration files
"           info -> apparently no help, because it's only a highlighter
"
"     > supertab - https://github.com/ervandew/supertab
"           makes <Tab> an autocompletion feature
"           info -> :help supertab
"
"     > syntastic - https://github.com/scrooloose/syntastic
"       highlights things that are not syntactically correct
"       in many different languages
"       TODO: add support for immedate changes, not just on save/open
"       TODO: add support for red highlighting, like the pyflakes plugin
"           info -> :help pytest
"
"     > vim-surround - https://github.com/tpope/vim-surround
"       used to edit parentheses, tags, etc.
"       Key: e.g. cs"' changes both ends of a string " to ' 
"           info -> :help surround
"
"     > TaskList.vim - https://github.com/vim-scripts/TaskList.vim
"       A tasklist window, that lists all TOD0s in the code and so on.
"       Key: <leader>td
"           info -> there seems to be no help arround
"
"     > taglist-plus - https://github.com/klen/vim-taglist-plus
"       A taglist window, which works for many languages, using exuberant tags
"       Key: <leader>l
"           info -> :help taglist-plus
"
"     > gundo.vim - https://github.com/sjl/gundo.vim
"       Used to look at the history of your saves and restore something
"       Key: <leader>u
"           info -> :help gundo
"
"     > snipMate.vim - https://github.com/davidhalter/vim-snipmate.vim
"       (my own fork, because of some python stuff)
"       Snippets for many languages (similar to TextMate's):
"           info -> :help snipMate
"           Dependencies:
"               https://github.com/MarcWeber/vim-addon-mw-utils.git
"               https://github.com/tomtom/tlib_vim.git
"               https://github.com/honza/snipmate-snippets.git
"
"     > Command-T - https://github.com/wincent/Command-T
"       Command-T plug-in provides an extremely fast,
"       intuitive mechanism for opening files:
"       Caution: Ruby must be installed!
"       FIXME  It is currently not installed, deprecate it?
"           info -> :help CommandT
"           screencast and web-help -> http://amix.dk/blog/post/19501
"
" Python_specific_plugins:
"     > rope-vim - https://github.com/sontek/rope-vim
"       refactoring and 'goto tool' for python
"       Key: <leader>h
"           info -> :help ropevim
"
"     > pytest.vim - https://github.com/alfredodeza/pytest.vim
"       executes all python tests and displays them
"       Key: <leader>t* -> see the definitions
"           info -> :help pytest
"
"     > pep8 - https://github.com/vim-scripts/pep8
"       checks a pyhton file for pep8 compatibility
"       Key: <leader>t* -> see the definitions
"           info -> cannot find the help files
"
"     > pydoc.vim - https://github.com/fs111/pydoc.vim
"       shows the python documentation for a specific command
"       Key: <leader>h
"           info -> cannot find the help files
"
"
" Important_keyboard_changes: -> orderer by importance
"   I changed many things, those are just the important ones, which you should
"   really know. In my opinion it is important, that the more used commands
"   have easier shortcuts. Therefore I switched some commands, like the marks.
"     > mapped jj to <ESC> in normal mode [I really like fast escapes]
"     > changed ; and , [more comfortable]
"     > changed m and ' [to use marks it should be fast available, m is faster]
"     > changed q and @ [again: faster]
"
" Important_addons:
"   - folding with h possible, if you're at the first line.
"   - tabbing is very powerfull, with snippets and autocompletion
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
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

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set tabstop=2       " Tab-Breite
set softtabstop=2   " Tab-Breite
set shiftwidth=2
set expandtab
set nu              " Zeilennummerierung
set nowrap          " Zeilenumbruch deaktivieren
set textwidth=79

" Fold here-doc chunks
let g:sh_fold_enabled=1

" Default to bash for sh syntax
let is_bash=1

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
" TODO make folds open with l and not jump 1 character to the right
function! HFolding(count)
  let counter = a:count
  if (counter == 0)
    let counter = 1
  endif
  let save_cursor = getpos(".")
  if (save_cursor[2] == 1)
    "echo save_cursor[2]
    normal! za
  else
    exec "normal! ".counter."h"
  endif
endfunction
"noremap h :normal! h<CR>
nnoremap h :<C-U>call HFolding(v:count)<CR>
" <C-R>=HFolding()<CR>

set cul                                           " highlight current line
hi CursorLine term=none cterm=none ctermbg=0      " adjust color


" Tabs wechseln
map <C-n> gt
map <C-p> gT
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
" love that ESC is now central in the keyboard
imap jj <ESC>

" change behaviour of , and ; because its much more intuitive
noremap , ;
noremap ; ,

" marks are very tedious to get to, so just change the command
noremap ' m
noremap m '

" the same is also true for makros.
noremap q @
noremap @ q

" Y should have the same behaviour like D, but instead Y is the same as yy, fix this:
map Y y$

" jump to next row in editor instead of next line
noremap j gj
noremap k gk

" mapleader ö on german/swiss keyboards, feel free to change that, to whatever
" you like
let mapleader="ö"

" insert one char, and still be in normal mode
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap ä :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap Ä :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>


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

" minibufexplorer (MBE) config
" don't load/start minibufexplorer now, because he's not able to color properly
let g:loaded_minibufexplorer = 1
" always display syntax in minibufexpl
let g:miniBufExplForceSyntaxEnable = 1
" for other explorers like TagList
let g:miniBufExplModSelTarget = 1
" omit the buffer number from MBE's buffer display
"let g:miniBufExplShowBufNumbers = 0
" an empty status line instead of "-MiniBufExplorer-"
let g:statusLineText = ""

" colors for MBE
"hi MBENormal term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermbg=yellow ctermfg=white guibg=yellow guifg=white
" buffers that have NOT CHANGED and are VISIBLE
hi MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=Black ctermbg=Blue ctermfg=Gray
" buffers that have CHANGED and are VISIBLE
hi MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black
hi MBENormal ctermfg=cyan

" MBE mappings
" FIXME mbe keys are always being loaded - only load them if MBE is loaded
if g:loaded_minibufexplorer == 0
  nnoremap gt :MBEbn<CR>
  nnoremap gT :MBEbp<CR>
endif


" for the pep8 plugin verifications, must be set before the plugin is loaded
let g:pep8_map='<leader>8'

" definition of the completion field
set completeopt=menuone,longest,preview

" code completion SuperTab config
let g:SuperTabDefaultCompletionType = "context"
" instead of <c-p> as completion, which is backwards
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
" use always c-x c-o -> not c-n
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLongestEnhanced = 1
" let g:SuperTabLongestHighlight = 1

if has("autocmd")
  filetype plugin on
  autocmd FileType html setlocal nosmartindent 

  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

  " close preview if its still open after insert
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

" load pathogen plugins
"call pathogen#runtime_append_all_bundles()
call pathogen#infect('~/.vim/bundle')
call pathogen#helptags()

" the TaskList Plugin
map <leader>td <Plug>TaskList 

" the gundo plugin
nnoremap <leader>u :GundoToggle<CR>

" the TagList Plugin
map <leader>l :TlistToggle<CR>
" updatetime is important, how often the tags are regenerated
set updatetime=500 " in ms

" snipmate wants that (for some snippets)
let g:snips_author = 'David Halter'
" the dot should not match, otherwise it results in very strange bugs in python
let g:snipMateAllowMatchingDot = 0


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
set statusline+=%t                                 " file name
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
" don't show the last edit time, because I don't need it that much
" set statusline+=\ %<%{strftime(\"%Y-%m-%d\ %H:%M\",getftime(expand(\"%:p\")))}
" position of the cursor                " pos:%o\ ascii:%b\ %P 
set statusline+=%*%=\ %l/%L,\ %2*%c%V\ 
set statusline+=%*%{fugitive#statusline()}

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
  set titlestring+=\ -\ Dave's\ VIM " %{v:progname} " Program name
endif
