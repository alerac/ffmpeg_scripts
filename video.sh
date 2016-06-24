#!/bin/bash

# Choose your os writing "linux" or "osx" without capital letters. The script will adapt the command accorded to your system.

	echo "Choose your OS (eg: linux or osx) without capital letters, same as example, and press ENTER :"
	read os

	if [ "$os" != "linux" ] && ["$os" != "osx" ];
	then
	echo "Too bad ! It can not work with your system. Please enter linux or osx to run the script"
	
	exit 0

	elif [ "$os" == "linux" ];
	then

# for Linux, look for your screen resolution (eg: 1920x1080) and enter it when asked for.

	echo "Enter your screen resolution as this example (eg: 1920x1080) and press ENTER :"

	read reslinux

# For osx, type [ffmpeg -f avfoundation -list_devices true -i ""] if you need to know the number related to your screen device. Then type the number related to your screen device when asked for.	
	
	else

	echo "Choose the video device you want to record (eg: 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing 	      [ffmpeg -f avfoundation -list_devices true -i ""] in your shell."

	read resosx
	fi

# Choose the path where you want to record video writing the path when asked for. The path should be the same as the audio file previously recorded for future works.

	echo "Choose the path where you want to record video and press ENTER :"
	read path

# Choose the name you want for your video file writing the name when asked for.

	echo "Choose the name of your video file and press ENTER :"
	read name

# This part will adapt the video record command accorded to the informations you provided.	

	if [ "$os" == "linux" ] && [ -n $path ] && [ -n $name ];
	then

	ffmpeg  -video_size "$reslinux" -framerate 30 -f x11grab -i :0.0 -c:v libx264 -qp 0 -preset ultrafast $path/$name.mp4
	echo "video stream successfully recorded"
	
	elif [ "$os" == "osx" ] && [ -n $path ] && [ -n $name ];
	then

	ffmpeg -f avfoundation -capture_cursor 1 -capture_mouse_clicks 1 -i "$resosx" -c:v libx264 -qp 0 -preset ultrafast $path/$name.mp4
	echo "video stream successfully recorded"
	
	fi
 
 exit 0
