#!/bin/bash
#
# File: convert_data.sh
# Author: Derin Dutz
# Date: 08/24/14
# -------------------
# Description: converts data in current directory to dst format.

##### Constants

readonly DEFAULT_FRAMES_PER_DIRECTORY=1000

readonly FRAME_COUNT_INFO="frame count: "
readonly SUBDIRECTORIZATION_INFO="subdirectorized: true"
readonly CONVERSION_INFO="converted to dst format: true"

##### Functions

function usage {
  echo "usage: convert_all_data "
}

##### Main

frames_per_directory=$DEFAULT_FRAMES_PER_DIRECTORY
isframecount=false
issubdirectorization=false
isconversion=false

while [ "$1" != "" ]; do
    case $1 in
        -h | --help )                   usage
                                        exit
                                        ;;
        -f | --framecount )             isframecount=true
                                        ;;
        -s | --subdirectorization )     issubdirectorization=true
                                        ;;
        -c | --conversion )             isconversion=true
                                        ;;  
        -a | --all )                    isframecount=true
                                        issubdirectorization=true
                                        isconversion=true
                                        ;;                                                                   
        * )                             usage
                                        exit 1
    esac
    shift
done

recording_dir=$(pwd)
# frame counting step
if [[ $isframecount = true ]]; then
  frame_count=$(find $recording_dir/pcd_frames/ -name "*.pcd" -type f -print| wc -l)
  echo "INFORMATION" > $recording_dir/info.txt
  echo "-----------" >> $recording_dir/info.txt
  echo $FRAME_COUNT_INFO$frame_count  >> $recording_dir/info.txt
  echo "Counted number of frames: "$frame_count
fi

# subdirectorization step
if [[ $issubdirectorization = true ]]; then
  cd $recording_dir/pcd_frames
  subdirectorize.sh $frames_per_directory
  echo $SUBDIRECTORIZATION_INFO >> $recording_dir/info.txt
  echo "Subdirectorized frames"
fi

# conversion step
if [[ $isconversion = true ]]; then
  for subdirectory in $recording_dir/pcd_frames/*; do
    cd $subdirectory
    convert_pcd_to_png.sh
  done
  echo $CONVERSION_INFO >> $recording_dir/info.txt
  echo "Converted data to dst format"
fi
