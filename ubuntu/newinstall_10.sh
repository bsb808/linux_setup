#!/bin/bash

sudo ./aptget_newinstall.sh
cp ../generic/dot_emacs ~/.emacs


cd ~/Projects/
mkdir FVS
cd FVS
svn co http://svn.bandbshares.com/frl/code/fvs/

cd fvs/trunk/utils
sudo ./aptget_for_lcm.sh

#echo "source ~/Projects/FVS/fvs/trunk/utils/fvs_profile_bsb_desk_new_trunk" >> ~/.bashrc
echo "source ~/Projects/FVS/fvs/trunk/utils/fvs_profile_frl_desk_new_trunk" >> ~/.bashrc

source ~/.bashrc

# Get rid of overlay scroll bars
gsettings set com.canonical.desktop.interface scrollbar-mode normal
# Enable recursive search
gsettings set org.gnome.nautilus.preferences enable-interactive-search false
# Disable recursive search (type-ahead search)

# Move window buttons to the right side
gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'

#gsettings set org.gnome.nautilus.preferences enable-interactive-search true
sudo apt-get install gnome-session-fallback keepassx
# Install Adobe Flash
sudo apt-get install flashplugin-installer
sudo apt-get update
sudo apt-get install adobe-flashplugin
# Pylab
sudo apt-get install python-numpy python-scipy python-matplotlib ipython
# Need to change window switching back to alt-tab
# See, http://askubuntu.com/questions/68151/how-do-i-revert-alt-tab-behavior-to-switch-between-windows-on-the-current-worksp
sudo apt-get install compizconfig-settings-manager compiz-plugins

# Codecs
sudo apt-get install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra
sudo /usr/share/doc/libdvdread4/install-css.sh
sudo apt-get install libxine1-ffmpeg mencoder
#uudeview mpack arj cabextract file-roller
sudo apt-get install git
sudo apt-get install gimp
