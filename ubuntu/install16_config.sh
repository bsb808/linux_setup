#!/bin/bash

#gsettings set org.gnome.nautilus.preferences enable-interactive-search true
# Need to change window switching back to alt-tab
# See, http://askubuntu.com/questions/68151/how-do-i-revert-alt-tab-behavior-to-switch-between-windows-on-the-current-worksp

# Tweaks
cp ../generic/dot_emacs ~/.emacs


# add myself to the dialout group for permissions to serial ports
sudo adduser bsb dialout
