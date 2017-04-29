#!/bin/bash
# get two lists of repos from repos.sh
# also defines the catkin and working directories
. ./pioneer_repos.sh
# get list of commands


for REPO in "${ROSREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${CATKIN}/src/${REPO}
    LAP="192.168.11.120"
    git remote set-url laptop git+ssh://bsb@${LAP}/${CATKIN}/src/${REPO}
done


for REPO in "${OTHERREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${WCD}/${REPO}
    git remote set-url laptop git+ssh://bsb@${LAP}/${WCD}/${REPO}
done
