#!/bin/bash
# Desktop applications for Ubuntu 26.04 LTS on the X1 Carbon.
# Vendor repos where they exist, stable download URLs where they do not.

set -e
cd "$(dirname "$0")"
source ./lib_apt.sh

echo "=== Desktop applications from the archive ==="
apt_try \
    calibre \
    dia \
    ffmpeg \
    gimp \
    gparted \
    inkscape \
    keepassx \
    ksnip \
    libreoffice \
    okular \
    pstoedit \
    shotwell \
    simple-scan \
    thunderbird \
    vlc \
    xournalpp

echo "=== Media codecs ==="
apt_try ubuntu-restricted-extras libavcodec-extra gstreamer1.0-libav

echo "=== GNOME customisation ==="
# chrome-gnome-shell was renamed gnome-browser-connector; try both.
apt_try gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager
apt_try gnome-browser-connector || apt_try chrome-gnome-shell

echo "=== Terminal ==="
apt_try terminator emacs

echo "=== Google Chrome ==="
if ! command -v google-chrome >/dev/null 2>&1; then
    TMPDEB=$(mktemp /tmp/chrome-XXXX.deb)
    wget -q -O "$TMPDEB" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt-get install -y "$TMPDEB" || sudo apt-get -f install -y
    rm -f "$TMPDEB"
    # The deb installs Google's apt repo, so updates arrive with apt from here on.
fi

echo "=== Visual Studio Code ==="
if ! command -v code >/dev/null 2>&1; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt-get update
    apt_try code
fi

echo "=== Sublime Text ==="
if ! command -v subl >/dev/null 2>&1; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
        | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" \
        | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null
    sudo apt-get update
    apt_try sublime-text
fi

echo "=== Zoom ==="
if ! command -v zoom >/dev/null 2>&1; then
    # zoom.us/client/latest/ is a stable redirect to the current build (verified 2026-09-24).
    TMPDEB=$(mktemp /tmp/zoom-XXXX.deb)
    wget -q -O "$TMPDEB" https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt-get install -y "$TMPDEB" || sudo apt-get -f install -y
    rm -f "$TMPDEB"
fi

echo "=== Slack ==="
# Slack no longer publishes a stable 'latest' deb URL and has no apt repo;
# the snap is the maintained path.
if ! command -v slack >/dev/null 2>&1; then
    sudo snap install slack || echo "SKIPPED: slack (install by hand from slack.com/downloads)"
fi

echo "=== Cleaning up ==="
sudo apt-get autoremove -y

apt_report
echo "=== Apps done ==="
echo
echo "By hand, not scriptable:"
echo "  1Password       - deb from 1password.com/downloads/linux"
echo "  GlobalProtect   - deb from the NPS VPN portal"
echo "  Claude Code     - curl -fsSL https://claude.ai/install.sh | bash"
