#!/bin/bash
# collectCameraData.sh
# Author: Derin Dutz
# ------------------
# This program runs NIViewer and collects camera data. The program then
# transfers the files to an external hard drive and changes their name.

DIRECTORYNAME=$(date '+%F_%H-%M-%S')
FILENAME="${DIRECTORYNAME}.oni"

NIVIEWER_DIRECTORY="/Users/Derin/Desktop/OpenNIdrivers/OpenNI-MacOSX-x64-2.2/Tools"
ONI_TO_PCD_CONVERTER_DIRECTORY="/Users/Derin/Documents/Programs/oni_to_pcd_converter/build"

EXTERNAL_HD_DATA_DIRECTORY="/Volumes/LaCie/Data"
DESKTOP="/Users/Derin/Desktop"

DATA_DIRECTORY="$EXTERNAL_HD_DATA_DIRECTORY"

# Run NIViewer
cd $NIVIEWER_DIRECTORY
./NiViewer

# Check if video data was captured
if test -e "Captured.oni"
then
	# Rename video data file
	mv Captured.oni $FILENAME

	# If external hard drive directory doesn't exist, move data to directory
	# on desktop
	if test ! -d "$EXTERNAL_HD_DATA_DIRECTORY"
	then
		printf 'External HD not found, moving to Desktop\n'
		cd $DESKTOP
		DATA_DIRECTORY="${DESKTOP}/Data"
		if test ! -d "$DATA_DIRECTORY"
		then
			mkdir Data
		fi
	fi

	# Move .oni file to new directory within the data directory
	cd $DATA_DIRECTORY
	mkdir $DIRECTORYNAME
	cd $DIRECTORYNAME
	mv /Users/Derin/Desktop/OpenNIdrivers/OpenNI-MacOSX-x64-2.2/Tools/$FILENAME .
	printf 'Recorded video data at %s/%s/%s\n' "$DATA_DIRECTORY" "$DIRECTORYNAME" "$FILENAME"

	# Convert .oni file to pcd format and place files in pcd_frames directory
	mkdir pcd_frames
	cd $ONI_TO_PCD_CONVERTER_DIRECTORY
	./oni2pcd "${DATA_DIRECTORY}/${DIRECTORYNAME}/${FILENAME}" "${DATA_DIRECTORY}/${DIRECTORYNAME}/pcd_frames"

else
	printf 'No video data recorded.\n'
fi

