#!/bin/bash
# Internal
SRC_ROOT="/data/Vault"
# External
#DEST="/media/bsb/BareExt4Alpha/"
#DEST="/media/bsb/Passport2TB/Vault/"
#DEST="/media/bsb/FRL-Backup/Vault/"
DEST="/media/bsb/PassportSilver/Vault/"
declare -a SRC_DIRS=("Archive" "Photos" "Movies" "Videos")
#declare -a SRC_DIRS=("Archive")
for SRC_DIR in "${SRC_DIRS[@]}"
do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo $SRC
    rsync -azv ${SRC} ${DEST}
done
