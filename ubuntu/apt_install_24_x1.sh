#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "=== Installing base + development packages ==="
sudo apt-get install -y \
    aptitude \
    autoconf \
    build-essential \
    ca-certificates \
    cifs-utils \
    cmake \
    curl \
    gdebi \
    git \
    gnupg \
    gtkterm \
    htop \
    iputils-ping \
    libtool \
    minicom \
    nano \
    net-tools \
    ntp \
    ntpdate \
    openssh-server \
    picocom \
    ruby \
    software-properties-common \
    ssh \
    unzip \
    vim \
    vpnc \
    wget \
    zip

echo "=== Installing Python scientific stack ==="
sudo apt-get install -y \
    ipython3 \
    python3-matplotlib \
    python3-numpy \
    python3-scipy \
    python3-serial

echo "=== Installing user-friendly applications ==="
sudo apt-get install -y \
    gnome-software \
    libreoffice \
    p7zip-full \
    p7zip-rar \
    shotwell \
    simple-scan \
    ubuntu-restricted-extras \
    unrar \
    vlc

echo "=== Installing creative tools ==="
sudo apt-get install -y \
    gimp \
    inkscape

echo "=== Installing system tools ==="
sudo apt-get install -y \
    gparted \
    timeshift

echo "=== Installing GNOME UI customization tools ==="
sudo apt-get install -y \
    gnome-shell-extensions \
    gnome-tweaks \
    chrome-gnome-shell

echo "=== Installing Google Chrome ==="
#wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo apt-get install -y ./google-chrome-stable_current_amd64.deb || sudo apt-get -f install -y
#rm -f google-chrome-stable_current_amd64.deb

echo "=== Installing Sublime Text ==="
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install -y sublime-text

echo "=== Optional: exFAT support ==="
sudo apt-get install -y exfatprogs || true

echo "=== Cleaning up ==="
sudo apt-get autoremove -y

echo "=== Installing Slack ==="
wget -q https://downloads.slack-edge.com/releases/linux/4.38.121/prod/x64/slack-desktop-4.38.121-amd64.deb
sudo apt-get install -y ./slack-desktop-4.38.121-amd64.deb || sudo apt-get -f install -y
rm -f slack-desktop-4.38.121-amd64.deb


echo "=== Installing Visual Studio Code ==="

# Add Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

# Add VS Code repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Install
sudo apt-get update
sudo apt-get install -y code

echo "=== Done! ==="
echo ""
echo "Next steps:"
echo "1. Log out/in"
echo "2. Open Extensions app and enable:"
echo "   - Ubuntu Dock"
echo "   - (Install via browser) Dash to Dock, Arc Menu"
echo "3. Run: gnome-tweaks"
echo "   - Enable minimize/maximize buttons"
echo "4. Pin Chrome, Files, LibreOffice to dock"
echo "5. Sign into Chrome for sync"
echo "6. Configure Timeshift backups"
