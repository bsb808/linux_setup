Config file is from /.config/terminator/config

cp ~/.config/terminator/config ~/.config/terminator/config.orig
#cp ./config.terminator.ex ~/.config/terminator/config
cp terminator_ros_config_ex ~/.config/terminator/config

#cp terminator*.desktop ~/.local/share/applications
desktop-file-install --dir=$HOME/.local/share/applications terminator_ros.desktop
