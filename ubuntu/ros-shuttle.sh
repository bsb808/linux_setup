#!/bin/bash
cd ~/catkin_ws/src
git clone https://github.com/bsb808/nre_p3at.git
git clone https://github.com/bsb808/nre_joy.git
git clone https://github.com/bsb808/nre_common.git
git clone https://github.com/amor-ros-pkg/rosaria.git
git clone https://github.com/allenh1/p2os.git
# Re-setup your ros environment so that the system knows about our new package
source ~/catkin_ws/devel/setup.bash

rosdep update
rosdep install rosaria
# Change directory
cd ~/catkin_ws
# Compile source
catkin_make
# Re-setup your ros environment so that the system knows about our new package
source ~/catkin_ws/devel/setup.bash3