#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Add laptop repository connection
    LAP="192.168.11.120"
    REPO="WorkingCopies/linux_setup"
    # To add a new remote
    #ssh frl@${IP} -t "exec bash -i -c \" cd ${REPO} && git remote add laptop git+ssh://bsb@192.168.11.120/~/${REPO} && git pull laptop master\""

    # To change remote's URL
    #ssh frl@${IP} -t "exec bash -i -c \" cd ${REPO} && git remote set-url laptop git+ssh://bsb@192.168.11.120/~/${REPO} && git pull laptop master\""

    # Call linux_setup command
    # Add laptop remote URL for repositories on Pioneers
    CMD="./add_laptop_remote.sh"
    ssh frl@${IP} -t "exec bash -i -c \" cd ~/WorkingCopies/linux_setup && git pull laptop master && cd mrc && ${CMD}  \""

    
done