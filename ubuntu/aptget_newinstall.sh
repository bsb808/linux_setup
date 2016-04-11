#!/bin/bash
#apt-cache search <search_term>

#apt-get update

apt-get -f install \
    gconf-editor \
    chromium-browser \
    gparted \
    synaptic \
    emacs23 \
    ssh \
    subversion \
    inkscape \
    calibre \
    compizconfig-settings-manager \
    vlc \
    nautilus-open-terminal \
    jabref \
    qtcreator
    
#aptitude

apt-get remove indicator-messages

apt-get install compiz compizconfig-settings-manager
#aptitude install compizconfig-settings-manager
# Not for 10.04
#apt-get install spyder

# For mouting exfat partitions - large flash drives
apt-add-repository ppa:relan/exfat
apt-get update
apt-get -f install fuse-exfat exfat-utils	

