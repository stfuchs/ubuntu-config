#!/bin/sh

# Configuration

CONFIG_VERSION=1000

if [ $# -lt 1 ];  then
    echo "please provide install directory" && exit 1
fi

DIR=$1.privat_ubuntu_config

mkdir -v $DIR

# create uninstall script:
#echo '#!/bin/sh' > $DIR/uninstall.sh
#echo '# auto-generated uninstall.sh' >> $DIR/uninstall.sh
#echo '# version '$CONFIG_VERSION >> $DIR/uninstall.sh
#echo 'BASEDIR=$(dirname $0)' >> $DIR/uninstall.sh
#echo 'cd $BASEDIR' >> $DIR/uninstall.sh

# set up bash:
echo "\n\n################## setting up bash configuration #################\n"
cp -rfv bash/ $DIR

if [ -f $HOME/.bash_aliases ]; then
    mv $HOME/.bash_aliases $HOME/.bash_aliases_bak
fi
echo '#!/bin/sh' > $HOME/.bash_aliases
echo "source $DIR/bash/bashrc" >> $HOME/.bash_aliases

# create new root for user installation:
echo "\n\n################## creating new root for user installation #################\n"
UROOT=$DIR/user_root
mkdir -pv $UROOT/bin
mkdir -pv $UROOT/usr/bin
mkdir -pv $UROOT/usr/share/man/man1
mkdir -pv $UROOT/etc

echo "export PATH=$UROOT/bin:$UROOT/usr/bin:\$PATH" >> $DIR/bash/bashrc
echo "export MANPATH=$UROOT/usr/share/man:\$MANPATH" >> $DIR/bash/bashrc

# set up emacs:
echo "\n\n################## setting up emacs configuration #################\n"
cp -rfv emacs/ $DIR
if [ -f $HOME/.emacs.el ]; then
    mv $HOME/.emacs.el $HOME/.emacs_bak.el
fi
echo "(add-to-list 'load-path \"$DIR/emacs\")" > $HOME/.emacs.el
echo "(add-to-list 'load-path \"$DIR/emacs/themes\")" >> $HOME/.emacs.el
echo "(require 'my_config)" >> $HOME/.emacs.el
mkdir -pv $HOME/.emacs.d/cache

# TODO: download emacs if not installed yet

# install grc
GRC_VERSION="1.4"
if [ ! -f $DIR/grc/v$GRC_VERSION ]; then
    echo "\n\n################## installing grc #################\n"
    mkdir -pv $DIR/tmp
    wget -P $DIR/tmp/ http://kassiopeia.juls.savba.sk/~garabik/software/grc/grc_$GRC_VERSION.tar.gz
    tar xf $DIR/tmp/grc_$GRC_VERSION.tar.gz -C $DIR/tmp/
    mkdir -pv $DIR/grc
    mv $DIR/tmp/grc-$GRC_VERSION/conf.* $DIR/grc
    mv $DIR/tmp/grc-$GRC_VERSION/grc $DIR/grc/grc.py
    mv $DIR/tmp/grc-$GRC_VERSION/grcat $DIR/grc/grcat.py
    mv $DIR/tmp/grc-$GRC_VERSION/grc.1 $UROOT/usr/share/man/man1
    mv $DIR/tmp/grc-$GRC_VERSION/grcat.1 $UROOT/usr/share/man/man1
    ln -s $DIR/grc/grc.py $UROOT/bin/grc
    ln -s $DIR/grc/grcat.py $UROOT/bin/grcat
    touch $DIR/grc/v$GRC_VERSION
    rm -rfv $DIR/tmp
fi

if [ ! -f $DIR/terminator/terminator ]; then
    cp -rf terminator $DIR/terminator
    ln -s $DIR/terminator/terminator $UROOT/bin/terminator
    mv $DIR/terminator/doc/terminator.1 $UROOT/usr/share/man/man1
    mkdir -pv $UROOT/usr/share/man/man5
    mv $DIR/terminator/doc/terminator_config.5 $UROOT/usr/share/man/man1
fi
