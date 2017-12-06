#!/bin/bash

CATKIN="${HOME}/catkin_ws"
WCD="${HOME}/WCD"

#CATKIN="${HOME}/tmp_catkin"
#WCD="${HOME}/tmp_wcd"

# get two lists of repos from repos.sh
# also defines the catkin and working directories
. ./repos.sh

for KEY in ${!ROSREPOS[@]}; do
    echo "${KEY}:${ROSREPOS[${KEY}]}"
    if [ -d ${CATKIN}/src/${KEY} ]; then
	echo "Already exists, so pull"
	cd ${CATKIN}/src/${KEY}
	git pull origin 
    else
	cd ${CATKIN}/src/
	git clone ${ROSREPOS[${KEY}]}
    fi
done


for KEY in ${!OTHERREPOS[@]}; do
    echo "${KEY}:${OTHERREPOS[${KEY}]}"
    if [ -d ${WCD}/${KEY} ]; then
	echo "Already exists, so pull"
	cd ${WCD}/${KEY}
	git pull origin 
    else
	cd ${WCD}
	git clone ${OTHERREPOS[${KEY}]}
    fi
done


#for REPO in "${OTHERREPOS[@]}"
#do 
    #cd ${WCD}/${REPO}
    #git pull origin master
#done