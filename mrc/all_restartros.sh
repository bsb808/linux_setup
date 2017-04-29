#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}


    ssh frl@${IP} -t "exec bash -i -c \" sudo service nre stop && sleep 2 && sudo service nre start && sleep 2 && rosnode list\""

    
done