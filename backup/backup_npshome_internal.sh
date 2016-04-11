#!/bin/bash

# ------------- Command Line Arguments --------------------
# Stole this from http://www.linuxcommand.org/wss0130.php
LOG_FILE=/home/bsb/WorkingCopies/frl/util/backup/backup.log
echo "START new backup script on $(date)" >> $LOG_FILE

# Set Defaults
DELETE_OPTIONS=    # No delete options to start with, use -d 
TIMING=daily        # daily backup
# Loop until all parameters are used up
while [ "$1" != "" ]; do
    case $1 in 
	-d | --delete ) 
	    DELETE_OPTIONS="--delete --delete-excluded"
	    echo "Set rsync delete options $DELETE_OPTIONS"
	    ;;
	-t | --timing )
	    shift
	    TIMING=$1
	    echo "Set timing to <$TIMING> - deterimines backup directory"
	    ;;
	* )
	    echo "Unknown argument: $1"
	    exit 1
    esac
    shift
done
# ------------- file locations -----------------------------------------

#### DESTINATION
# make sure to include the trailing slash here.

BACKUP_ROOT=/media/InternalDrive/Backups/NpsDesktop/$TIMING/;
echo "Set backup directory to: $BACKUP_ROOT"
#### SOURCE
# The directory we want to backup
# Here we don't want the trailing slash here!
SOURCES[0]=/home/bsb
#SOURCES[1]=/home/dropbox

# A file with all our excludes in it
# Use full path so that it works with cron
#INCLUDES=./backup_include;
EXCLUDES=/home/bsb/WorkingCopies/frl/util/backup/backup_exclude;

# ------------- the script itself --------------------------------------
# rsync from the system into the latest snapshot (notice that
# rsync behaves like cp --remove-destination by default, so the destination
# is unlinked first.  If it were not so, this would copy over the other
# snapshot(s) too!
# Options
# -a = -rlptgoD
# -r = recursive
# -l = --links = copy simlinks as simlinks
# -p = --perms = preserve permissions (set off with --no-p)
# -t = preserve modification times
# -g = preserve group (set off with --no-g)
# -o = preserve owner (su only) (set off with --no-o)
# -D = --devices --specials
# --devices = preserve device files (su only)
# --specials = preserve special files (su only)
# -H = preserve hard links
# --chmod=ugo=rwX Gives new files the destination-default permissions
# whil leaving the existing files unchanges (see man rsync)
#
# Having problems with permissions on NAS, so let's omit the -go options
# Other notes
#--chmod=Du+wx                   \
# -no-p
#--include-from="$INCLUDES"    \
#    --exclude=* /  \

# For each of the sources in the array
for SRC in "${SOURCES[@]}"
do    
    echo "    Starting to backup <$SRC> to <$BACKUP_ROOT> at $(date)" >> $LOG_FILE
    rsync -av \
    $DELETE_OPTIONS	       \
    --exclude-from="$EXCLUDES"	       \
    $SRC $BACKUP_ROOT ;
echo "    END: Complted at $(date)" >> $LOG_FILE
done

# update the mtime of hourly.0 to reflect the snapshot time
$TOUCH $BACKUP_ROOT ;
