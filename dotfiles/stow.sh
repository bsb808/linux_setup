#!/bin/bash

# Symlink dotfile packages into $HOME with GNU stow.
# Usage: dotfiles/stow.sh [package ...]   (default: every package here)
# A real file already at a target is moved to ~/.dotfiles-backup/<time>/ first.
# If ~/.bashrc.d exists afterwards, ~/.bashrc gets a block that sources it, once.

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
        # Skip targets already resolving into the repo, including through
        # a directory symlink that stow folded.
        if [ -e "$target" ] && [ "$(realpath "$target")" != "$(realpath "$pkg/$f")" ]; then
            mkdir -p "$BACKUP/$(dirname "${f#./}")"
            mv "$target" "$BACKUP/${f#./}"
            echo "backed up $target -> $BACKUP/${f#./}"
        fi
    done
    stow --restow --target="$HOME" "$pkg"
    echo "stowed $pkg"
done

MARK="# >>> linux_setup: source ~/.bashrc.d >>>"
if [ -d "$HOME/.bashrc.d" ] && ! grep -qxF "$MARK" "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" <<'BASHRC'

# >>> linux_setup: source ~/.bashrc.d >>>
for f in "$HOME"/.bashrc.d/*.sh; do [ -r "$f" ] && . "$f"; done
unset f
# <<< linux_setup: source ~/.bashrc.d <<<
BASHRC
    echo "added ~/.bashrc.d hook to ~/.bashrc"
fi
