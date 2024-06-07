#!/bin/bash

# Optional, but nice to have applications for Ubuntu

# apt-get
apt install \
    gparted \
    emacs \
    ffmpeg \
    inkscape \
    pstoedit \
    calibre \
    cifs-utils \
    vlc \
    gimp \
    rar \
    p7zip-rar \
    p7zip-full \
    python3-pip \
    unace \
    unrar \
    sharutils \
    terminator \
    texlive \
    texlive-latex-extra \
    texlive-science \
    texlive-publishers \
    texlive-bibtex-extra \
    jabref \
    latexmk \
    xournalpp

# Docker - see
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    

 #  chromium-browser \
#	chromium-codecs-ffmpeg-extra \
#	flashplugin-installer \
#	ubuntu-restricted-extras



#flashplugin-installer adobe-flashplugin \
# Codecs
#apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
#sudo /usr/share/doc/libdvdread4/install-css.sh
#apt-get -y install libxine1-ffmpeg mencoder


#apt-get install --reinstall exfat-fuse exfat-utils
