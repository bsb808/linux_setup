#!/bin/bash
#IP="172.20.88.151"
#IP="172.20.81.62"
IP="172.20.82.184"
IP="172.20.81.69"

BROOT=/home/bsb/WorkingCopies/linux_setup/backup
EXCLUDES=${BROOT}/backup_nas_exclude;

sshpass -p '!!Control' rsync -azv --exclude-from="$EXCLUDES" /media/bsb/InternalDrive/frl/ bsb@${IP}::frl/
sshpass -p '!!Control' rsync -azv --exclude-from="$EXCLUDES" /media/bsb/InternalDrive/bsb/ bsb@${IP}::bsb/
