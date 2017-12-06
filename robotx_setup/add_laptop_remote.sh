#!/bin/bash
# get two lists of repos from repos.sh
# also defines the catkin and working directories
. ./repos_kf.sh
# get list of commands

LAP="192.168.11.120"
LAP="192.168.1.20"

for REPO in "${ROSREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${CATKIN}/src/${REPO}
    #git remote add laptop git+ssh://bsb@${LAP}/${CATKINBSB}/src/${REPO}
    git remote set-url laptop git+ssh://bsb@${LAP}/${CATKINBSB}/src/${REPO}
done


for REPO in "${OTHERREPOS[@]}"
do 
    echo "--------${REPO}--------"
    cd ${WCD}/${REPO}
    #git remote add laptop git+ssh://bsb@${LAP}/${WCDBSB}/${REPO}
    git remote set-url laptop git+ssh://bsb@${LAP}/${CATKINBSB}/src/${REPO}
done
