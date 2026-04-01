#!/bin/bash

./aptget-upgrade.sh

./aptget_14_base.sh

./aptget_14_extra.sh

./install14_config.sh

./aptget-ros-indigo.sh

./serial-perms.sh

#./aptget-latex.sh
