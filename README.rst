Dotfiles
========

.. warning:: My dotfiles also contain my git config, which means that you would
   commit using my mail address. So fork this first, or define your own
   ``.gitconfig`` (which the install script doesn't overwrite).

My dotfiles:

- VIM config: ``.vimrc``, ``.vim``
- bash config: ``.bashrc.local``
- git config: ``.gitconfig``
- readline config: ``.inputrc``
- W3M config: ``.w3m``


Installation
------------

You can install these files by using:

    ./install.sh

If you also want to install the dependencies (only ubuntu/debian until now):

    install_dependencies.sh

SSH-Installation
----------------

Once installed, it's possible to use the ssh installer, which has been created
to install the system on different systems:

    ./ssh_install.sh user_name@server

It automatically adds your ssh public key to the ``authorized_keys`` on the
other side, using ``ssh-copy-id``.
