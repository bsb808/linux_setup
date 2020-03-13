#!/bin/bash

# Optional, but nice to have applications for Ubuntu 18
distro="melodic"
apt install ros-${distro}-desktop-full

apt install \
    ros-${distro}-rqt-robot-plugins \
    ros-${distro}-effort-controllers \
    ros-${distro}-gazebo-ros-control \
    ros-${distro}-gazebo-ros-pkgs \
    ros-${distro}-teleop-twist-joy \
    ros-${distro}-teleop-twist-keyboard \
    ros-${distro}-joy-teleop \
    ros-${distro}-multimaster-fkie \
    ros-${distro}-geographic-info \
    ros-${distro}-move-base \
    ros-${distro}-hector-gazebo \
    ros-${distro}-hector-gazebo-plugins
