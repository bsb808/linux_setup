#!/bin/bash
#
# ROS install script
#
# Based on looking at installations using the following command...
# dpkg --get-selections | grep -v deinstall | grep indigo

# Following installation instructions from here...
# http://wiki.ros.org/indigo/Installation/Ubuntu

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

#apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

apt-get update

apt-get install -y ros-indigo-desktop-full

apt-get install -y python-rosinstall

# Other NPS specific packages
apt-get -y install \
    ros-indigo-gazebo-ros-control \
    ros-indigo-gazebo-ros-pkgs \
    ros-indigo-husky-base \
    ros-indigo-husky-bringup \
    ros-indigo-husky-control \
    ros-indigo-husky-description \
    ros-indigo-husky-desktop \
    ros-indigo-husky-gazebo  \
    ros-indigo-husky-msgs \
    ros-indigo-husky-navigation \
    ros-indigo-husky-simulator \
    ros-indigo-husky-viz \
    ros-indigo-phidgets-api \
    ros-indigo-phidgets-drivers \
    ros-indigo-phidgets-imu \
    ros-indigo-phidgets-ir \
    ros-indigo-teleop-twist-joy \
    ros-indigo-teleop-twist-keyboard \
    ros-indigo-joy-teleop \
    ros-indigo-um7
