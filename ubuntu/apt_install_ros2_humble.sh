#!/bin/bash

# Scriptified installation instrucitons from https://docs.ros.org/en/ros2_documentation/humble/Installation/Ubuntu-Install-Debians.html

# Set locale - skip this as not necessary in host install

# Setup Sources
apt install software-properties-common
add-apt-repository universe

apt update && sudo apt install curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null


# Install ROS 2 packages
apt update

apt upgrade

apt install -y ros-humble-desktop
