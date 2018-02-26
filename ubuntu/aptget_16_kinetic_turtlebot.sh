#!/bin/bash
apt-get install -y linux-headers-generic
sh -c 'echo "deb-src http://us.archive.ubuntu.com/ubuntu/ xenial main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-updates main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://security.ubuntu.com/ubuntu xenial-security main restricted" > \
  /etc/apt/sources.list.d/official-source-repositories.list'
apt-get update
apt-get install -y ros-kinetic-librealsense
apt-get install -y ros-kinetic-librealsense-camera
apt-get install -y ros-kinetic-turtlebot
apt-get install -y ros-kinetic-joy ros-kinetic-joystick-drivers ros-kinetic-teleop-twist-joy
