#!/bin/bash
# Power management for the ThinkPad X1 Carbon Gen 9.
# TLP with charge thresholds, and power-profiles-daemon got out of the way.

set -e
cd "$(dirname "$0")"
source ./lib_apt.sh

echo "=== Installing TLP and diagnostics ==="
apt_try tlp tlp-rdw powertop lm-sensors acpi

echo "=== Disabling power-profiles-daemon ==="
# TLP and power-profiles-daemon both manage CPU governors and platform profiles.
# Running both produces settings that flap. TLP is kept because it is the one
# that can set charge thresholds.
if systemctl list-unit-files | grep -q power-profiles-daemon; then
    sudo systemctl stop power-profiles-daemon || true
    sudo systemctl disable power-profiles-daemon || true
    sudo systemctl mask power-profiles-daemon || true
    echo "power-profiles-daemon masked."
    echo "The power profile selector will disappear from the GNOME system menu."
    echo "To undo: sudo systemctl unmask --now power-profiles-daemon"
fi

echo "=== Writing TLP configuration ==="
sudo tee /etc/tlp.d/01-x1carbon.conf > /dev/null << 'CONF'
# X1 Carbon Gen 9, travel and couch machine.
# Managed by linux_setup/ubuntu/x1carbon_power.sh

# Charge thresholds. The battery spends most of its life on a desk, so it is
# held in the middle of its range and only topped up before a trip.
# Lift with: sudo tlp setcharge 0 100 BAT0
START_CHARGE_THRESH_BAT0=60
STOP_CHARGE_THRESH_BAT0=80

# CPU
CPU_SCALING_GOVERNOR_ON_AC=powersave
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_AC=balance_performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0

# Platform profile, the firmware-level knob this generation exposes
PLATFORM_PROFILE_ON_AC=balanced
PLATFORM_PROFILE_ON_BAT=low-power

# PCIe and graphics
PCIE_ASPM_ON_BAT=powersupersave
INTEL_GPU_MIN_FREQ_ON_BAT=100

# Leave USB autosuspend off. It saves little on this machine and is a
# common cause of misbehaving docks and serial adapters.
USB_AUTOSUSPEND=0

# Wifi power saving on battery only
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=on
CONF

echo "=== Enabling TLP ==="
sudo systemctl enable tlp
sudo systemctl start tlp
sudo tlp start

echo
echo "=== Note on powertop ==="
echo "powertop is installed for diagnostics. Do NOT enable powertop --auto-tune"
echo "as a service alongside TLP; they fight over the same knobs. Use"
echo "  sudo powertop"
echo "to look, and change settings through /etc/tlp.d/ instead."

apt_report
echo
echo "=== Power setup done. Verify with x1carbon_check.sh ==="
