#!/bin/bash

# Setup ssh on frl account
./forall_setupssh.sh

# Add robotx account
./forall_execute.sh cmds_add_user.sh

# Setup ssh on robotx account
./forall_setupssh.sh robotx

# Check that I can login
./forall_execute.sh cmds_echo_hostname.sh robotx

# Get linux_setup repository
./forall_execute.sh cmds_git_linuxsetup.sh robotx

# Setup ros env
./forall_execute.sh cmds_ros_setup.sh robotx
