#!/bin/bash
sudo chown -R ${USER}:${USER} ${HOME}/.matlab
echo "export GTK_PATH=/usr/lib/x86_64-linux-gnu/gtk-2.0" >> ~/.bashrc
source ~/.bashrc
