#!/bin/bash
RULEF="90-my.rules"
echo "KERNEL=="\""ttyUSB[0-9]*"\"",MODE="\""0666"\" >> /etc/udev/rules.d/${RULEF}
echo "KERNEL=="\""ttyACM[0-9]*"\"",MODE="\""0666"\" >> /etc/udev/rules.d/${RULEF}
echo "KERNEL=="\""ttyS[0-9]*"\"",MODE="\""0666"\" >> /etc/udev/rules.d/${RULEF}
echo "KERNEL=="\""tty[A-Z]*[0-9]"\"",MODE="\""0666"\" >> /etc/udev/rules.d/${RULEF}
sudo udevadm control --reload-rules 
sudo udevadm trigger
