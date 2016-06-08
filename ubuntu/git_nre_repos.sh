#!/bin/bash
cd ~/catkin_ws/src
git clone git@github.com:bsb808/nre_simmultihusky.git
git clone git@github.com:bsb808/nre_common.git
git clone git@github.com:bsb808/nre_joy.git
git clone git@github.com:bsb808/nre_p3at.git

git clone https://github.com/MobileRobots/amr-ros-config
git clone https://github.com/allenh1/p2os.git

cd ~/catkin_ws
catkin_make