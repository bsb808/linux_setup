#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Open a new window on each machine
    #gnome-terminal -e "bash -c \"ssh frl@${IP}; exec bash; rosnode list\""
    #ssh frl@${IP} -t 'bash -l -c \"${SCRIPT}\"'
    #ssh frl@${IP} -t "exec bash -i -c \"source ~/.bashrc; rosnode list\""
    ssh frl@${IP} -t "exec bash -i -c \"rosnode list\""
    # Install ssh keys
    #ssh-copy-id -i ~/.ssh/id_rsa.pub frl@${IP}
    #ssh frl@${IP}
done