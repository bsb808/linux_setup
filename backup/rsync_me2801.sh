#!/bin/bash


EXTER=/media/bsb/MOE-Bingham/iwi/bsb/Classes/ME2801/
LOCAL=${HOME}/Classes/ME2801/
DR='--dry-run'
DR=''

rsync -av ${DR} --exclude-from='exclude_me2801.txt' ${EXTER} ${LOCAL}
