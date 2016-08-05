#!/bin/bash

# Setting up user environment for ROS 
# Follows http://wiki.ros.org/indigo/Installation/Ubuntu

echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source /opt/ros/indigo/setup.bash

# Setup catkin environment following http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace

rosdep init
rosdep update

cd ~/catkin_ws/
catkin_make

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/catkin_ws/devel/setup.bash