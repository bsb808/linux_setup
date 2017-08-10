#!/bin/bash


#for N in $(seq 5 5)
#for N in $(seq 0 7)
NN=(7)
for N in "${NN[@]}"
do
    IP="192.168.11.6${N}"
    ROS_MASTER_URI="http://${IP}:11311"
    echo "--------"
    echo ${IP}

    # Multicast setup
    LINE="frl ALL=\(ALL\) NOPASSWD: ALL"
    F="/etc/sudoers"
    CMD="echo ${LINE} | sudo tee -a ${F}"
    #ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    CMD="sudo more ${F}"
    #ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    CMD="cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

    # Go passwordless
    LINE="frl ALL=\(ALL\) NOPASSWD: ALL"
    F="/etc/sudoers"
    CMD="echo ${LINE} | sudo tee -a ${F}"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
    CMD="sudo more ${F}"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

    # Install multimaster
    CMD="sudo apt-get install ros-indigo-multimaster-fkie"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

    # Add a line to nre-start
    F=/usr/sbin/nre-start
    CMD="sudo cp $F $F-orig && sudo sed -i '3iexport HNAME=\\\`hostname -s\\\` ' $F && more $F"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

    # Add lines to hosts file
    for M in $(seq 0 7)
    do
	if [ "$M" -eq "$N" ]; then
	    echo "Skipping $M for $N"
	else
	    LINE="192.168.11.6${M}  p${M}"
	    echo ${LINE}
	    CMD="echo ${LINE} | sudo tee -a /etc/hosts"
	    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""
	fi
    done
    LINE="192.168.11.120  humuhumu"
    CMD="echo ${LINE} | sudo tee -a /etc/hosts"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

    CMD="more /etc/hosts"
    ssh frl@${IP} -t "exec bash -i -c \"${CMD}\""

done