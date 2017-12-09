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

REV=false
if [ "$#" -gt 2 ]; then
    REV=true
fi


if ! [ REV ]; then
    OLD=("${IPS[@]}")
    N=${#OLD[@]}
    for (( idx=${#OLD[@]}-1 ; idx>=0 ; idx-- )) ; do
	IPS[N-idx-1]=${OLD[idx]}
	echo $N
	echo $idx
	
    done
fi
	
GOOD=0
BAD=0
for IP in "${IPS[@]}"
do 
    ip="${IP}"
    H=${LAPS[${ip}]}
    echo "-----------${USER}@${IP} : HOST:${H}-------------"
    
    for CMD in "${CMDS[@]}"
    do
	echo "CMD: <${CMD}>"
	ssh ${USER}@${IP} -t "exec bash -i -c \"${CMD}\""
	RTN=$?
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	GREEN='\033[0;32m'
	if [ ${RTN}  -eq 0 ]; then
	    echo -e "${GREEN}Success!${NC}"
	    GOOD=$(($GOOD + 1))
	else
	    # Make it easy to see failures
	    echo "          ****************************************"
	    echo -e "${RED}           ************** FAILED **************${NC}"
	    echo "          ****************************************"
	    BAD=$(($BAD + 1))
	fi
	
    done
done
echo -e "${GREEN}Successes: $GOOD ${RED} Failures: $BAD ${NC}"

