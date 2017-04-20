#!/bin/bash

for N in $(seq 0 4)
do
    IP="192.168.11.6${N}"
    echo ${IP}
    gnome-terminal -e "bash -c \"ssh frl@${IP}; exec bash\""
done