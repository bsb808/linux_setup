#!/bin/bash

#for N in $(seq 5 5)
#for N in $(seq 0 7)
NN=(2 \
    4)
#NN=(5)
for N in "${NN[@]}"
do
    IP="192.168.11.6${N}"
    ROS_MASTER_URI="http://${IP}:11311"
    echo "--------"
    echo ${IP}



done