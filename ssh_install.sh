if [ "$1" == '--help' -o "$1" == '-h' ]; then
    echo 'Install dotfiles in a server accessible by SSH.'
    echo
    echo 'Usage:'
    echo '  ./ssh_install.sh user_name@server'
    echo
    echo '  -h/--help   for help'
    exit 0
fi

if [ "$1" == '' -o "$2" != '' ]; then
    echo "Params don't make sense, look at --help"
    exit 1
fi

# cd to current directory
cd $(dirname $(readlink -f $0))

ssh_server=$1

ssh-copy-id $ssh_server
echo "Added public key to external server"

# copy dotfiles
scp -r . $ssh_server":~/dotfiles/install.sh"
echo "Copied dotfiles"

# install dotfiles
ssh $ssh_server "~/dotfiles/install.sh"
echo "Installed dotfiles"
