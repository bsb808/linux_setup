#!/bin/bash

. ./ip_list.sh

for IP in "${IPS[@]}"
do
    echo "--------"
    echo ${IP}
    ping ${IP} 
done
#e01aea139fdb