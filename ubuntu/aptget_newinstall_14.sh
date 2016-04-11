#!/bin/bash
#apt-cache search <search_term>

#apt-get update
#./aptget_newinstall.sh

# Not for 10.04
sudo apt-get install -f \
gnome-panel \
    compiz \
    compizconfig-settings-manager \
    compiz-gnome \
    ipython \
    spyder \

sudo apt-get install --reinstall exfat-fuse exfat-utils
