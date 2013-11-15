git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

# ctags is used for 
sudo aptitude install exuberant-ctags

# pip is used for all the python install stuff (and should be on every system
# anyway)
sudo aptitude install python-pip

sudo pip install jedi flake8
#sudo pip install vimpdb # doesn't work without vim-server
