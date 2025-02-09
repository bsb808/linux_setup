#!/bin/bash


# Use this to clean up some deleted photos
#SRC_ROOT="/data/Vault/Photos"
#DEST="/media/bsb/${DRIVE}/Vault/Photos/"
#declare -a SRC_DIRS=("BrianPhoneGalaxyS20_June2023")
#DELETE="--delete"

sync_directories() {
    # Example: Call the function with the appropriate arguments
    # sync_directories "${SRC_ROOT}" SRC_DIRS[@] "${DEST}" "${DELETE}"
    local src_root=$1
    shift
    local -a src_dirs=("${!1}")
    shift
    local dest=$1
    local delete_flag=${2:-""}

    for src_dir in "${src_dirs[@]}"
    do
        local src="${src_root}/${src_dir}"
        echo "rsync:  ${src}-->  ${dest}"
        if [ ! -d "${dest}" ]; then
            echo "Creating directory: ${dest}"
            mkdir -p "${dest}"
        fi
        rsync -azv ${delete_flag} ${src} ${dest}
        if [ $? -ne 0 ]; then
            echo "###############################################"
            echo "WARNING: rsync command failed for ${src} to ${dest}"
            echo "###############################################"
        fi
    done
}

# Source
# SRC_ROOT="/data/Vault"
# #SRC_ROOT="/media/bsb/BareExt4Alpha/Vault"
# #declare -a SRC_DIRS=("Archive" "Photos" "PhotosFromJanet" "Videos")
# #declare -a SRC_DIRS=("Archive" "Photos" "Movies" "Videos")
# #declare -a SRC_DIRS=("Photos" "PhotosFromJanet" "Videos")
# declare -a SRC_DIRS=("Photos" )
# #declare -a SRC_DIRS=("Archive")

# # Destination
# #DRIVE="BareExt4Alpha"
# #DRIVE="PassportSilver"
# #DRIVE="FRL-Backup"
# #DRIVE="Passport2TB"
# DRIVE="Seagate2TBexFAT"
# DEST="/media/bsb/${DRIVE}/Vault/"
# #DEST="/data/Vault/"

# DELETE=""

# From internal drive (master) to external
SRC_ROOT="/data/Vault"
declare -a SRC_DIRS=("Archive" "Photos" "PhotosFromJanet" "Videos")
#DRIVE="BareExt4Alpha"
DRIVE="Seagate2TB"
DEST="/media/bsb/${DRIVE}/Vault/"
sync_directories "${SRC_ROOT}" SRC_DIRS[@] "${DEST}"

# # From internal drive (master) to another external
# # use same source
# DRIVE="PassportSilver"
# DEST="/media/bsb/${DRIVE}/Vault/"
# #sync_directories "${SRC_ROOT}" SRC_DIRS[@] "${DEST}"

# # Local home to internal
# EXCLUDES=./backup_exclude_hulihuli.txt;
# #rsync -azv --exclude-from="$EXCLUDES" /home/bsb /data/Backups/hulihuli2025/

# # Local home to external
# EXCLUDES=./backup_exclude_hulihuli.txt;
# DRIVE="BareExt4Alpha"
# #rsync -azv --exclude-from="$EXCLUDES" /home/bsb "/media/bsb/${DRIVE}/Backups/hulihuli2025/"

# # Local home another external
EXCLUDES=./backup_exclude_hulihuli.txt;
#DRIVE="PassportSilver"
DRIVE="Seagate2TB"
mkdir -p "/media/bsb/${DRIVE}/Backups/hulihuli2025/"
rsync -azv --exclude-from="$EXCLUDES" /home/bsb "/media/bsb/${DRIVE}/Backups/hulihuli2025/"

# Movies from one external to another.
#rsync -azv /media/bsb/FRL-Backup/Vault/Movies/ /media/bsb/PassportSilver/Vault/Movies/