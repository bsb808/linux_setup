#!/bin/bash

# Installation script for Ubuntu 18.04 Basics
#apt -y update
#apt -y upgrade
#apt -y dist-upgrade

apt -y install \
    aptitude \
    autoconf \
    libtool \
    cifs-utils \
    git \
    gtkterm \
    iputils-ping \
    minicom \
    nano \
    net-tools \
    picocom \
    ntp \
    ntpdate \
    python-numpy python-scipy python-matplotlib ipython \
    python-serial \
    ssh \
    openssh-server \
    vim \
    vpnc \
    zip \
    unzip


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

