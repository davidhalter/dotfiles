"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: David Halter <davidhalter88@gmail.com>
"
" Plugins_included:
"     > fugitive - http://github.com/tpope/vim-fugitive
"       provides a great interface for interacting with git (blame, etc9)
"       KEY: see help files
"           info -> :help fugitive
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
"     > w3m.vim - https://github.com/yuratomo/w3m.vim
"       Text based browsing in vim.
"       w3m must be installed, but it is shipped with most Linux distros.
"       Key: :W3m
"       Key: <leader>w
"
"
" Python_specific_plugins:
"     > pep8 - https://github.com/vim-scripts/pep8
"       checks a pyhton file for pep8 compatibility
"       Key: <leader>t* -> see the definitions
"           info -> cannot find the help files
"
"
" Important_keyboard_changes: -> orderer by importance
"   I changed many things, those are just the important ones, which you should
"   really know. In my opinion it is important, that the more used commands
"   have easier shortcuts. Therefore I switched some commands, like the marks.
"     > mapped jk to <ESC> in normal mode [I really like fast escapes]
"     > changed ; and , [more comfortable]
"     > changed m and ' [to use marks it should be fast available, m is faster]
"     > changed q and @ [again: faster]
"     > s saves
"     > changed # and *, because that's more typical for a german keyboard layout
"     > ä is able to input one character in normal mode and stay there
"     > mapleader: ö
"
" Important_addons:
"   - folding with h possible, if you're at the first line.
"   - tabbing is very powerfull, with snippets and autocompletion
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off        " for some we have to disable it first

if $GOROOT
    set rtp+=$GOROOT/misc/vim
endif

" reset to vim-defaults
if &compatible          " only if not set before:
    set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" --------------------------------------------------------------------------
" Basic Editor settings
" --------------------------------------------------------------------------
filetype on         " automatic file type detection

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set tabstop=4       " number of spaces a tab counts for
set softtabstop=4   " ?
set shiftwidth=4    " spaces for autoindents  
set expandtab       " turn a tabs into spaces
set nu              " use line numbers
set nowrap          " deactive wrapping
set textwidth=79    " text automatically breaks after 79 chars
set modeline        " enable modeline

set ruler           " show cursor position in status bar
set laststatus=2    " use 2 lines for the status bar (happens only when needed?)
set showmode        " show mode in status bar (insert/replace/...)
set showcmd         " show typed command in status bar

set title           " show file in titlebar
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set scrolloff=5     " keep at least 5 lines above/below cursor
set sidescrolloff=5 " keep at least 5 columns left/right of cursor

set autoread        " watch for file changes by other programs
set autowrite       " write current buffer, when running :make
set smarttab        " make <tab> and <backspace> smarter
set ignorecase      " Do case insensitive matching
set smartcase       " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set esckeys         " map missed escape sequences (enables keypad keys)
set autoindent smartindent      " turn on auto/smart indenting

set undolevels=1000 " number of forgivable mistakes
set updatecount=100 " write swap file to disk every 100 chars
set history=200     " remember the last 200 commands
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden          " remember undo after quitting

set lazyredraw      " no redraws in macros
set confirm         " get a dialog when :q, :w, or :wq fails
if has('mouse')
    set mouse=v         " use mouse in visual mode (not normal,insert,command,help mode
endif
" set nobackup        " no backup~ files.

set wildmode=longest:full
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn " ignore this files, for completion
set wildmenu              "a better menu, for opening files

" --------------------------------------------------------------------------
" Folding
" --------------------------------------------------------------------------

if has('folding')
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
        try
          normal! za
        catch /E490/ " (No fold found)
          " we don't want that error, since that is not important (when using h)
        endtry
      else
        exec "normal! ".counter."h"
      endif
    endfunction
    "noremap h :normal! h<CR>
    nnoremap h :<C-U>call HFolding(v:count)<CR>
    " <C-R>=HFolding()<CR>
endif

" --------------------------------------------------------------------------
" User commands
" --------------------------------------------------------------------------

" Tabs wechseln
map <C-n> gt
map <C-p> gT
map <C-t> :tabnew<Space>
" Indent
"map <C-i> 0i<Tab><Esc>

" faster scrolling with control
map <C-j> 5j
map <C-k> 5k
map <C-l> 5l
map <C-h> 5h

" love that ESC is now central in the keyboard
imap jk <ESC>

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

" for german keyboard layout better
noremap # *
noremap * #

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
let s:execution_counter = 4       " start with <F4> as mappings
function! SetExecute()
  let cur_file = expand("%")
  let perm = getfperm(cur_file)

  if perm[2] == 'x' || perm[5] == 'x' ||  perm[8] == 'x'
    " this means it is an execution, therefore just execute
    let str = '!./'.cur_file
  else
    " no execution - try to do it differently
    if &filetype == 'python'
      if stridx(cur_file, 'test_') == 0
        let str = '!py.test '.cur_file
      else
        let str = '!python '.cur_file
      end
    elseif &filetype == 'php'
      let str = '!php '.cur_file
    elseif &filetype == 'vim'
      let str = 'source '.cur_file
    elseif &filetype == 'sh'
      let str = '!sh '.cur_file
    elseif &filetype == 'c' || &filetype == 'cpp'
      let without_ft = substitute(cur_file, '\v\.(cc|cpp|h|c)', '', '')
      let str = '!make && ./'.without_ft
    else
      let str = cur_file
    endif
  endif
  let full = ':map <F'.s:execution_counter.'> :w<Enter> :'.str.'<Enter>'
  echohl WarningMsg " we like to have a red warning
  call inputsave()
  let full_ack = input('add execution: ', full, 'file')
  call inputrestore()
  echohl None

  exec full_ack

  " handle execution_counter (which F__ Key is called)
  let s:execution_counter += 1
  if s:execution_counter > 11 " reset counter if too high, but this shouldn't happen...
    let s:execution_counter = 3
  endif

