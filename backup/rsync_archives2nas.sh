#!/bin/bash
IP="172.20.88.151"
sshpass -p '!!Control' rsync -azv /media/InternalDrive/frl/ bsb@${IP}::frl/
sshpass -p '!!Control' rsync -azv /media/InternalDrive/bsb/ bsb@${IP}::bsb/
