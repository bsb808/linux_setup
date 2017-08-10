#!/bin/bash
#
# ROS install script
#

# Ubuntu 12.04 - ROS Hydro
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list' 

wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

sudo apt-get update

sudo apt-get install ros-hydro-desktop
