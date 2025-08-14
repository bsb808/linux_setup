#!/bin/bash

# Script to switch between different projects.
# set the project variable in .bashrc, e.g., `export PROJECT=ISAAC`
# Include this in .bashrc by adding the line "source $HOME/WorkingCopies/linux_setup/generic/project_switcher.sh

# First, ensure PROJECT is set
if [ -z "$PROJECT" ]; then
    echo "ERROR: PROJECT variable is not set"
    exit 1
fi


export OMNI_KIT_ACCEPT_EULA=YES
# Load environment variables based on PROJECT value
case "$PROJECT" in
    "ISAAC")
	source /opt/ros/humble/setup.bash
	source ${HOME}/ros2_ws/install/setup.bash
	export ISAAC_ROS_WS=${HOME}/ros2_ws
        ;;
    "NAV2")
	source /opt/ros/jazzy/setup.bash
	#source ${HOME}/serve_ws/install/setup.bash
	#export ISAAC_ROS_WS=${HOME}/ros2_ws
	;;
    "SERVE")
	source /opt/ros/humble/setup.bash
	source ${HOME}/serve_ws/install/setup.bash
	export ISAAC_ROS_WS=${HOME}/ros2_ws
        ;;
    "VRX")
	source /opt/ros/humble/setup.bash
	source ${HOME}/vrx_ws/install/setup.bash
	;;
    "ORPHEUS")
	source /opt/ros/jazzy/setup.bash
	source ${HOME}/orpheus_simulation_ws/install/setup.bash
	;;
    "CLUTTERBOT")
	source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
	source /opt/ros/humble/setup.bash
	source /usr/share/colcon_cd/function/colcon_cd.sh
	source /etc/profile.d/bash_completion.sh
	source /root//gz_ros2_control_ws/install/setup.bash
	source ~/cb_ws/install/setup.bash
	;;
    *)
        echo "ERROR: Invalid PROJECT value: $PROJECT"
        echo "See linux_setup/generic/project_switcher.sh"
        #exit 1
        ;;
esac

# Optional: Print loaded configuration
echo "Loaded environment for $PROJECT"
