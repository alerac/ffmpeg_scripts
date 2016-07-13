#!/bin/bash

# [CC licence Attribution - no commercial usage - Share alike 4.0 International http://creativecommons.org/licenses/by-nc-sa/4.0/] [07.07.2016]
# Contributors: [Alexandre Racine] <alexandre.racine1@gmail.com> | [Igor Milhit] <igor@milhit.ch>

# This analyses your system to check your OS

	os=$(uname -s)

# If your OS is Linux then... 

	if [ "$os" == "Linux" ]
	then

# Look for your screen resolution (e.g. 1920x1080) and enter it when asked for.

	echo "Enter your screen resolution as this example (e.g. 1920x1080) and press ENTER :"

	read reslinux

# Capt the display value number in a variable. Apparently this number can change sometimes. Hopefully it is possible to have it with an envir. variable.

	disp=$DISPLAY

# Look for your screen device number (e.g. 1 or 0 or other number) and enter it when asked for. The script will adapt the command accorded to your system.
# To find the number related to your prefered device please type "arecord -l" in another terminal prompt.

	echo "Enter you screen device number (e.g. 1 or 0 or other number) and press ENTER. You can find this number by writing [arecord -l] in your shell :"

	read linscreen

# If your OS is OS X then...

	elif [ "$os" == "Darwin" ]
	then

# Do the same but the command to find your prefered device is ffmpeg -f avfoundation -list_devices true -i ""

	echo "Choose the video device you want to record (e.g. 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing 
[ffmpeg -f avfoundation -list_devices true -i \"\"] in your shell. :"

	read resosx

# If your system is neither Linux nor OS X then the script will end here.

	else

	echo "Your system is neither linux nor OS X so this program won't work for now. Please try it with one of these os"
	exit 1

	fi

# Choose the path where you want to record the video writing it when asked for.

	echo "Choose the path where you want to record video and press ENTER :"
	read -e path

# Choose the name you want for your video file writing it when asked for.

	echo "Choose the name of your video file and press ENTER :"
	read name

# This part will adapt the video record command accorded to the informations you provided.	

	if [ "$os" == "Linux" ] && [ -n $path ] && [ -n $name ];
	then

	ffmpeg  -video_size "$reslinux" -framerate 30 -f x11grab -i "$disp"."$linscreen" -c:v libx264 -qp 0 -preset ultrafast $path$name.mp4
	echo "video stream successfully recorded"
	
	elif [ "$os" == "Darwin" ] && [ -n $path ] && [ -n $name ];
	then

	ffmpeg -f avfoundation -capture_cursor 1 -capture_mouse_clicks 1 -i "$resosx" -c:v libx264 -qp 0 -preset ultrafast $path$name.mp4
	echo "video stream successfully recorded"
	
	fi
 
 exit 0
