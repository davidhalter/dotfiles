" normally: autocmd FileType python
setlocal shiftwidth=4 tabstop=4 softtabstop=4
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" enable debugging
if filereadable("~/.vim/ftplugin/vimpdb/VimPdb.vim")
  "source ~/.vim/ftplugin/vimpdb/VimPdb.vim
endif

" Highlight everything possible for python
let g:python_highlight_all=1

" E501: Lines can be 80 characters long (see PEP8).
" W503: Line breaks before binary operators are fine.
" See also https://pycodestyle.readthedocs.io/en/latest/intro.html#error-codes
let g:syntastic_python_flake8_args='--ignore=E501,W503'

" Don't use pylint
let g:syntastic_python_checkers = ['flake8', 'pyflakes']

" Jedi settings
let g:jedi#use_tabs_not_buffers = 1
