#!/bin/bash

# Source
SRC_ROOT="/data/Vault"
#SRC_ROOT="/media/bsb/BareExt4Alpha/Vault"
#declare -a SRC_DIRS=("Archive" "Photos" "PhotosFromJanet" "Videos")
#declare -a SRC_DIRS=("Archive" "Photos" "Movies" "Videos")
#declare -a SRC_DIRS=("Photos" "PhotosFromJanet" "Videos")

# PassportSilver
DRIVE="PassportSilver"
declare -a SRC_DIRS=("Photos" "Videos" "Archive")
DEST="/media/bsb/${DRIVE}/Vault/"

# Portable SSD
DRIVE="PortableSSD"
declare -a SRC_DIRS=("Photos" "Videos" "Archive")
DEST="/media/bsb/${DRIVE}/Vault/"


# Destination
#DRIVE="BareExt4Alpha"
#DRIVE="FRL-Backup"
#DRIVE="Passport2TB"
#DRIVE="Seagate2TBexFAT"

#DEST="/data/Vault/"


DELETE=""

# Use this to clean up some deleted photos
#SRC_ROOT="/data/Vault/Photos"
#DEST="/media/bsb/${DRIVE}/Vault/Photos/"
#declare -a SRC_DIRS=("BrianPhoneGalaxyS20_June2023")
#DELETE="--delete"

for SRC_DIR in "${SRC_DIRS[@]}"
do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo "rsync:  ${SRC}-->  ${DEST}"
    rsync -azv ${DELETE} ${SRC} ${DEST}
done
