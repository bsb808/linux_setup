#!/bin/bash

#
#NN=(0 \
#    5)
#for N in "${NN[@]}"
for N in $(seq 0 7)
do
    NS="p${N}"
    echo "--------"
    echo ${NS}
    rostopic echo /${NS}/rfid
done
