#!/bin/bash

if [ ! -f $HOME/.bash_aliases ]; then
    echo "Creating .bash_aliases"
    echo '#!/bin/sh' > $HOME/.bash_aliases
    echo 'source $HOME/git/ubuntu-config/bash/bashrc' >> $HOME/.bash_aliases
    . $HOME/.bashrc
fi

# config terminator
mkdir -v -p $HOME/.config/terminator
cp -v terminator/config $HOME/.config/terminator/

# config git
cp -v git/config $HOME/.gitconfig

# emacs cache
mkdir -v -p $HOME/.emacs.d/cache
