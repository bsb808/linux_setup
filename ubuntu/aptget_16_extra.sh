#!/bin/bash

# Installation script for Ubuntu 16.04
# 
# Things to install 'by-hand' using software center
# thunderbird
# chrome or chromium-browser 

# apt-get
apt-get -y install \
    ubuntu-gnome-desktop \
    gconf-editor \
    gparted \
    gksu \
    emacs \
    inkscape \
    pstoedit \
    calibre \
    cifs-utils \
    compizconfig-settings-manager \
    vlc \
    jabref \
    compiz \
    compizconfig-settings-manager \
    compiz-plugins-extra \
    compiz-gnome \
    gimp \
    keepassx \
    pdftk \
    virtualbox \
    virtualbox-ext-pack \
    texlive-full \
    xournal

# Chromium
apt-get -y install \
	chromium-browser \
	chromium-codecs-ffmpeg-extra \
	flashplugin-installer 
# Optional bits
# This one is a bit brittle - so leave it on its own line.
    #sudo apt-get -y install xserver-xorg-core



#flashplugin-installer adobe-flashplugin \
# Codecs
apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
sudo /usr/share/doc/libdvdread4/install-css.sh
apt-get -y install libxine1-ffmpeg mencoder
# Archives
apt-get -y install p7zip-rar p7zip-full unace unrar zip unzip sharutils rar git gimp
#uudeview mpack arj cabextract file-roller

apt-get install --reinstall exfat-fuse exfat-utils

