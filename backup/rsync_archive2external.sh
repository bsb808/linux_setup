#!/bin/bash
# Internal
SRC_ROOT="/data"
# External
DEST="/media/bsb/BareExt4Alpha/"

#declare -a SRC_DIRS=("Archive" "Books" "Movies" "Music" "PhotosVideo")
declare -a SRC_DIRS=("Archive")
for SRC_DIR in "${SRC_DIRS[@]}"
do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo $SRC
    rsync -azv ${SRC} ${DEST}
done
