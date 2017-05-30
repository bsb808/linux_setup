#!/bin/bash

SCRIPT="source ~/.bashrc; rosnode list;"
SCRIPT="rosnode list; pwd"


#
#NN=(0 \
#    5)
#for N in "${NN[@]}"
for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    CMD="sudo service nre stop"
    ssh frl@${IP} -t "exec bash -i -c \" ${CMD}\""
done

sleep 30

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}

    CMD="sudo service nre start"
    ssh frl@${IP} -t "exec bash -i -c \" ${CMD}\""
done