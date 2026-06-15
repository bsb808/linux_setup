#!/bin/bash
#
# vault_to_drive.sh — back up subdirectories of the local Vault to a named
# external drive. Each drive declares which Vault subdirs it is responsible
# for, so the target is chosen by name at runtime rather than by editing the
# script.
#
# Usage:
#   ./vault_to_drive.sh <DriveName>
#
# Examples:
#   ./vault_to_drive.sh PortableSSD
#   ./vault_to_drive.sh Seagate2TBexFAT
#
set -euo pipefail

SRC_ROOT="/data/Vault"

# --- Per-drive backup definitions -------------------------------------
# Each drive lists the subdirs of $SRC_ROOT it is responsible for.
configure_drive() {
    case "$1" in
        BingSSD2TB)
            SRC_DIRS=("Photos" "Videos" "Archive")
            ;;
        PassportSilver)
            SRC_DIRS=("Photos" "Videos" "Archive")
            ;;
        Seagate2TBexFAT)
            SRC_DIRS=("Archive")
            ;;
        FRL-Backup)
            SRC_DIRS=("Photos" "PhotosFromJanet" "Videos")
            ;;
        Passport2TB)
            SRC_DIRS=("Photos" "Videos" "Archive")
            ;;
        *)
            echo "Unknown drive: $1" >&2
            exit 1
            ;;
    esac
}
# ----------------------------------------------------------------------

# Set to "--delete" to mirror (removes files on the drive that are no longer
# in the source). Leave empty for additive-only backups.
DELETE=""

DRIVE="${1:?Usage: $0 <DriveName>}"
configure_drive "$DRIVE"
DEST="/media/bsb/${DRIVE}/Vault/"

# Safety: refuse to run if the destination drive isn't mounted, so we never
# write a "backup" into an empty mount point on the root filesystem.
if ! mountpoint -q "/media/bsb/${DRIVE}"; then
    echo "ERROR: /media/bsb/${DRIVE} is not mounted. Aborting." >&2
    exit 1
fi

# Liveness probe: a mounted drive can still be wedged (USB/UAS dropout, exFAT
# corruption) and hang every read in uninterruptible I/O wait. Time-box a
# trivial read of the mount ROOT (not $DEST, which may not exist yet on a fresh
# drive) so we fail fast instead of stalling forever.
if ! timeout 10 ls "/media/bsb/${DRIVE}/" >/dev/null 2>&1; then
    echo "ERROR: /media/bsb/${DRIVE} did not respond within 10s (drive wedged or I/O error)." >&2
    echo "       Check 'sudo dmesg | tail' and 'sudo fsck.exfat /dev/sdX1'." >&2
    exit 1
fi

# Create the destination subtree if missing (e.g. first backup to a fresh drive).
mkdir -p "${DEST}"

for SRC_DIR in "${SRC_DIRS[@]}"; do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo "rsync:  ${SRC}  -->  ${DEST}"
    rsync -av --info=progress2 ${DELETE} "${SRC}" "${DEST}"
done
