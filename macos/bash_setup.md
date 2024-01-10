# Bash Setup for MacOS

Change default shell to bash:


```
chsh -s /bin/bash
```

Add sourcing instructions to `.bash_profle` and `.bashrc` to source these version controled files in this repo.

```
echo "source ${HOME}/WorkingDirectory/linux_setup/macos/dot_bash_profile" >> ${HOME}/.bash_profile
echo "source ${HOME}/WorkingDirectory/linux_setup/macos/dot_bashrc" >> ${HOME}/.bashrc
```
