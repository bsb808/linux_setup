REMOTES=(172.20.90.136
    172.20.90.176 \
    172.20.89.76 \
    172.20.90.155 )

for REMOTE in "${REMOTES[@]}"
do
    
    echo ${REMOTE}
    #ssh-copy-id -i ~/.ssh/id_rsa.pub frl@${REMOTE}
    #ssh frl@${REMOTE} 'echo !!Control | sudo -S apt-get install -y git'
    #ssh frl@${REMOTE} 'mkdir WorkingCopies && cd WorkingCopies && git clone https://github.com/bsb808/linux_setup.git'
    
    #ssh frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ && git pull'
    #ssh frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ubuntu && echo !!Control | sudo -S ./newinstall_14_shuttle.sh'

    ssh frl@${REMOTE} 'cd ~/WorkingCopies/linux_setup/ && git pull'
    ssh frl@${REMOTE} 'echo !!Control | sudo -S ~/WorkingCopeis/linux_setup/ubuntu/aptget-ros-indigo.sh'

    
done