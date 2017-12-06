#!/bin/bash

# get two lists of repos from repos.sh
# also defines the catkin and working directories
. ./repos.sh
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

for REPO in "${ROSREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${CATKIN}/src/${REPO}
    for CMD in "${CMDS[@]}"
    do
	echo ${CMD}
	eval ${CMD}
    done
done


for REPO in "${OTHERREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${WCD}/${REPO}
    for CMD in "${CMDS[@]}"
    do
	echo ${CMD}
	eval ${CMD}
    done
done