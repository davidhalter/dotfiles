if [ "$1" == '--help' -o "$1" == '-h' ]; then
    echo 'Install dotfiles in your home directory.'
    echo
    echo '  -u          to uninstall.'
    echo '  -h/--help   for help'
    exit 0
fi
is_uninstall="test '$1' == '-u'"

if [ "$1" != '' -a "$1" != '-u' ]; then
    echo "Params don't make sense."
    exit 1
fi

dotfiles_directory=$(dirname $(readlink -f $0))

cd $dotfiles_directory


# search only dotfiles without the own used files
files_to_home=$(ls -A | grep "^\." | grep -v '.swp$\|^\.gitmodules$\|^\.git$\|^\.gitignore$')

for file in $files_to_home; do
    if $is_uninstall; then
        if [ -L ~/$file ]; then
            rm ~/$file && echo "Removed '$file'."
        fi
    elif [ -e ~/$file ]; then
        echo "File '$file' already exists, cannot create a link to it."
    else
        ln -s $dotfiles_directory/$file ~/$file
        echo "Added '$file'."
    fi
done

exit 1

if [ $(type -p git) == '' ]; then 
    echo 'Git not available, cannot install sub repositories properly.'
else
    git submodule init
    git submodule update
    git submodule foreach git submodule init
    git submodule foreach git submodule update
fi
