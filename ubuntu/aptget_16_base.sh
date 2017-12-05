#!/bin/bash

# Installation script for Ubuntu 16.04
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

#    byacc \

apt-get -y install \
    aptitude \
    autoconf \
    flex \
    bison \
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
    ssh \
    subversion \
    openssh-server \
    vim \
    vpnc \
    zip \
    unzip


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

