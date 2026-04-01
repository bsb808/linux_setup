#!/bin/bash

#gsettings set org.gnome.nautilus.preferences enable-interactive-search true
# Need to change window switching back to alt-tab
# See, http://askubuntu.com/questions/68151/how-do-i-revert-alt-tab-behavior-to-switch-between-windows-on-the-current-worksp

# Tweaks
cp ../generic/dot_emacs ~/.emacs


# Get rid of overlay scroll bars
gsettings set com.canonical.desktop.interface scrollbar-mode normal
# Enable recursive search
gsettings set org.gnome.nautilus.preferences enable-interactive-search false
# Disable recursive search (type-ahead search)

# Move window buttons to the right side
gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'

apt-get remove indicator-messages


# add myself to the dialout group for permissions to serial ports
#sudo adduser bsb dialout
