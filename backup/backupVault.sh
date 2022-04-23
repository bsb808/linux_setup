z#!/bin/bash

# Source array
SRCS[0]=/data/Vault

# Destination
# Name of the external
EXTERNAL="FRL-Backup"
#EXTERNAL="BareExt4Alpha"
DEST="/media/bsb/${EXTERNAL}/"

HOST=`hostname`
LOG_FNAME="backup_vault_from_${HOST}_to_${EXTERNAL}.log"
LOCAL_LOG="./${LOG_FNAME}"

echo "= Start backup script on $(date) from <$(hostname)>."  |& tee -a ${LOCAL_LOG}

DELETE_OPTIONS=""
EXCLUDES=excludes_photos.txt

# For each of the sources in the array
for SRC in "${SRCS[@]}"
do    
    CMD="rsync -avh $DELETE_OPTIONS --exclude-from=${EXCLUDES} $SRC $DEST"
    echo "== Running command <${CMD}>." |& tee -a ${LOCAL_LOG}
    eval $CMD |& tee -a ${LOCAL_LOG}
done

echo "= Finished backup script on $(date)." |& tee -a ${LOCAL_LOG}

# Make a copy of the log file on at the destination
cp $LOCAL_LOG $DEST


