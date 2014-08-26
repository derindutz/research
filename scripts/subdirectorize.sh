#!/bin/bash
#
# File: subdirectorize.sh
# Author: Derin Dutz
# Date: 08/24/14
# -------------------
# Description: moves all the files in a directory into subdirectories which
# each have n files.

##### Constants

readonly DEFAULT_N=1000
readonly DESCRIPTION="description: this script moves all the files in the
                      current directory into subdirectories which each have
                      n files."

##### Functions

function usage {
  echo $DESCRIPTION
  echo "usage: subdirectorize n"
}

##### Main

n=$DEFAULT_N
file_num=0
dir_name=0

if [ $# -gt 0 ]; then
  if [[ $1 =~ ^[0-9]+$ ]] && (( $1 >= 1 )); then
    if [ $# -gt 1 ]; then
      echo "Ignoring excess arguments..."
    fi
    let n=$1
  else
    while [ "$1" != "" ]; do
        case $1 in
            -h | --help )           usage
                                    exit
                                    ;;
            * )                     usage
                                    exit 1
        esac
        shift
    done
    exit
  fi
fi

for file in $(ls); do
  # makes a new directory every n iterations
  if [[ $(expr $file_num % $n) -eq 0 ]]
  then
    let dir_name=file_num
    mkdir $dir_name
  fi

  mv $file $dir_name/$file

  let file_num=file_num+1
done
