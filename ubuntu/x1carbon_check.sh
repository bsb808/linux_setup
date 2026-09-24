#!/bin/bash
# Post-install verification for the X1 Carbon Gen 9.
# Read-only. Run after x1carbon_power.sh and after a reboot.

echo "############ System ############"
lsb_release -ds 2>/dev/null || cat /etc/os-release | head -2
echo "Kernel:  $(uname -r)"
echo "Session: ${XDG_SESSION_TYPE:-unknown} (26.04 GNOME should say wayland)"
# Prefer the unprivileged DMI sysfs files; fall back to dmidecode only if
# sudo is already unlocked, so this script never sits waiting for a password.
echo "Machine: $(cat /sys/class/dmi/id/product_version 2>/dev/null || echo unknown)"
echo "MTM:     $(cat /sys/class/dmi/id/product_name 2>/dev/null || echo unknown)"

echo
echo "############ Firmware ############"
if command -v fwupdmgr >/dev/null 2>&1; then
    fwupdmgr get-updates 2>&1 | tail -20
    echo "(Nothing to do here means the BIOS is current. The Gen 9 slow-charge"
    echo " bug is fixed by a BIOS update, so this needs to be clean.)"
else
    echo "fwupd not installed"
fi

echo
echo "############ Battery ############"
if command -v tlp-stat >/dev/null 2>&1; then
    sudo -n tlp-stat -b 2>/dev/null | grep -Ei 'BAT|capacity|charge|threshold|health' | head -30
fi
# Unprivileged battery figures, always available
for B in /sys/class/power_supply/BAT*; do
    [ -d "$B" ] || continue
    echo "-- $(basename "$B")"
    for f in energy_full_design energy_full charge_full_design charge_full capacity cycle_count status; do
        [ -r "$B/$f" ] && echo "   $f: $(cat "$B/$f")"
    done
    if [ -r "$B/energy_full" ] && [ -r "$B/energy_full_design" ]; then
        awk -v n="$(cat "$B/energy_full")" -v d="$(cat "$B/energy_full_design")" \
            'BEGIN{ if (d>0) printf "   health: %.1f%% of design\n", 100*n/d }'
    fi
    for f in charge_control_start_threshold charge_control_end_threshold; do
        [ -r "$B/$f" ] && echo "   $f: $(cat "$B/$f")"
    done
done
echo
echo "Refurb check: full-charge capacity against design capacity. Under about"
echo "80 percent is worth raising with the seller inside the return window."

echo
echo "############ Wireless ############"
lspci -k 2>/dev/null | grep -A3 -i 'network controller' || echo "lspci not available"
echo "(Expect Intel AX201 with the iwlwifi driver. Gen 9 shipped no other option.)"

echo
echo "############ Display panel ############"
if command -v xrandr >/dev/null 2>&1; then xrandr 2>/dev/null | grep -E '^\S+ connected' ; fi
for e in /sys/class/drm/*/edid; do
    [ -s "$e" ] && echo "EDID present: $e"
done
echo "(The target panel is 1920x1200 non-touch. A touch digitiser would show up"
echo " in: ls /dev/input/by-path/ | grep -i touch)"
ls /dev/input/by-path/ 2>/dev/null | grep -i touch && echo "TOUCH DEVICE FOUND" || echo "No touch device — correct for the target panel."

echo
echo "############ Suspend history ############"
journalctl -b -g 'PM: suspend' --no-pager 2>/dev/null | tail -10
echo
echo "Suspend test, the one that matters on this machine:"
echo "  close and open the lid a dozen times, confirming the session resumes"
echo "  and wifi reconnects each time, then re-run this script and read the log."

echo
echo "############ Thermals ############"
command -v sensors >/dev/null 2>&1 && sensors 2>/dev/null | head -20 || echo "run: sudo sensors-detect"

echo
echo "############ TLP ############"
systemctl is-active tlp 2>/dev/null
systemctl is-enabled power-profiles-daemon 2>/dev/null || echo "power-profiles-daemon: masked (intended)"

echo
echo "############ Docker ############"
if command -v docker >/dev/null 2>&1; then
    docker --version
    groups | grep -q docker && echo "user is in the docker group" || echo "NOT in docker group yet — log out and back in"
else
    echo "docker not installed"
fi
