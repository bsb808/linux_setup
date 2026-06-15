#!/bin/bash
#
# vault_to_drive.sh — back up subdirectories of the local Vault to a named
# external drive. Each drive declares which Vault subdirs it is responsible
# for, so the target is chosen by name at runtime rather than by editing the
# script.
#
# Usage:
#   ./vault_to_drive.sh <DriveName> [--mirror] [--dry-run]
#
#   --mirror   delete files on the drive that no longer exist in the source,
#              so the backup reflects moves/renames/deletions (a true mirror).
#   --dry-run  show what would be added/deleted without changing anything.
#
# Examples:
#   ./vault_to_drive.sh PassportSilver                     # additive backup
#   ./vault_to_drive.sh PassportSilver --mirror --dry-run  # preview a mirror
#   ./vault_to_drive.sh PassportSilver --mirror            # apply the mirror
#
set -euo pipefail

SRC_ROOT="/data/Vault"

# --- Per-drive backup definitions -------------------------------------
# Each drive lists the subdirs of $SRC_ROOT it is responsible for.
configure_drive() {
    case "$1" in
        BingSSD2TB)
            SRC_DIRS=("Photos")
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

# Backup options — defaults here, overridden by CLI flags (parsed below).
DELETE=""      # --mirror sets this to --delete
DRYRUN=""      # --dry-run / -n sets this to --dry-run

# exFAT can't represent everything in the source. -L copies each symlink's
# target as a real file (so no symlink data is lost), and these excludes skip
# the handful of files whose names use characters exFAT forbids (colons,
# control chars) — they'd error on every run and falsely trip the verify.
declare -a EXCLUDES=(
    --exclude='cm-chat-media-video*'   # iMessage clips with ':' in the name
    --exclude='Icon?'                  # macOS custom-folder-icon file (Icon\r)
)

# --- Parse arguments: <DriveName> [--mirror] [--dry-run] ------------------
DRIVE=""
for arg in "$@"; do
    case "$arg" in
        --mirror|--delete) DELETE="--delete" ;;
        --dry-run|-n)      DRYRUN="--dry-run" ;;
        -h|--help)
            echo "Usage: $0 <DriveName> [--mirror] [--dry-run]"
            echo "  --mirror   delete files on the drive that no longer exist in the"
            echo "             source — use to reflect moves/renames/deletions."
            echo "  --dry-run  show what would be added/deleted without changing anything."
            exit 0 ;;
        -*) echo "Unknown option: $arg" >&2; exit 1 ;;
        *)  if [ -n "$DRIVE" ]; then echo "Unexpected extra argument: $arg" >&2; exit 1; fi
            DRIVE="$arg" ;;
    esac
done
[ -n "$DRIVE" ] || { echo "Usage: $0 <DriveName> [--mirror] [--dry-run]" >&2; exit 1; }

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

# Pick rsync options based on the destination filesystem. Case-insensitive,
# no-symlink, restricted-charset filesystems (exFAT, NTFS, FAT) need symlinks
# dereferenced (-L) and exFAT-illegal names excluded. A faithful filesystem
# (ext4, etc.) preserves symlinks, case-variant names, and every filename as-is,
# so we use neither — exFAT's -L/excludes would silently drop data there.
DEST_FS=$(findmnt -no FSTYPE --target "/media/bsb/${DRIVE}" 2>/dev/null || true)
declare -a FS_OPTS=()
case "$DEST_FS" in
    exfat|ntfs|ntfs3|vfat|msdos)
        FS_OPTS=(-L)
        echo "Destination is ${DEST_FS}: dereferencing symlinks, excluding exFAT-illegal names."
        ;;
    *)
        EXCLUDES=()   # faithful filesystem — copy everything verbatim
        echo "Destination is ${DEST_FS:-unknown}: faithful copy (symlinks, case, all names kept)."
        ;;
esac

