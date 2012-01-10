" code completion
if has("autocmd")
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  let g:SuperTabDefaultCompletionType = "context"
endif

" python specific!! bicycle repair man is a refactoring tool like rope
" I don't use it normally, because I use rope
if filereadable("/usr/share/vim/addons/ftplugin/python_bike.vim")
  "bicycle repair man is a python refactoring tool
  let g:bike_exceptions = 1
  source /usr/share/vim/addons/ftplugin/python_bike.vim
endif

" rope plugin is also a refactoring tool
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" help pydoc plugin
map <leader>h <leader>pw

" Fold here-doc chunks
let g:sh_fold_enabled=1

" Default to bash for sh syntax
let is_bash=1

" Highlight everything possible for python
let python_highlight_all=1 

" Pyflakes should not use the quickfix window:
let g:pyflakes_use_quickfix = 0

" ---------------------------------------------------------
" Add the virtualenv's site-packages to vim path
if exists("g:python_did_virtualenv")
    finish
endif

let g:python_did_virtualenv = 1

if !exists("$VIRTUAL_ENV")
    finish
endif

python << EOF
import os.path
import sys
import vim
project_base_dir = os.environ['VIRTUAL_ENV']
sys.path.insert(0, project_base_dir)
activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
execfile(activate_this, dict(__file__=activate_this))
EOF
