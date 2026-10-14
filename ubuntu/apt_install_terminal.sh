#!/bin/bash

# Terminal setup for Claude Code work, Ubuntu 22.04 and 24.04.
# Run with sudo, then run dotfiles/stow.sh as your user.

apt -y update

apt install -y \
    fzf \
    stow \
    tmux \
    wl-clipboard \
    xclip

# Ghostty terminal (snap by Ken VanDine; classic confinement)
snap install ghostty --classic