# Create the destination subtree if missing (e.g. first backup to a fresh drive).
mkdir -p "${DEST}"

declare -a FAILED=()
for SRC_DIR in "${SRC_DIRS[@]}"; do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    echo "rsync:  ${SRC}  -->  ${DEST}"
    # --partial keeps interrupted files so they resume instead of restarting.
    # -a (no -v): one overall progress line via --info=progress2, not a line
    # per file. Add ,name0 to silence even the current-file name if desired.
    # Don't let one directory's error abort the rest of the backup: capture the
    # exit code (disable -e for this call) and keep going.
    set +e
    if [ -n "$DRYRUN" ]; then
        # Preview: itemize what would change (incl. '*deleting' lines under
        # --mirror). No data is written.
        rsync -ai "${FS_OPTS[@]}" --dry-run ${DELETE} "${EXCLUDES[@]}" "${SRC}" "${DEST}"
    else
        rsync -a "${FS_OPTS[@]}" --partial --info=progress2 ${DELETE} "${EXCLUDES[@]}" "${SRC}" "${DEST}"
    fi
    rc=$?
    set -e
    if [ "$rc" -ne 0 ]; then
        echo "WARNING: rsync of ${SRC_DIR} exited ${rc} (some files may not have transferred)." >&2
        FAILED+=("${SRC_DIR} (rc=${rc})")
    fi
done

if [ -n "$DRYRUN" ]; then
    echo ""
    echo "Dry run only — nothing was changed. Re-run without --dry-run to apply."
    echo "(Lines above starting '>f' = would copy, '*deleting' = would remove.)"
    exit 0
fi

# --- Go/No-Go verification -------------------------------------------------
# Confirm every source file is present on the drive at the right size, rather
# than trusting rsync's exit code alone. A dry-run (-n) reports what WOULD still
# be transferred; if that's empty, the backup is complete.
#
# --size-only is deliberate: exFAT can't store Unix perms/owner/mtime, so a
# plain -a compare would flag attribute "differences" on every file and never
# pass. Size presence is the meaningful completeness check here. (For a deeper
# content check you could swap in --checksum, but that re-reads all data on
# both sides and is slow over hundreds of GB.)
echo ""
echo "Verifying (go/no-go)..."
declare -a MISMATCH=()
for SRC_DIR in "${SRC_DIRS[@]}"; do
    SRC="${SRC_ROOT}/${SRC_DIR}"
    set +e
    # Count itemized lines for files/dirs still to send/create/delete; ignore
    # attribute-only lines (those start with '.').
    pending=$(rsync -ani "${FS_OPTS[@]}" --size-only ${DELETE} "${EXCLUDES[@]}" "${SRC}" "${DEST}" 2>/dev/null \
              | grep -cE '^(>|<|c|\*)')
    set -e
    if [ "${pending:-0}" -ne 0 ]; then
        echo "  NO-GO: ${SRC_DIR} — ${pending} item(s) missing or wrong size" >&2
        MISMATCH+=("${SRC_DIR} (${pending})")
    else
        echo "  GO:    ${SRC_DIR} — verified in sync"
    fi
done

# --- Final verdict ---------------------------------------------------------
if [ "${#FAILED[@]}" -gt 0 ] || [ "${#MISMATCH[@]}" -gt 0 ]; then
    echo "" >&2
    [ "${#FAILED[@]}"   -gt 0 ] && echo "  transfer errors:  ${FAILED[*]}"   >&2
    [ "${#MISMATCH[@]}" -gt 0 ] && echo "  failed verify:    ${MISMATCH[*]}" >&2
    echo "RESULT: NO-GO — backup is NOT complete." >&2
    echo "Re-run to retry (rsync skips already-copied files). If it persists," >&2
    echo "check 'sudo dmesg | tail' for device-offline/reset (cable/power/drive)." >&2
    exit 1
fi
echo ""
echo "RESULT: GO — all directories backed up and verified in sync."
