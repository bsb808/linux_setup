#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Pull all from laptop
    CMD="./executecmds.sh ./pulllaptopcmds.sh"
    ssh frl@${IP} -t "exec bash -i -c \" cd ~/WorkingCopies/linux_setup && git pull laptop master && cd mrc && ${CMD}  \""

    
done