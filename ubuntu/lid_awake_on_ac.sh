#!/bin/bash
# Keep a laptop running with the lid closed while on AC power, so Claude Code
# and other long jobs keep going. On battery, closing the lid still suspends.
# Run as your user (not with sudo); it asks for sudo for the logind part.

set -e

echo "=== logind: ignore lid switch on external power ==="
# logind handles the lid itself and ignores inhibitors for it by default.
sudo mkdir -p /etc/systemd/logind.conf.d
printf '[Login]\nHandleLidSwitchExternalPower=ignore\n' \
    | sudo tee /etc/systemd/logind.conf.d/lid-ac.conf >/dev/null
# HUP reloads the config. Restarting logind instead can end the desktop session.
sudo systemctl kill -s HUP systemd-logind

echo "=== GNOME: no lid action on AC ==="
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'

echo "Lid on AC: $(busctl get-property org.freedesktop.login1 /org/freedesktop/login1 \
    org.freedesktop.login1.Manager HandleLidSwitchExternalPower)"
echo "To undo: sudo rm /etc/systemd/logind.conf.d/lid-ac.conf && sudo systemctl kill -s HUP systemd-logind"
