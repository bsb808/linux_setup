#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"

#for N in $(seq 0 7)
NN=(1)
for N in "${NN[@]}"
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Add laptop repository connection
    LAP="192.168.11.120"
    REPO="catkin_ws/src/nre_p3at"
    #ssh frl@${IP} -t "exec bash -i -c \" cd ${REPO} && git stash && git pull laptop master\""

    #ssh frl@${IP} -t "exec bash -i -c \" cd /etc/ros/indigo/nre.d && sudo mkdir old && sudo mv microstrain_pioneer.launch old  && sudo mv reader_pioneer.launch old \""
    
    CMD="ping 8.8.8.8"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    
done