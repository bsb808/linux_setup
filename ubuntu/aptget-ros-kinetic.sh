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
#apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

apt-get update

# Do this to force no questions
#export DEBIAN_FRONTEND=noninteractive


distro="kinetic"
apt-get install -y --force-yes \
	ros-${distro}-desktop \
	ros-${distro}-rosdoc-lite 

# Other NPS specific packages
apt-get -y install -y --force-yes \
    ros-${distro}-gazebo-ros-control \
    ros-${distro}-gazebo-ros-pkgs \
    ros-${distro}-teleop-twist-joy \
    ros-${distro}-teleop-twist-keyboard \
    ros-${distro}-joy-teleop \
    ros-${distro}-multimaster-fkie


apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

