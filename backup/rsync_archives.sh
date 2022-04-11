#!/bin/bash

# This is where I have mounted the second internal drive on iwi20
DEST="/data/"
# External
SRC_ROOT="/media/bsb/InternalDrive/bsb"
declare -a SRC_DIRS=("Archive" "Books" "Movies" "Music" "PhotosVideo")
for SRC_DIR in "${SRC_DIRS[@]}"
do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo $SRC
    rsync -azv ${SRC} ${DEST}
done
