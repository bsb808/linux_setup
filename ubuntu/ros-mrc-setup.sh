#!/bin/bash

# Serial port
#sudo ./serial-perms.sh

# AMR
cd ~/catkin_ws/src
git clone https://github.com/MobileRobots/amr-ros-config.git
cd ~/catkin_ws
catkin_make

#P2OS
cd ~/catkin_ws/src/
git clone https://github.com/allenh1/p2os.git
cd ~/catkin_ws
catkin_make
source ~/catkin_ws/devel/setup.bash 

# Rosaria
cd ~/catkin_ws/src
git clone https://github.com/amor-ros-pkg/rosaria.git
# Re-setup your ros environment so that the system knows about our new package
source ~/catkin_ws/devel/setup.bash
# Use rosdep to install the dependencies
#rosdep update
rosdep install rosaria

cd ~/catkin_ws/src
#git clone https://github.com/bsb808/nre_p3at.git
git clone git@github.com:bsb808/nre_p3at.git

cd ~/catkin_ws
catkin_make

source ~/catkin_ws/devel/setup.bash


