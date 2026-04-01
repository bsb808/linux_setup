#!/bin/bash

# add user to the dialout group for permissions to serial ports
adduser ${USER} dialout
# sudo adduser frl dialout

#./serial-perms.sh

ntpdate time.nps.edu
