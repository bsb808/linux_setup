#!/bin/bash

# Symlink dotfile packages into $HOME with GNU stow.
# Usage: dotfiles/stow.sh [package ...]   (default: every package here)
# A real file already at a target is moved to ~/.dotfiles-backup/<time>/ first.

set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

if [ $# -eq 0 ]; then
    set -- */
fi

BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

for pkg in "$@"; do
    pkg="${pkg%/}"
    (cd "$pkg" && find . -type f -o -type l) | while read -r f; do
        target="$HOME/${f#./}"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            mkdir -p "$BACKUP/$(dirname "${f#./}")"
            mv "$target" "$BACKUP/${f#./}"
            echo "backed up $target -> $BACKUP/${f#./}"
        fi
    done
    stow --restow --target="$HOME" "$pkg"
    echo "stowed $pkg"
done
