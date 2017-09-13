#!/bin/bash

# Installation script for Ubuntu 14.04
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

apt-get -y install \
    cifs-utils \
    emacs \
    git \
    gksu \
    gtkterm \
    minicom \
    nautilus-actions \
    gnome-terminal \
    ntp \
    python-numpy python-scipy python-matplotlib ipython \
    ssh \
    subversion \
    openssh-server \
    synaptic \
    vim \
    zip \
    unzip \


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

