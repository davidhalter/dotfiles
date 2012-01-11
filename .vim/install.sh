git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

# Ubuntu installs don't need it because ropevim is enough
# used for the Syntastic plugin (just for python)
sudo aptitude install pyflakes
# used for the pep8 plugin
sudo aptitude install pep8
# ctags is used for 
sudo aptitude install exuberant-ctags
