#!/bin/bash

# Commands to be executed by the executecmds.sh script
CMDS=("git commit -a -m \"Saving temporarary work - just in case\"" \
    "git branch tmp-saved-work" \
    "git fetch origin" \
    "git reset --hard origin/master" )
