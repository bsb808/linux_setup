#!/bin/bash

# Serial port
sudo ./serial-perms.sh

# Git source
cd ~/catkin_ws/src
git clone https://github.com/MobileRobots/amr-ros-config.git
git clone https://github.com/bsb808/nre_p3at.git
git clone https://github.com/bsb808/nre_joy.git
git clone https://github.com/bsb808/nre_common.git
git clone https://github.com/amor-ros-pkg/rosaria.git
git clone https://github.com/allenh1/p2os.git
git clone https://github.com/bsb808/microstrain_3dm_gx5_45.git
git clone https://github.com/bsb808/geonav_transform.git
git clone https://github.com/bsb808/thingmagic_rfid.git
# Check rosaria dependencies
source ~/catkin_ws/devel/setup.bash
rosdep update
rosdep install rosaria
# Make
cd ~/catkin_ws
catkin_make
source ~/catkin_ws/devel/setup.bash 




