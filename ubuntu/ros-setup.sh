#!/bin/bash

# Setting up user environment for ROS 
# Follows http://wiki.ros.org/indigo/Installation/Ubuntu

DIST="indigo"
echo "source /opt/ros/${DIST}/setup.bash" >> ~/.bashrc
source /opt/ros/${DIST}/setup.bash

# Setup catkin environment following http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace

#sudo rosdep init
sudo rosdep init
rosdep update

cd ~/catkin_ws/
catkin_make

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/catkin_ws/devel/setup.bash
