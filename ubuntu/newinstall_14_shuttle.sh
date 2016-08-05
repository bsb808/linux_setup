#!/bin/bash

# Installation script for Ubuntu 14.04
# 
# Things to install 'by-hand' using software center
# thunderbird
# chrome or chromium-browser 

# apt-get
apt-get -y install \
    ntp \
    gconf-editor \
    gparted \
    gksu \
    synaptic \
    ssh \
    subversion \
    cifs-utils \
    nautilus-open-terminal \
    git \
    ipython \
    python-numpy \
    python-scipy \
    python-matplotlib \


apt-get install -y --reinstall exfat-fuse exfat-utils

adduser frl dialout
