#!/bin/bash
cd ~/catkin_ws/src
git clone https://github.com/bsb808/nre_p3at.git
# Re-setup your ros environment so that the system knows about our new package
source ~/catkin_ws/devel/setup.bash
# If everything is working, this should put you in the package directory
roscd nre_p3at