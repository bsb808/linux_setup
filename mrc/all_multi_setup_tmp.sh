#!/bin/bash



#for N in $(seq 0 7)
NN=(2 3 4 6 7)
for N in "${NN[@]}"

do
    IP="192.168.11.6${N}"
    ROS_MASTER_URI="http://${IP}:11311"
    echo "--------"
    echo ${IP}

    # Multicast setup
    LINE="net.ipv4.icmp_echo_ignore_broadcasts=0"
    F="/etc/sysctl.conf"
    CMD="echo ${LINE} | sudo tee -a ${F}"
    #ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    CMD="sudo more ${F}"
    #ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    CMD="sudo service procps restart && cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""


done