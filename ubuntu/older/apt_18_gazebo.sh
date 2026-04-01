#!/bin/bash

# User OSRF repo for latest gazebo.

sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'

wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

apt update

DIST="melodic"
GAZ="gazebo9"

apt install \
    libeigen3-dev \
    pkg-config \
    protobuf-compiler \
    ${GAZ} \
    lib${GAZ}-dev \
    ros-${DIST}-gazebo-plugins \
    ros-${DIST}-gazebo-ros \
    ros-${DIST}-gazebo-ros-control \
    ros-${DIST}-gazebo-ros-pkgs \
    ros-${DIST}-hector-gazebo \
    ros-${DIST}-hector-gazebo-plugins \
    ros-${DIST}-velodyne-simulator


