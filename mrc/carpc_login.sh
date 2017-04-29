#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

#for N in $(seq 0 7)
for N in $(seq 1 1)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Open a new window on each machine
    #gnome-terminal -e "bash -c \"ssh frl@${IP}; exec bash; rosnode list\""
    #ssh frl@${IP} -t 'bash -l -c \"${SCRIPT}\"'
    #ssh frl@${IP} -t "exec bash -i -c \"source ~/.bashrc; rosnode list\""
    #ssh frl@${IP} -t "exec bash -i -c \"rosnode list\""

    
    # Install ssh keys from Laptop to all Pioneers
    #ssh-copy-id -i ~/.ssh/id_rsa.pub frl@${IP}
    #ssh frl@${IP}

    # Install ssh keys from Pioneers to laptop
    #LAP="192.168.11.120"
    #ssh frl@${IP} -t "exec bash -i -c \"ssh-keygen && ssh-copy-id -i ~/.ssh/id_rsa.pub bsb@${LAP} \""

    # Add laptop repository connection
    LAP="192.168.11.120"
    REPO="WorkingCopies/linux_setup"
    #ssh frl@${IP} -t "exec bash -i -c \" cd ${REPO} && git remote add laptop git+ssh://bsb@192.168.11.120/~/${REPO} && git pull laptop master\""

    # Call linux_setup command
    CMD="./add_laptop_remote.sh"
    #CMD="./executecmds.sh ./pulllaptopcmds.sh"
    ssh frl@${IP} -t "exec bash -i -c \" cd ~/WorkingCopies/linux_setup && git pull laptop master && cd mrc && ${CMD}  \""

    
done