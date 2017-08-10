#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"


#for N in $(seq 5 5)
#NN=(0 \
#    5)
#for N in "${NN[@]}"
for N in $(seq 0 7)
do
    NS="p${N}"
    echo "--------"
    echo ${NS}
    TOPIC="${NS}/my_p3at/cmd_vel"
    xvel=0.5
    zvel=0.5
    cmd="rostopic pub -r 10 /${TOPIC} geometry_msgs/Twist  '{linear:  {x: ${xvel}, y: 0.0, z: 0.0}, angular: {x: 0.0,y: 0.0, z: ${zvel}}}'"
    echo ${cmd}
    eval "${cmd}"

done