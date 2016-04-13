#!/bin/bash
#
# ROS install script
#
# Based on looking at installations using the following command...
# dpkg --get-selections | grep -v deinstall | grep indigo

# Following installation instructions from here...
# http://wiki.ros.org/indigo/Installation/Ubuntu

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116

sudo apt-get update

sudo apt-get install ros-indigo-desktop-full

