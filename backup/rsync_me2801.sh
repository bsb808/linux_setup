#!/bin/bash


EXTER=/media/bsb/MOE-Bingham/iwi/bsb/Classes/ME2801/
LOCAL=${HOME}/Classes/ME2801/

rsync -av --dry-run ${LOCAL} ${EXTER}
