#!/bin/bash

# Installation script for Ubuntu 16.04
apt -y update
apt -y upgrade
apt -y dist-upgrade

#    byacc \
#     flex \
#     bison \
apt -y install \
    aptitude \
    autoconf \
    libtool \
    cifs-utils \
    git \
    gksu \
    gtkterm \
    minicom \
    picocom \
    gnome-terminal \
    ntp \
    python-numpy python-scipy python-matplotlib ipython \
    python-serial \
    ssh \
    subversion \
    openssh-server \
    vim \
    vpnc \
    zip \
    unzip


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

