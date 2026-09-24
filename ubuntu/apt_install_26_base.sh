#!/bin/bash
# Base system for Ubuntu 26.04 LTS on the X1 Carbon Gen 9.
# Development tooling, python, docker, serial. No GUI apps here.

set -e
cd "$(dirname "$0")"
source ./lib_apt.sh

echo "=== Enabling universe and multiverse ==="
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse

echo "=== Updating system ==="
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "=== Core command line ==="
apt_try \
    aptitude \
    build-essential \
    ca-certificates \
    cifs-utils \
    cmake \
    curl \
    autoconf \
    libtool \
    gnupg \
    htop \
    iputils-ping \
    jq \
    nano \
    net-tools \
    openssh-server \
    rsync \
    software-properties-common \
    ssh \
    tree \
    unzip \
    vim \
    wget \
    zip

echo "=== Clipboard: Wayland first, xclip for XWayland apps ==="
apt_try wl-clipboard xclip

echo "=== Git tooling ==="
apt_try git git-lfs gh git-filter-repo

echo "=== Python ==="
apt_try \
    ipython3 \
    python3-matplotlib \
    python3-numpy \
    python3-pip \
    python3-scipy \
    python3-serial \
    python3-setuptools \
    python3-venv \
    python3-virtualenv

echo "=== Serial and embedded ==="
apt_try gtkterm minicom picocom

echo "=== Archives and filesystems ==="
apt_try p7zip-full p7zip-rar unrar rar sharutils unace exfatprogs

echo "=== Docker ==="
if ! command -v docker >/dev/null 2>&1; then
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # download.docker.com publishes a 'resolute' suite for 26.04 (verified 2026-09-24).
    CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    apt_try docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "docker already present, skipping repo setup"
fi

echo "=== Docker without sudo ==="
sudo groupadd -f docker
sudo usermod -aG docker "$USER"
echo "Log out and back in for the docker group to take effect."

apt_report
echo "=== Base done ==="
