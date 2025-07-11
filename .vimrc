"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: David Halter <davidhalter88@gmail.com>
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
set modeline        " enable modeline
set textwidth=79    " text automatically breaks after 79 chars

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
set noswapfile     " no swap files; I have tried and never used them for years.

set wildmode=longest:full
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn " ignore this files, for completion
set wildmenu              "a better menu, for opening files

set tabpagemax=100  " VIM should open all given options when using -p
set belloff=all


" --------------------------------------------------------------------------
" Folding
" --------------------------------------------------------------------------

if has('folding')
    set foldmethod=indent     " folding works with indents
    set foldlevel=99          " The higher the more folded regions are open.
    set foldnestmax=1         " foldnestmax is the limit for nesting folds
endif

" --------------------------------------------------------------------------
" User commands
" --------------------------------------------------------------------------

" Switch tabs
map <C-n> gt
map <C-p> gT
map <C-t> :tabnew<Space>

" faster scrolling with control
map <C-j> 5j
map <C-k> 5k
map <C-l> 5l
map <C-h> 5h

" I love that ESC is now central in the keyboard
imap jk <ESC>

" Y should have the same behaviour like D, but instead Y is the same as yy, fix this:
map Y y$

" Jump to next row in editor instead of next line
noremap j gj
noremap k gk

" Sudo write with :w!!
if executable('sudo') && executable('tee')
  command! SUwrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif
cmap w!! SUwrite

" I don't use s much, so use it save, i use that a lot more.
map s :w<CR>

" --------------------------------------------------------------------------
" Plugins settings
" --------------------------------------------------------------------------

" colors for MBE
"hi MBENormal term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermbg=yellow ctermfg=white guibg=yellow guifg=white
" buffers that have NOT CHANGED and are VISIBLE
hi MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=Black ctermbg=Blue ctermfg=Gray
" buffers that have CHANGED and are VISIBLE
hi MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black
hi MBENormal ctermfg=cyan

" definition of the completion field
set completeopt=menuone,longest,preview,noselect

" code completion SuperTab config
let g:SuperTabDefaultCompletionType = "context"
" use always c-x c-o -> not c-n
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLongestEnhanced = 1

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
autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2

" VIM started introducing weird characters
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

set omnifunc=syntaxcomplete#Complete " set a basic complete function
if has("autocmd")
  filetype plugin on
  autocmd FileType html setlocal nosmartindent 
  " The ftplugin sometimes overwrites it

  autocmd BufRead,BufNewFile *.go set filetype=go
  autocmd BufNew,BufNewFile,BufRead *.tsx,*.ts set filetype=javascript | ALEDisable
  autocmd BufNew,BufNewFile,BufRead *.rs ALEDisable
  autocmd BufNew,BufNewFile,BufRead *.rs ALEDisable
  autocmd BufWritePre *rs call clearmatches()

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

let g:jedi#goto_definitions_command = "<leader>t"
let g:jedi#smart_auto_mappings = 1

call plug#begin()
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim', { 'branch': 'master' }
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-fugitive'
call plug#end()

let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_log_file = 1
"let g:lsp_show_message_log_level = "log"

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ 'initialization_options': {
        "\     'checkOnSave': {'command': 'clippy'},
        \   },
        \ })
endif

if executable('zubanls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ZubanLS',
        \ 'cmd': ['zubanls'],
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    if &filetype != "python"
        setlocal omnifunc=lsp#complete
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gs <plug>(lsp-document-symbol-search)
        nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gs <plug>(lsp-type-definition)
        nmap <buffer> gR <plug>(lsp-rename)
        nmap <buffer> K <plug>(lsp-hover)
    endif
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gn <plug>(lsp-next-diagnostic)
    nmap <buffer> gp <plug>(lsp-previous-diagnostic)
    nmap <buffer> ga <plug>(lsp-code-action)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_float_cursor = 1

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" --------------------------------------------------------------------------
" Highlighting stuff
" --------------------------------------------------------------------------

" basic color scheme
set background=dark
highlight Normal guifg=white guibg=black " ctermbg=black ctermfg=white

" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  syntax on           " syntax-highlighting
  syntax sync minlines=500  " Make highlighting a bit more precise.
  set hlsearch        " Highlight search terms (very useful!)
  set incsearch       " Show search matches while typing
endif

" make a ruler at line 80
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" This felt annoying
autocmd FileType rust highlight rustInvalidBareKeyword ctermfg=NONE guifg=NONE

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

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

if filereadable($HOME.'/.vim/plug/ale/plugin/ale.vim')
  set statusline+=%2*%{LinterStatus()}    " syntastic warnings -> compiler warnings
endif

let g:ale_linters = {
\    'python': ['flake8']
\}
let g:ale_rust_cargo_use_clippy = 1

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
  set titlestring+=\ -\ VIM " %{v:progname} " Program name
endif

" Always jump to the last known cursor position. 
" Don't do it when the position is invalid or when inside
" an event handler (happens when dropping a file on gvim). 
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

set cul                                           " highlight current line
hi CursorLine term=none cterm=none ctermbg=darkgray      " adjust color

function! WordWithDashUnderCursor() abort
    return matchstr(expand("<cWORD>"), '\(\w\|-\)*')
endfunction

map qn :cn<CR>
map qp :cp<CR>
map Q  :echo "Ex mode was disabled, because I don't want to enter it accidentally"<CR>

map <F2> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target  cargo build --features zuban_debug --message-format short"<CR>
map <F3> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target  cargo test mypy --features zuban_debug -- 2>&1 ".WordWithDashUnderCursor()<CR>
map <F4> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target  cargo test mypy --features zuban_debug -- 2>&1 \| tail -n 200"<CR>
map <F5> :execute "!rg -U '(?s)case ".WordWithDashUnderCursor()."\\].*?(\\[case\|\\z)'"<CR>
map <F6> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target RUST_BACKTRACE=1 cargo test mypy --features zuban_debug -- 2>&1 ".WordWithDashUnderCursor()<CR>
map <F7> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target  cargo build --message-format short"<CR>
map <F8> :execute "!CARGO_TARGET_DIR=/tmp/cargo_target  cargo test -- 2>&1"<CR>
