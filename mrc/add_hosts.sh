#!/bin/bash

. ./laptop_hosts.sh

if [ ${#HNAMES[@]} -ne ${#IPS[@]} ]; then 
    echo "both lists need to be of same length"
else
    echo "Adding ${#HNAMES[@]} hosts"
fi

for h in "${!HOSTS[@]}"; do
    printf "%s is in %s\n" "$h" "${HOSTS[$h]}"
    ./manage-etc-hosts-add.sh $h ${HOSTS[$h]}
done