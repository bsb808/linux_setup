#/bin/bash

# Disable stupid edge tiling - https://askubuntu.com/questions/1029168/how-do-i-disable-the-window-resizing-when-accidentally-touching-one-of-the-scree
gsettings set org.gnome.mutter edge-tiling false
# May have to also...
#gsettings set org.gnome.shell.overrides edge-tiling false
