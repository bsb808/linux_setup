#!/bin/bash

# Installation script for Ubuntu 22.04 base packages

apt -y update
apt -y upgrade
apt -y dist-upgrade

apt install \
    aptitude \
    autoconf \
    libtool \
    cifs-utils \
    cmake \
    curl \
    gdebi \
    git \
    gtkterm \
    iputils-ping \
    minicom \
    nano \
    net-tools \
    ntpdate \
    picocom \
    ntp \
    ntpdate \
    openssh-server \
    ruby \
    ssh \
    openssh-server \
    vim \
    vpnc \
    zip \
    unzip \
    python3-numpy python3-scipy python3-matplotlib ipython3 python3-serial


# For mounting FAT drives
#apt-get install --reinstall exfat-fuse exfat-utils

