#!/bin/bash
# Orchestrator for a fresh Ubuntu 26.04 install on the X1 Carbon Gen 9.
# See Ubuntu26_X1Carbon_Install.md for the full runbook.

set -e
cd "$(dirname "$0")"
rm -f /tmp/linux_setup_missing.txt

ask() {
    read -r -p "$1 [Y/n] " a
    [[ -z "$a" || "$a" =~ ^[Yy] ]]
}

echo "#########################################################"
echo "  Ubuntu 26.04 setup — ThinkPad X1 Carbon Gen 9"
echo "#########################################################"
echo
echo "Firmware should already be updated. If it is not, stop and run:"
echo "  sudo fwupdmgr refresh --force && sudo fwupdmgr update"
echo
ask "Firmware is current, continue?" || exit 0

ask "Run base install (build tools, python, docker)?" && ./apt_install_26_base.sh
ask "Run desktop apps (Chrome, VS Code, Slack, Zoom)?"  && ./apt_install_26_apps.sh
ask "Run LaTeX toolchain (large, ~3 GB)?"               && ./apt_install_26_latex.sh
ask "Run X1 Carbon power setup (TLP, charge thresholds)?" && ./x1carbon_power.sh

echo
echo "#########################################################"
echo "  Done. Next:"
echo "    1. Log out and back in (docker group, dock pinning)"
echo "    2. ./x1carbon_check.sh"
echo "    3. Lid-close suspend test, a dozen cycles"
echo "    4. By hand: 1Password, GlobalProtect, Claude Code"
echo "#########################################################"
