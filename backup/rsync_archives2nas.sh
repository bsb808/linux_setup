#!/bin/bash
sshpass -p '!!Control' rsync -azv /media/InternalDrive/frl/ bsb@172.20.81.11::frl/
sshpass -p '!!Control' rsync -azv /media/InternalDrive/bsb/ bsb@172.20.81.11::bsb/
