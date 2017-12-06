#!/bin/bash

# get two lists of repos from repos.sh
# also defines the catkin and working directories
#. ./repos.sh
. ./repos_kf.sh

IP="192.168.131.221"
IP="192.168.1.20"
USER="bsb"



# Make sure to run "git daemon" on laptop and do 
# touch git-daemon-export-ok
# for each repo
cd /home/frl/catkin_ws/src
for REPO in "${ROSREPOS[@]}"
do 
    echo "--------${REPO}--------"
    git clone ssh://${USER}@${IP}/home/${USER}/catkin_ws/src/${REPO}
done

cd /home/frl/WorkingCopies
for REPO in "${OTHERREPOS[@]}"
do 
   echo "--------${REPO}--------"
   git clone ssh://${USER}@${IP}/home/${USER}/WorkingCopies/${REPO}
done