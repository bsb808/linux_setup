#!/bin/bash
# get two lists of repos from repos.sh
# also defines the catkin and working directories
. ./pioneer_repos.sh
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
    LAP="192.168.11.120"
    git remote add laptop git+ssh://${LAP}/${CATKIN}/src/${REPO}
done


for REPO in "${OTHERREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${WCD}/${REPO}
    git remote add laptop git+ssh://${LAP}/${WCD}/${REPO}
done
