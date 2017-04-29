#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Install ssh keys from Laptop to all Pioneers
    #ssh-copy-id -i ~/.ssh/id_rsa.pub frl@${IP}
    #ssh frl@${IP}

    # Install ssh keys from Pioneers to laptop
    LAP="192.168.11.120"
    ssh frl@${IP} -t "exec bash -i -c \"ssh-keygen && ssh-copy-id -i ~/.ssh/id_rsa.pub bsb@${LAP} \""

    
done