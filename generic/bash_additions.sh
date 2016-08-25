export EDITOR=nano

# function for setting executable in SVN
svnexfun() {
  chmod +x $1
  svn propset svn:executable on $1;
}
alias svnex=svnexfun

# function for doing the same with git
function gitexfun(){
  chmod +x $1
  git update-index --chmod=+x $1
}
alias gitex='gitexfun'

# For ROS
source /opt/ros/indigo/setup.bash
source ~/catkin_ws/devel/setup.bash



# Networking
alias sshShuttle0="ssh frl@192.168.11.50"
alias sshShuttle1="ssh frl@192.168.11.51"
alias sshShuttle2="ssh frl@192.168.11.52"
alias sshShuttle3="ssh frl@192.168.11.53"

# Git
fgitcommit() {
  if [ "$#" -lt 1 ]; then
      echo "Mush supply a commit message!"
  else
      git commit -a -m $1
      git push origin master
  fi
}
alias gitcommit=fgitcommit