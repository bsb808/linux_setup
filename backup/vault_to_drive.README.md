# vault_to_drive — backup notes & new-machine setup

Backs up subdirectories of the local Vault (`/data/Vault`) to a named external
drive. Run it as:

```bash
./vault_to_drive.sh <DriveName>      # e.g. ./vault_to_drive.sh BingSSD2TB
```

The drive is chosen by name; each drive's backup set is defined in the
`configure_drive` `case` block inside [vault_to_drive.sh](vault_to_drive.sh).
The destination is `/media/bsb/<DriveName>/Vault/`, so the drive's exFAT/volume
**label must match the name** you pass (udisks auto-mounts at
`/media/<user>/<LABEL>`).

---

## Hardware gotchas (learned the hard way)

### 1. SanDisk Portable SSD + UAS = dropouts → install the quirk

The SanDisk Portable SSD (USB ID `0781:55bb`) is unreliable under the Linux
**UAS** driver: it drops off the USB bus under sustained write load, causing
uninterruptible I/O hangs, `device offline` errors, and exFAT corruption
(filesystem flipped read-only mid-backup).

Fix: force the older, stable `usb-storage` (Bulk-Only) driver via the quirk file
[disable-uas-sandisk.conf](disable-uas-sandisk.conf) in this directory.

On a new machine, install it once:

```bash
sudo cp disable-uas-sandisk.conf /etc/modprobe.d/
sudo update-initramfs -u        # Debian/Ubuntu. (Fedora/Arch: sudo dracut -f)
sudo reboot
```

Verify after reboot — it must say `usb-storage`, not `uas`:

```bash
ls /sys/bus/usb/drivers/usb-storage/ | grep -E '^[0-9]'   # drive should appear here
ls /sys/bus/usb/drivers/uas/        | grep -E '^[0-9]'   # drive should NOT appear here
```

Portable fallback if `modprobe.d` doesn't take (e.g. non-initramfs setups): add
`usb-storage.quirks=0781:55bb:u` to `GRUB_CMDLINE_LINUX_DEFAULT` in
`/etc/default/grub`, then `sudo update-grub && reboot`.

Tradeoff: `usb-storage` has no command queuing, so small-file transfers run
slower than UAS would. That's the price of stability — accept it.

### 2. Use a direct port, not a shared hub

A bus-powered SSD writing hard draws significant current. Sharing a USB hub with
another external drive caused a power brownout and the same drop-off-the-bus
symptom even with the UAS quirk in place.

- Plug the drive directly into a rear motherboard USB port.
- Don't share that port path with another drive during a backup.
- If you must use a hub, use a powered (self-AC) hub.

### 3. Recovering a wedged / dropped drive

If the drive hangs (processes stuck in `D` state) or drops off the bus:

```bash
# physically unplug the drive (this errors out the stuck I/O and frees processes)
sudo umount -l /media/bsb/<DriveName>      # lazy unmount of the stale mount
# replug into a direct rear port, then check the filesystem before trusting it:
sudo fsck.exfat /dev/sdX1                   # find the node with: lsblk
```

Diagnose what happened with `sudo dmesg | tail -40`:
- `device offline`, `reset SuperSpeed`, `over-current` → power/cable/hub (hardware).
- `Medium Error` / SCSI sense data → failing drive media.
- `Invalid argument (22)` / `Operation not permitted (1)` on specific files →
  not a hardware problem; exFAT filename/symlink limits (see below).

---

## exFAT filesystem limits (why some files are skipped)

The drives are exFAT for cross-platform (Mac/Windows/Linux) readability, but
exFAT can't represent everything in a Unix/macOS source tree. The script handles
this so the run ends in a clean GO:

- Symlinks: exFAT has none. The script uses `-L` to copy each symlink's *target*
  as a real file, so no data is lost.
- Forbidden filename characters (`: * ? < > | " \` and control chars): files
  named this way (e.g. iMessage `cm-chat-media-video-...:...:0:0.mov`, the macOS
  `Icon\r` file) can't be created on exFAT. They're listed in the `EXCLUDES`
  array in the script and skipped intentionally.

If you back up a source with *new* exFAT-illegal names, rsync will error on them
and the verify will report NO-GO. Either add an `--exclude` for them, or accept
they can't live on exFAT. (For bit-perfect fidelity including symlinks and any
filename, format the drive ext4 instead — at the cost of native Mac/Windows
readability.)

---

## What the script does for you

- Refuses to run if the drive isn't mounted (won't write into a bare mount point).
- Liveness probe: times out in 10s instead of hanging forever on a wedged drive.
- Creates the destination tree on first backup to a fresh drive.
- Per-directory error handling: one failed directory doesn't abort the rest; a
  summary lists which failed.
- `--partial`: interrupted large files resume instead of restarting.
- Go/No-Go verification: after copying, a `--size-only` dry-run confirms every
  source file is present on the drive at the right size. Ends with
  `RESULT: GO` (complete) or `RESULT: NO-GO` (with the failing directories).

---

## Adding a new drive

1. Format/label the drive (exFAT) with the name you'll use:
   ```bash
   sudo mkfs.exfat -L <DriveName> /dev/sdX1
   ```
2. Add a `case` arm in `configure_drive()` listing its Vault subdirs.
3. (Optional) Record it in [backup_plan.ods](backup_plan.ods).

---

## Portability caveats when moving machines

- Mount path is hardcoded to `/media/bsb/...`. On a machine with a different
  username, udisks mounts at `/media/<user>/...` — adjust the path in the script
  (or the username) accordingly.
- `SRC_ROOT="/data/Vault"` assumes the source layout; change if different.
- The UAS quirk is specific to USB ID `0781:55bb`. A different drive model needs
  its own ID (find it with `lsusb`).
