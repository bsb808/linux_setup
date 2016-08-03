#!/bin/bash

REMOTES=(poke.ern.nps.edu \
    pipikaula.ern.nps.edu \
    musubi.ern.nps.edu \
    laulau.ern.nps.edu)

for REMOTE in "${REMOTES[@]}"
do
    
    echo ${REMOTE}
    #ssh-copy-id -i ~/.ssh/id_rsa.pub frl@${REMOTE}
    #ssh frl@${REMOTE} 'mkdir ~/WorkingCopies && cd ~/WorkingCopies/ && git clone https://github.com/bsb808/linux_setup.git'
    #ssh frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ && git pull'
    #ssh -t frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ && echo !!Control | sudo -S ls'
    #ssh -t frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ubuntu && echo !!Control | sudo -S ./serial-perms.sh'
    #ssh -t frl@${REMOTE} 'cat /etc/udev/rules.d/50-myusb.rules'
    ssh -t frl@${REMOTE} 'echo !!Control | sudo -S apt-get install -y gtkterm'
done

