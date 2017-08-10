#!/bin/bash





#for N in $(seq 0 7)
#NN=(0 \
#    5)
#for N in "${NN[@]}"
for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    ROS_MASTER_URI="http://${IP}:11311"
    echo "--------"
    echo ${IP}
    CMD="rosnode list"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

done