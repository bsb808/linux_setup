#/bin/bash

# Make links in catkin space
UTILS=(pullall.sh)
CATDIR=/home/bsb/catkin_ws/src
WCD=/home/bsb/WorkingCopies
for UTIL in "${UTILS[@]}"
do
    echo "Creating link in ${CATDIR} to utility ${UTIL}"
    ln -s ${WCD}/${UTIL} ${CATDIR}/${UTIL} 
done