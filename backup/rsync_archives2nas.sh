#!/bin/bash
#IP="172.20.88.151"
#IP="172.20.81.62"
IP="172.20.82.184"
sshpass -p '!!Control' rsync -azv /media/InternalDrive/frl/ bsb@${IP}::frl/
sshpass -p '!!Control' rsync -azv /media/InternalDrive/bsb/ bsb@${IP}::bsb/
