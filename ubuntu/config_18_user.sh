#!/bin/bash

# Configuration to be done by user (non-sudo)

#gsettings set org.gnome.nautilus.preferences enable-interactive-search true
# Need to change window switching back to alt-tab
# See, http://askubuntu.com/questions/68151/how-do-i-revert-alt-tab-behavior-to-switch-between-windows-on-the-current-worksp

# Copy .emacs
cp ../generic/dot_emacs ~/.emacs

# set ROS environment in command window
ROS_DISTRO="melodic"
if [ -z ${ROS_DISTRO+x} ]; then
    echo Updating your .bashrc file to source ROS Melodic
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    source ~/.bashrc
elif [ "$ROS_DISTRO" == "melodic" ]; then
    echo ROS version is already active, ~.bashrc not changed.
else
    echo Warning: Another ROS version is active, ~.bashrc unchanged.
    echo Please set your .bashrc to select your desired ROS version.
fi

#rosdep update
