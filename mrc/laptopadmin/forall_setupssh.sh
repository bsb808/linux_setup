#!/bin/bash

# Get list of IP addresses
if [ "$#" -ne 1 ]; then
    USER="frl"
    KEY="id_rsa.pub"
else
    USER="$1"
    #KEY="id_rsa_${1}.pub"
    KEY="id_rsa.pub"
fi

. ./ip_list.sh

for IP in "${IPS[@]}"
do
    echo "--------${IP}--------"
    #ssh-copy-id -i ~/.ssh/${KEY} frl@${IP}
    ssh-copy-id -i ~/.ssh/${KEY} ${USER}@${IP}
done

#e01aea139fdb