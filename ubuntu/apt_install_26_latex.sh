#!/bin/bash
# LaTeX and writing toolchain. Large — around 3 GB — so it is kept separate
# from the base install and can be skipped on a machine that will not write papers.

set -e
cd "$(dirname "$0")"
source ./lib_apt.sh

echo "=== TeX Live ==="
apt_try \
    texlive \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-science \
    texlive-publishers \
    texlive-bibtex-extra \
    texlive-plain-generic \
    latexmk \
    biber

echo "=== Reference and diagram tools ==="
apt_try jabref tikzit

echo "=== Quarto ==="
if ! command -v quarto >/dev/null 2>&1; then
    echo "Quarto is not in the Ubuntu archive."
    echo "Download the .deb from https://quarto.org/docs/download/ and install with:"
    echo "  sudo apt-get install -y ./quarto-*-amd64.deb"
fi

apt_report
echo "=== LaTeX done ==="
