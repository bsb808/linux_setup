#!/bin/bash
CMDS=("git config --global http.sslverify false && cd ~/catkin_ws/src && rm -rf kingfisher_gazebo && git clone -b indigo-devel https://github.com/bsb808/kingfisher_gazebo.git")

#CMDS=("cd ~/catkin_ws/src && git clone -b indigo-devel https://github.com/bsb808/kingfisher_gazebo.git")

#cd ~/catkin_ws/src/kingfisher_gazebo && git fetch origin && git checkout -b indigo-devel origin/indigo-devel")