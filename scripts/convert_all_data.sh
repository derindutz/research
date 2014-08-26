#!/bin/bash
#
# File: convert_all_data.sh
# Author: Derin Dutz
# Date: 08/24/14
# -------------------
# Description: converts all data to dst format.

##### Constants

readonly DATA_DIRECTORY=/media/derin/LaCie/Data

##### Main

for recording_dir in $DATA_DIRECTORY/*; do
  if [[ ! -e $recording_dir/info.txt ]]; then
    cd $recording_dir
    convert_data.sh -a
  fi
done
