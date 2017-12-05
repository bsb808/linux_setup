#!/bin/bash

USER="frl"
# Get list of IP addresses
. ./ip_list.sh

# get list of commands
echo "Getting commands from $1 script"
if [ -f "$1" ]
then
    . $1
else
    echo "ERROR - must provide an argument with the list of commands!"
    echo "E.g., $ ./executecmds.sh ./resetcmds.sh"
    exit 1
fi

if [ "$#" -gt 1 ]; then
    USER="$2"
    echo "Executing using <${USER}> account."
fi

for IP in "${IPS[@]}"
do 
    echo "--------${IP}--------"
    
    for CMD in "${CMDS[@]}"
    do
	echo "CMD: <${CMD}>"
	ssh ${USER}@${IP} -t "exec bash -i -c \"${CMD}\""

    done
done

