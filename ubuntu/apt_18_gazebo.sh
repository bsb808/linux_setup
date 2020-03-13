#!/bin/bash

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


