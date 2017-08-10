#!/bin/bash

for N in $(seq 0 7)
do
    IP="192.168.11.6${N}"
    echo "--------"
    echo ${IP}
    
    ping ${IP} 
done