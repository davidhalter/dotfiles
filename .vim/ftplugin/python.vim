" code completion
if has("autocmd")
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  let g:SuperTabDefaultCompletionType = "context"
endif

" python specific!!
if filereadable("/usr/share/vim/addons/ftplugin/python_bike.vim")
  "bicycle repair man is a python refactoring tool
  let g:bike_exceptions = 1
  source /usr/share/vim/addons/ftplugin/python_bike.vim
endif

" rope is also a refactoring tool
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

call pathogen#infect('~/.vim/bundle') "runtime_append_all_bundles()
call pathogen#helptags()

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
