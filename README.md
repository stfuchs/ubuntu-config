## Custom installation paths:
$HOME/apps acts as root environment for installations when no admin rights are
available, or when software does not need an installation

	$HOME/apps/usr/share/
	$HOME/apps/usr/bin/
	$HOME/apps/etc/
	$HOME/apps/bin/


## Things to install manually: ##
- parallel: http://www.gnu.org/software/parallel/
- Generic colorizer: http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
- emacs
- terminator (copy in this repository)

## Things to install on new ubuntu: ##

	sudo apt-get install aptitude
	sudo aptitude install git
	echo '#!/bin/sh' > $HOME/.bash_aliases
	echo 'source $HOME/git/ubuntu_config/bash/bashrc' >> $HOME/.bash_aliases
	source $HOME/.bashrc
  api build-essential
  echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
  apud
  sudo apt-get --allow-unauthenticated install sur5r-keyring
  apud
	api i3
  sudo add-apt-repository ppa:xorg-edgers/ppa
  apud
  api nvidia-* #check version on: http://www.nvidia.com/Download/index.aspx
  sudo software-properites-gtk
  gconftool-2 --load $HOME/git/ubuntu_config/gconf/gnome-terminal.gconf.xml

	sudo apt-get autoremove --purge ubuntuone-client-data
	sudo apt-get autoremove --purge software-center
	sudo apt-get autoremove --purge rhythmbox
	sudo apt-get autoremove --purge totem-common
	sudo apt-get autoremove --purge thunderbird*
	sudo apt-get autoremove --purge firefox*
	sudo apt-get autoremove --purge unity-webapps-common
	sudo apt-get autoremove --purge zeitgeist-core

	sudo apt-get autoremove --purge compiz compiz-gnome compiz-plugins-default libcompizconfig0
	sudo apt-get purge unity-scope-home
	sudo apt-get autoremove --purge deja-dub
	sudo apt-get autoremove --purge unity
	sudo apt-get autoremove --purge unity-services
	sudo apt-get autoremove --purge unity-lens-*
	sudo apt-get autoremove --purge unity-scope-*
	sudo apt-get autoremove --purge libunity-misc4
	sudo apt-get autoremove --purge appmenu-qt*
	sudo apt-get autoremove --purge overlay-scrollbar*
	gsettings set org.gnome.desktop.background show-desktop-icons false

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