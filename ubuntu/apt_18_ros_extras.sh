#!/bin/bash

# Optional, but nice to have applications for Ubuntu 18
DIST="melodic"
apt install ros-${DIST}-desktop-full

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
