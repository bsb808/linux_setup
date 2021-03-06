#!/bin/bash

# Installation script for Ubuntu 14.04
# 
# Things to install 'by-hand' using software center
# thunderbird
# chrome or chromium-browser 

# apt-get
sudo apt-get -y install \
    ntp \
    gconf-editor \
    gparted \
    gksu \
    synaptic \
    emacs23 \
    ssh \
    subversion \
    inkscape \
    pstoedit \
    calibre \
    cifs-utils \
    compizconfig-settings-manager \
    vlc \
    nautilus-open-terminal \
    ntp \
    jabref \
    compiz \
    compizconfig-settings-manager \
    compiz-plugins-extra \
    compiz-gnome \
    ipython \
    git \
    gimp \
    python-numpy \
    python-scipy \
    python-matplotlib \
    gnome-session-fallback \
    keepassx \
    xournal \
    python-numpy python-scipy python-matplotlib ipython 

# This one is a bit brittle - so leave it on its own line.
#sudo apt-get -y install xserver-xorg-core

#flashplugin-installer adobe-flashplugin \
# Codecs
sudo apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
sudo /usr/share/doc/libdvdread4/install-css.sh
sudo apt-get -y install libxine1-ffmpeg mencoder
# Archives
sudo apt-get -y install p7zip-rar p7zip-full unace unrar zip unzip sharutils rar git gimp
#uudeview mpack arj cabextract file-roller

sudo apt-get install --reinstall exfat-fuse exfat-utils

#gsettings set org.gnome.nautilus.preferences enable-interactive-search true
# Need to change window switching back to alt-tab
# See, http://askubuntu.com/questions/68151/how-do-i-revert-alt-tab-behavior-to-switch-between-windows-on-the-current-worksp

# Tweaks
cp ../generic/dot_emacs ~/.emacs


# Get rid of overlay scroll bars
gsettings set com.canonical.desktop.interface scrollbar-mode normal
# Enable recursive search
gsettings set org.gnome.nautilus.preferences enable-interactive-search false
# Disable recursive search (type-ahead search)

# Move window buttons to the right side
gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'

apt-get remove indicator-messages


# add myself to the dialout group for permissions to serial ports
#sudo adduser bsb dialout
