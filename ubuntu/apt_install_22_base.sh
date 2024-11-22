#!/bin/bash

# Installation script for Ubuntu 22.04 base packages

apt -y update
apt -y upgrade
apt -y dist-upgrade

apt install \
    autoconf \
    libtool \
    cifs-utils \
    cmake \
    curl \
    git \
    iputils-ping \
    nano \
    net-tools \
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

