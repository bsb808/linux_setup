#!/bin/bash
echo "KERNEL=="\""ttyUSB[0-9]*"\"",MODE="\""0666"\" >> /etc/udev/rules.d/50-myusb.rules
echo "KERNEL=="\""ttyACM[0-9]*"\"",MODE="\""0666"\" >> /etc/udev/rules.d/50-myusb.rules
