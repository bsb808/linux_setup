#!/bin/bash

# Installation script for Ubuntu 14.04
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

apt-get -y install \
    cifs-utils \
    emacs23 \
    git \
    gksu \
    minicom \
    nautilus-open-terminal \
    ntp \
    python-numpy python-scipy python-matplotlib ipython 
    ssh \
    subversion \
    openssh-server \
    synaptic \
    zip \
    unzip \


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

