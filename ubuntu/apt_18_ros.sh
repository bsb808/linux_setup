#!/bin/bash

# accept packages from ROS
echo Accept packages from ROS...

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

apt update

# ROS Base
DIST="melodic"
apt install ros-${DIST}-desktop-full

# ROS Extras
apt install \
    ros-${DIST}-rqt-robot-plugins \
    ros-${DIST}-effort-controllers \
    ros-${DIST}-joy \
    ros-${DIST}-teleop-twist-joy \
    ros-${DIST}-teleop-twist-keyboard \
    ros-${DIST}-teleop-tools \
    ros-${DIST}-joy-teleop \
    ros-${DIST}-key-teleop \
    ros-${DIST}-geographic-info \
    ros-${DIST}-move-base \
    ros-${DIST}-robot-localization \
    ros-${DIST}-robot-state-publisher \
    ros-${DIST}-xacro \
    ros-${DIST}-rqt \
    ros-${DIST}-rqt-common-plugins

apt upgrade libignition-math2

#     ros-${DIST}-multimaster-fkie \
rosdep init || echo Ignore error if rosdep is already initialized
