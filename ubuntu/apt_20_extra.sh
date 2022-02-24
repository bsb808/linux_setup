#!/bin/bash

# Optional, but nice to have applications for Ubuntu 18

# apt-get
apt install \
    gparted \
    gnome-shell-extensions \
    gnome-tweak-tool \
    emacs \
    ffmpeg \
    inkscape \
    pstoedit \
    calibre \
    cifs-utils \
    vlc \
    gimp \
    keepassx \
    rar \
    p7zip-rar p7zip-full unace unrar sharutils \
    texlive texlive-latex-extra texlive-science texlive-publishers jabref latexmk \
    xournal 
    
  # Things removed from 18.04
        #dconf-tools \
        #virtualbox \

# Had to remove
#sudo apt remove virtualbox-dkms virtualbox-source virtualbox-modules
#sudo apt purge virtualbox-dkms virtualbox-source virtualbox-modules

 #  chromium-browser \
#	chromium-codecs-ffmpeg-extra \
#	flashplugin-installer \
#	ubuntu-restricted-extras


# Later     texlive-full \
#  jabref \ - looks like need to install this with gui tools
# virtualbox-ext-pack \

# Deprecated.
    # pdftk \  


#flashplugin-installer adobe-flashplugin \
# Codecs
#apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
#sudo /usr/share/doc/libdvdread4/install-css.sh
#apt-get -y install libxine1-ffmpeg mencoder


#apt-get install --reinstall exfat-fuse exfat-utils
