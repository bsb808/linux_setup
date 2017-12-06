#!/bin/bash

# Make sure everyon is on LAN
./forall_ping.sh 

# Ping google - are we connected
./forall_execute.sh cmds_pinggoogle.sh

# Setup ssh on frl account
./forall_setupssh.sh

# Get hostnmes and users
./forall_execute.sh cmds_echo_hostname.sh frl

# disable screen lock
./forall_execute.sh cmds_disablescreenlock.sh frl

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

# Reboot
./forall_execute.sh cmds_reboot.sh frl



