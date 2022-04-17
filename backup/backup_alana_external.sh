#!/bin/bash

# Source array
SRCS[0]=/home/bsb

# Destination
DEST=/media/bsb/MOE-Bingham/Backups/alala/

EXCLUDES=./excludes_alana.txt;

LOG_FNAME=backup_alana_external.log
LOCAL_LOG="./${LOG_FNAME}"

echo "= Start backup script on $(date) from <$(hostname)>."  |& tee -a ${LOCAL_LOG}

DELETE_OPTIONS=""

# For each of the sources in the array
for SRC in "${SRCS[@]}"
do    
    #echo "    *** Starting to backup <$SRC> to <$BACKUP_ROOT> at $(date)" |& tee -a ${LOG_FILE}
    CMD="rsync -ah $DELETE_OPTIONS --exclude-from=${EXCLUDES} $SRC $DEST"
    echo "== Running command <${CMD}>." |& tee -a ${LOCAL_LOG}
    eval $CMD |& tee -a ${LOCAL_LOG}
    #|& tee -a ${LOG_FILE};
    #echo "    *** END: Complted at $(date)" |& tee -a ${LOG_FILE}
done

echo "= Finished backup script on $(date)." |& tee -a ${LOCAL_LOG}

# Make a copy of the log file on at the destination
cp $LOCAL_LOG $DEST

# update the mtime of hourly.0 to reflect the snapshot t
#touch $BACKUP_ROOT ;

