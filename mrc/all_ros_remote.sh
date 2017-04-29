#!/bin/bash



for N in $(seq 0 7)
#for N in $(seq 5 5)
do
    IP="192.168.11.6${N}"
    ROS_MASTER_URI="http://${IP}:11311"
    echo "--------"
    echo ${IP}
    #rosnode list
    #rostopic list
    rostopic echo -n 1 /my_p3at/battery_voltage

    # Don't seem to be published
    #rostopic echo -n 1 /my_p3at/battery_state_of_charge
    #rostopic echo -n 1 /my_p3at/battery_recharge_state
done