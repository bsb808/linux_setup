#!/bin/bash
# Shared helpers for the 26.04 install scripts.
# Sourced, not executed.

MISSING_LOG="${MISSING_LOG:-/tmp/linux_setup_missing.txt}"

# Install a list of packages. If the batch fails because one name has drifted
# between releases, fall back to one at a time so a single bad name does not
# abort the run. Anything that will not install is recorded, not fatal.
apt_try() {
    local pkgs=("$@")
    if sudo apt-get install -y "${pkgs[@]}" 2>/dev/null; then
        return 0
    fi
    echo "--- batch install failed, retrying one at a time ---"
    local p
    for p in "${pkgs[@]}"; do
        if ! sudo apt-get install -y "$p" 2>/dev/null; then
            echo "SKIPPED: $p"
            echo "$p" >> "$MISSING_LOG"
        fi
    done
}

# Report at the end of a script.
apt_report() {
    if [ -s "$MISSING_LOG" ]; then
        echo
        echo "=== Packages that did not install ==="
        sort -u "$MISSING_LOG"
        echo "Check whether the name changed in 26.04, or whether the"
        echo "universe/multiverse components are enabled."
    fi
}
