#!/bin/bash

# Things to install 'by-hand' using software center
# thunderbird
# chrome

sudo apt-get  install emacs24 

sudo apt-get  install ubuntu-gnome-desktop
    
# apt-get
sudo apt-get  install \
    gconf-editor \
    gparted \
    gksu \
    synaptic \
    ssh \
    subversion \
    inkscape \
    calibre \
    cifs-utils \
    compizconfig-settings-manager \
    vlc \
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
    keepassx \
    xournal \
    python-numpy python-scipy python-matplotlib ipython 

exit
    
# Latex is pretty big - not always necessary
sudo apt-get  install \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-lang-english \
    texlive-science \
    texlive-fonts-recommended \
    texlive-fonts-extra


# This one is a bit brittle - so leave it on its own line.
sudo apt-get  install xserver-xorg-core

#flashplugin-installer adobe-flashplugin \
# Codecs
sudo apt-get  install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
sudo /usr/share/doc/libdvdread4/install-css.sh
sudo apt-get  install libxine1-ffmpeg mencoder
# Archives
sudo apt-get  install p7zip-rar p7zip-full unace unrar zip unzip sharutils rar git gimp
#uudeview mpack arj cabextract file-roller


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
# Set list view as default
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
# Add myself to dialout so I can use serial ports
sudo adduser bsb dialout

