#!/bin/bash

RULE="SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"15d1\", SYMLINK+=\"hokuyo\" "
RFILE="98-thingmagic-serial.rules"
echo \"${RULE}\" > ${RFILE}"
