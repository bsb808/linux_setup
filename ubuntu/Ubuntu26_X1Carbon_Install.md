# Ubuntu 26.04 LTS on ThinkPad X1 Carbon Gen 9

Setup runbook for the refurbished X1 Carbon Gen 9 bought September 2026, used as the travel and couch machine. Not the main desktop and not the GPU laptop, so no NVIDIA stack, no MATLAB, no scanner, and ROS comes from containers rather than apt.

Release note: 26.04 LTS is "Resolute Raccoon", GNOME 50, kernel 7.0, systemd 259, dracut initramfs. The GNOME session is Wayland only — X11 is no longer offered in GDM. That has consequences below.

## Order of operations

1. Install Ubuntu 26.04 LTS from USB
2. Firmware update — do this before anything else
3. `sudo apt install git`, make an ssh key, upload to GitHub
4. Clone this repo
5. `./setup_26_x1.sh` and answer the prompts, or run the pieces by hand
6. Power setup and verification
7. Restore dotfiles and sign into accounts

## 1. BIOS, before installing

Enter setup with F1 at the Lenovo splash.

- Secure Boot can stay enabled. Ubuntu's kernel is signed and 26.04 supports TPM-backed full disk encryption, which needs it.
- Check whether the refurbisher left a supervisor password. If one is set and unknown, stop — the machine goes back.
- Thunderbolt BIOS Assist Mode: off.
- Sleep State: if the menu offers Linux versus Windows, either works on this generation. Leave it as shipped and only revisit it if suspend misbehaves in step 6.

## 2. Install

Nothing exotic. Erase disk, enable encryption. 26.04 can seal the FDE key to the TPM, which means no passphrase at every boot — worth taking on a laptop that travels, provided the recovery key is stored somewhere that is not the laptop.

Keep the factory SSD if it was swapped for a larger one, in case the machine has to go back inside the return window.

## 3. Firmware first

The X1 Carbon Gen 9 shipped with a BIOS bug that stretches a full charge to roughly six hours. Lenovo publishes ThinkPad firmware through LVFS, so:

```bash
sudo fwupdmgr refresh --force
fwupdmgr get-devices
sudo fwupdmgr get-updates
sudo fwupdmgr update
```

Expect a reboot, possibly two. Do this before judging anything about battery behaviour.

## 4. Scripts in this directory

| Script | What it does |
|---|---|
| `apt_install_26_base.sh` | base system, build tools, python, docker, serial |
| `apt_install_26_apps.sh` | Chrome, VS Code, Slack, Zoom, Sublime, desktop apps |
| `apt_install_26_latex.sh` | texlive, latexmk, biber, jabref, tikzit |
| `x1carbon_power.sh` | TLP, charge thresholds, powertop |
| `x1carbon_check.sh` | verification — battery health, suspend, wifi, firmware |
| `setup_26_x1.sh` | runs the above in order |

Everything is idempotent enough to re-run.

## 5. Wayland consequences

26.04 has no X11 session, so a few habits from the 22.04 desktop do not carry over.

- Clipboard from scripts: `wl-copy` and `wl-paste` from `wl-clipboard`, not `xclip`. Both get installed; `xclip` still works for XWayland apps.
- Screen sharing in Slack, Zoom and Chrome goes through the xdg-desktop-portal. If a share dialog comes up empty, `xdg-desktop-portal-gnome` is the package to check.
- Screenshot tools: GNOME's built-in capture works. `flameshot` needs a Wayland workaround; `ksnip` is the easier alternative and is in the apps script.
- Anything that used `xdotool` or `wmctrl` will not work. Nothing here does.

## 6. Power and verification

Run `x1carbon_power.sh`, then `x1carbon_check.sh`.

Charge thresholds are set to 60/80 by TLP through `thinkpad_acpi`. That is the right setting for a machine that mostly sits on a desk and gets grabbed for trips. Before a long trip, lift the ceiling:

```bash
sudo tlp setcharge 0 100 BAT0   # full charge for travel
sudo tlp setcharge 60 80 BAT0   # back to normal
```

TLP and GNOME's `power-profiles-daemon` both try to own CPU governors, so the power script masks `power-profiles-daemon`. If GNOME's power profile selector disappears from the system menu afterwards, that is why, and it is intended.

The suspend test is the one that matters on this machine. Close and open the lid a dozen times and confirm the session resumes and wifi reconnects each time. `x1carbon_check.sh` prints the suspend log and the wifi driver so there is a record.

Battery health, given this is a refurb: `sudo tlp-stat -b` reports design capacity against full-charge capacity. Anything under about 80 percent is worth raising with the seller inside the return window.

## 7. Expected to not work

- Fingerprint reader. Gen 9 uses a Synaptics sensor whose Linux support has always been partial. Do not plan around it.
- Nothing else. Tiger Lake and the Intel AX201 have had five years of kernels, which is the whole reason this generation was chosen.

## 8. By hand, after the scripts

- Chrome: sign in, turn on sync
- 1Password: install from the deb on their site, sign in
- GlobalProtect VPN: NPS install, deb from the portal, not in any apt repo
- Claude Code: `curl -fsSL https://claude.ai/install.sh | bash` (redirects to downloads.claude.ai, installs into `~/.local/share/claude`)
- git config, ssh keys, and the repos wanted on this machine — it is a travel laptop, so clone selectively
- `../generic/bash_setup.sh` if the bash additions are still wanted; note it references ROS Indigo paths and needs a trim first
- Timeshift or Deja Dup, if this machine is going to hold anything not already in a repo

## 9. ROS

Not installed natively. This machine uses the same container workflow as the desktop, driven by drydock/dockwater. Docker is installed by the base script. Clone `drydock` and go from there.
