#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Installing core apps ==="
sudo apt-get install -y \
    cups \
    curl \
    fonts-dejavu \
    fonts-liberation \
    gimp \
    inkscape \
    libreoffice \
    nano \
    p7zip-full \
    p7zip-rar \
    printer-driver-all \
    shotwell \
    simple-scan \
    thunderbird \
    unrar \
    unzip \
    vim \
    vlc \
    wget \
    xournalpp \
    zip

echo "=== Installing media codecs ==="
sudo apt-get install -y mint-meta-codecs

#echo "=== Installing Google Chrome ==="
#wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo apt-get install -y ./google-chrome-stable_current_amd64.deb || sudo apt-get -f install -y
#rm -f google-chrome-stable_current_amd64.deb

echo "=== Setting Chrome as default browser ==="
xdg-mime default google-chrome.desktop x-scheme-handler/http
xdg-mime default google-chrome.desktop x-scheme-handler/https
xdg-mime default google-chrome.desktop text/html
gio mime x-scheme-handler/http google-chrome.desktop
gio mime x-scheme-handler/https google-chrome.desktop
gio mime text/html google-chrome.desktop

echo "=== Cleaning up ==="
sudo apt-get autoremove -y

echo "=== Done! Recommended next steps: ==="
echo "1. Log out and back in"
echo "2. Pin Chrome, Files, and LibreOffice to the panel"
echo "3. Open Update Manager and enable automatic updates"