endfunction

map <F12> :call SetExecute()<CR>
imap <F12> <ESC><F12>
imap <F11> <ESC><F11>
imap <F10> <ESC><F10>
imap <F9> <ESC><F9>
imap <F8> <ESC><F8>
imap <F7> <ESC><F7>
imap <F6> <ESC><F6>
imap <F5> <ESC><F5>
imap <F4> <ESC><F4>
set pastetoggle=<F2>

" aliase setzen
command! Q      q
command! W      w
command! Wq     wq
command! WQ     wq

" Sudo write
if executable('sudo') && executable('tee')
  command! SUwrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif
cmap w!! SUwrite

" I don't use s much, so use it save, i use that a lot more.
map s :w<CR>

" Auto-reload vimrc on save
if has("autocmd")
  " is to slow!
  " autocmd bufwritepost .vimrc source $MYVIMRC
endif

" quickly edit the python settings
map <leader>vp :tabnew ~/.vim/ftplugin/python.vim<cr>

map <leader>vv :tabnew ~/.vimrc<cr>        " quickly edit this file
map <leader>vs :source ~/.vimrc<cr>        " quickly source this file

" --------------------------------------------------------------------------
" Plugins enable/disable
" --------------------------------------------------------------------------

" don't load/start minibufexplorer now, because he's not able to color properly
let g:loaded_minibufexplorer = 1
if !executable('w3m')
  let g:loaded_w3m = 1
endif

" --------------------------------------------------------------------------
" Plugins settings
" --------------------------------------------------------------------------

" minibufexplorer (MBE) config
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

" --------------------------------------------------------------------------
" Language settings (setting it late is important)
" --------------------------------------------------------------------------
" 
" There are also files in the ftplugin directory, which do this for python.

" shell
let g:sh_fold_enabled=1 " Fold here-doc chunks
let is_bash=1           " Default to bash for sh syntax

"html/xml
set matchpairs+=<:>     " specially for html


set omnifunc=syntaxcomplete#Complete " set a basic complete function
if has("autocmd")
  filetype plugin on
  autocmd FileType html setlocal nosmartindent 

  " done by jedi plugin
  "autocmd FileType python set omnifunc=jedi#completions
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

  autocmd BufRead,BufNewFile *.go set filetype=go

  " smartindent:
  " When typing '#' as the first character in a new line, the indent for    
  " that line is removed, the '#' is put in the first column.  The indent   
  " is restored for the next line. 
  " If you don't want this, use this        
  " mapping: ":inoremap # X^H#", where ^H is entered with CTRL-V CTRL-H.    
  " When using the ">>" command, lines starting with '#' are not shifted                 
  " right.
  autocmd FileType python,php,vim inoremap # X#
endif

" load pathogen plugins
"call pathogen#runtime_append_all_bundles()
call pathogen#infect('~/.vim/bundle')
call pathogen#helptags()

" the TaskList Plugin
map <leader>td <Plug>TaskList 

" the gundo plugin
nnoremap <leader>u :GundoToggle<CR>

" Tagbar plugin
map <leader>l :TagbarToggle<CR>
" updatetime is important, how often the tags are regenerated
set updatetime=500 " in ms

" snipmate wants that (for some snippets)
let g:snips_author = 'David Halter'
" the dot should not match, otherwise it results in very strange bugs in python
let g:snipMateAllowMatchingDot = 0

" w3m plugin
let g:w3m#search_engine = "https://www.google.com/search?q="
map <leader>w :W3mTab 


" --------------------------------------------------------------------------
" Highlighting stuff
" --------------------------------------------------------------------------

" basic color scheme
set background=dark
highlight Normal guifg=white guibg=black " ctermbg=black ctermfg=white
" let g:colors_name = "dave" " my very own color scheme

" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  syntax on           " syntax-highlighting
  set hlsearch        " Highlight search terms (very useful!)
  set incsearch       " Show search matches while typing
endif

" make a ruler at line 80
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


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

if filereadable($HOME.'/.vim/bundle/syntastic/plugin/syntastic.vim')
  " syntax checking with syntastic
  let g:syntastic_check_on_open=1
  " set statusline+=%#warningmsg#                    " switch to warning highlight
  set statusline+=%2*%{SyntasticStatuslineFlag()}    " syntastic warnings -> compiler warnings
endif

set statusline+=%1*                                " switch to different color
" formating the time: http://vim.wikia.com/wiki/Writing_a_valid_statusline
" don't show the last edit time, because I don't need it that much
" set statusline+=\ %<%{strftime(\"%Y-%m-%d\ %H:%M\",getftime(expand(\"%:p\")))}

" position of the cursor                " pos:%o\ ascii:%b\ %P 
set statusline+=%*%=\ %l/%L,\ %2*%c%V\ 

if executable('git') && filereadable($HOME.'/.vim/bundle/fugitive/plugin/fugitive.vim')
    set statusline+=%*%{fugitive#statusline()}
endif

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

" Always jump to the last known cursor position. 
" Don't do it when the position is invalid or when inside
" an event handler (happens when dropping a file on gvim). 
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

set cul                                           " highlight current line
hi CursorLine term=none cterm=none ctermbg=0      " adjust color

" --------------------------------------------------------------------------
" gVim / desktop stuff - should work for MacVim, too
" --------------------------------------------------------------------------

if has("ballooneval") " only available in gvim
  set ballooneval   " balloons are little hover menus
endif

" opens a tab for every new buffer and switches to the right ones
if has("switchbuf")
    set switchbuf=usetab,newtab
endif

