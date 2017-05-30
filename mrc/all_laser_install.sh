#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"


#NN=(1)
#for N in "${NN[@]}"
for N in $(seq 3 3)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    # Add laptop repository connection
    LAP="192.168.11.120"
    REPO="catkin_ws/src/nre_p3at"
    #ssh frl@${IP} -t "exec bash -i -c \" cd ${REPO} && git stash && git pull laptop master\""

    #ssh frl@${IP} -t "exec bash -i -c \" cd /etc/ros/indigo/nre.d && sudo mkdir old && sudo mv microstrain_pioneer.launch old  && sudo mv reader_pioneer.launch old \""
    CMD1="sudo apt-get update && sudo apt-get install ros-indigo-hokuyo-node "
    CMD2="cd ~/WorkingCopies/linux_setup/mrc && git pull laptop origin"
    CMD3="sudo cp 98-hokoyu-serial.rules /etc/udev/rules.d"
    CMD="${CMD2} && ${CMD3}"
    #CMD="cd /home/frl/WorkingCopies/linux_setup/mrc && ./add_hosts.sh"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD2}\""
    
done