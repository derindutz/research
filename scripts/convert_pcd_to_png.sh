#!/bin/bash
#
# File: convert_pcd_to_png.sh
# Author: Derin Dutz
# Date: 08/21/14
# -------------------
# Description: converts all the pcd files in a directory into properly
# formatted pcd and png files.

readonly PNGPREFIX=img
readonly PCDPREFIX=pcd
readonly PCD2PNG=~/scripts/utility/pcl_pcd2png

for orig_pcd_file in $(ls *.pcd); do
  echo $orig_pcd_file
  file_num=`echo | awk ' { print substr("'"$orig_pcd_file"'", 9, 4) } '`

  png_file="${PNGPREFIX}${file_num}.png"
  pcd_file="${PCDPREFIX}${file_num}.pcd"

  $PCD2PNG $orig_pcd_file $png_file
  mv $orig_pcd_file $pcd_file
done
