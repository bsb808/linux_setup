#!/bin/bash
apt-get update
apt-get install git
mkdir ~/WorkingCopies
cd ~/WorkingCopies
git clone https://github.com/bsb808/linux_setup.git
cd linux_setup
cd ~/WorkingCopies/linux_setup/ubuntu

./newinstall_14.sh

./aptget-ros-indigo.sh

./ros-setup.sh