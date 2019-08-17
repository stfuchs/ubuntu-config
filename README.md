## Custom installation paths:
$HOME/apps acts as root environment for installations when no admin rights are
available, or when software does not need an installation

    $HOME/apps/usr/share/
    $HOME/apps/usr/bin/
    $HOME/apps/etc/
    $HOME/apps/bin/
    cp config.site $HOME/apps/usr/share/
    export PYTHONUSERBASE=$HOME/apps/usr
    wget https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py --user


## Things to install manually: ##
- parallel: http://www.gnu.org/software/parallel/
- Generic colorizer: http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
- emacs
- terminator (copy in this repository)

## Things to install on new ubuntu: ##

    sudo apt-get install aptitude
    sudo aptitude install git
    ssh-keygen -t rsa -b 4096 -C "st.fuchs.tr@gmail.com"
    ssh-add ~/.ssh/id_rsa
    mkdir git
    git clone git@github.com:stfuchs/ubuntu-config.git git/ubuntu-config
    ln -s git/ubuntu-config/git/config ~/.gitconfig
    wget https://bootstrap.pypa.io/get-pip.py
    sudo -H python get-pip.py
    sudo -H pip install powerline-status

    cd /tmp
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts && mv PowerlineSymbols.otf ~/.fonts/
    mkdir -p ~/.config/fontconfig/conf.d && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    cp ~/git/ubuntu-config/fontawesome/fontawesmoe-webfont.ttf  ~/.fonts/
    cp ~/git/ubuntu-config/fontawesome/10-fontawesome-symbols.conf ~/.config/fontconfig/conf.d/
    fc-cache -vf ~/.fonts/
    ln -s ~/git/ubuntu-config/powerline ~/.config/powerline
    powerline-daemon --replace

    echo '#!/bin/sh' > $HOME/.bash_aliases
    echo 'source $HOME/git/ubuntu-config/bash/bashrc' >> $HOME/.bash_aliases
    source $HOME/.bashrc

    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt update
    sudo apt upgrade
    sudo apt install emacs-snapshot
    sudo sh -c 'echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list'

    sudo apt-get --allow-unauthenticated install sur5r-keyring
    sudo apt install i3 keychain
    mkdir -p ~/.config/i3 && mkdir -p ~/.config/i3status
    cp ~/git/ubuntu-config/i3/config ~/.config/i3/
    cp ~/git/ubuntu-config/i3status/config ~/.config/i3status/
    mkdir -p ~/.config/terminator
    cp ~/git/ubuntu-config/terminator/config ~/.config/terminator/

    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    api nodejs
    sudo npm install -g i3-style

    sudo add-apt-repository ppa:xorg-edgers/ppa
    sudo apt install nvidia-* #check version on: http://www.nvidia.com/Download/index.aspx
    sudo software-properites-gtk
    gconftool-2 --load $HOME/git/ubuntu-config/gconf/gnome-terminal.gconf.xml

    api libxss1 libappindicator1 libindicator7
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome*.deb


## On Mac: ##
    sudo add-apt-repository ppa:mactel-support
    sudo apt-get update
    sudo apt-get install macfanctld
    sudo nano /etc/apt/sources.list.d/mactel-support-ppa-trusty.list
    replace "trusty" with "raring"
    setxkbmap -layout de -variant mac
