#!/bin/bash

USER=robotx
# Get list of IP addresses
. ./ip_list.sh

for IP in "${IPS[@]}"
do
    echo "--------${IP}--------"

    # Open a new window on each machine
    gnome-terminal -e "bash -c \"ssh ${USER}@${IP}; exec bash; nano ~/.bashrc\""
    #ssh frl@${IP} -t 'bash -l -c \"${SCRIPT}\"'
    #ssh frl@${IP} -t "exec bash -i -c \"source ~/.bashrc; rosnode list\""
    #ssh frl@${IP} -t "exec bash -i -c \"rosnode list\""
    
done