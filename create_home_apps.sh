#!/bin/sh

# set up directory structure
mkdir -pv $HOME/apps/bin

mkdir -pv $HOME/apps/usr/bin
mkdir -pv $HOME/apps/usr/lib
mkdir -pv $HOME/apps/usr/include
mkdir -pv $HOME/apps/usr/share/man/man1

mkdir -pv $HOME/apps/usr/local/bin
mkdir -pv $HOME/apps/usr/local/lib
mkdir -pv $HOME/apps/usr/local/include
mkdir -pv $HOME/apps/usr/local/share

# install grc
GRC_VERSION="1.5"
GRC_INSTALL_DIR=$HOME/apps/usr/share/grc-$GRC_VERSION

if [ ! -f $GRC_INSTALL_DIR/v$GRC_VERSION ]; then
    echo "\n\n################## installing grc #################\n"
    mkdir -pv $HOME/apps/tmp
    wget -P $HOME/apps/tmp/ http://kassiopeia.juls.savba.sk/~garabik/software/grc/grc_$GRC_VERSION.tar.gz
    tar xf $HOME/apps/tmp/grc_$GRC_VERSION.tar.gz -C $HOME/apps/tmp/
    mkdir -pv $GRC_INSTALL_DIR
    mv $HOME/apps/tmp/grc-$GRC_VERSION/conf.* $GRC_INSTALL_DIR
    mv $HOME/apps/tmp/grc-$GRC_VERSION/grc $GRC_INSTALL_DIR/grc.py
    mv $HOME/apps/tmp/grc-$GRC_VERSION/grcat $GRC_INSTALL_DIR/grcat.py
    mv $HOME/apps/tmp/grc-$GRC_VERSION/grc.1 $HOME/apps/usr/share/man/man1
    mv $HOME/apps/tmp/grc-$GRC_VERSION/grcat.1 $HOME/apps/usr/share/man/man1
    ln -s $GRC_INSTALL_DIR/grc.py $HOME/apps/usr/bin/grc
    ln -s $GRC_INSTALL_DIR/grcat.py $HOME/apps/usr/bin/grcat
    touch $GRC_INSTALL_DIR/v$GRC_VERSION
    rm -rfv $HOME/apps/tmp
fi

TERM_DIR=$HOME/apps/usr/share/terminator
if [ ! -f $TERM_DIR/terminator ]; then
    echo "\n\n################## installing terminator #################\n"
    cp -rf terminator $HOME/apps/usr/share/
    ln -s $TERM_DIR/terminator $HOME/apps/bin/terminator
    mv $TERM_DIR/doc/terminator.1 $HOME/apps/usr/share/man/man1
    mkdir -pv $HOME/apps/usr/share/man/man5
    mv $TERM_DIR/doc/terminator_config.5 $HOME/apps/usr/share/man/man1
    if [ ! -f $HOME/.config/terminator/config ]; then
        mkdir -pv $HOME/.config/terminator
    fi
    mv $TERM_DIR/config $HOME/.config/terminator/
fi
# also: create keyboard shortcut in system settings > keyboard > shortcuts
# command: python $HOME/apps/bin/terminator


EMACS_VERSION=24.3
EMACS_DIR=$HOME/apps/usr
if [ ! -f $HOME/apps/usr/share/emacs/v$EMACS_VERSION ]; then
    if [ ! -f $HOME/apps/tmp/emacs-$EMACS_VERSION.tar.gz ]; then
        mkdir -pv $HOME/apps/tmp
        wget -P $HOME/apps/tmp/ http://ftp.gnu.org/pub/gnu/emacs/emacs-$EMACS_VERSION.tar.gz
        wget -P $HOME/apps/tmp/ "http://downloads.sourceforge.net/project/doxymacs/doxymacs/1.8.0/doxymacs-1.8.0.tar.gz"
    fi
    if [ ! -f $HOME/apps/tmp/emacs-$EMACS_VERSION/configure ]; then
        tar -vxf $HOME/apps/tmp/emacs-$EMACS_VERSION.tar.gz -C $HOME/apps/tmp/
        tar -vxf $HOME/apps/tmp/doxymacs-1.8.0.tar.gz -C $HOME/apps/tmp/
    fi
    cd $HOME/apps/tmp/emacs-$EMACS_VERSION/
    ./configure --with-gif=no --prefix=$HOME/apps/usr
    make
    make install prefix:=$HOME/apps/usr
    touch $HOME/apps/usr/share/emacs/v$EMACS_VERSION
    cd $HOME/apps/tmp/doxymacs-1.8.0/
    ./configure --prefix=$HOME/apps/usr
    make
    make install prefix:=$HOME/apps/usr
    rm -rfv $HOME/apps/tmp
fi
