#!/bin/bash

# Basic Ubuntu packages
./apt_18_base.sh

# Some other nice-to-have packages
./apt_18_gnome_extra.sh

# Install ROS
./apt_18_ros.sh

# Gazebo
./apt_18_gazebo.sh

# Admin configurations.
./config_18_sudo.sh





