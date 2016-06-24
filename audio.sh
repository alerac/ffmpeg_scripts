#!/bin/bash

# Choose your os writing "linux" or "osx" without capital letters when asked for. The script will adapt the command accorded to your system.
# Type [arecord -l] (for Linux) or [ffmpeg -f avfoundation -list_devices true -i ""] (for osx) in your shell if you need to know the number related to your audio device.

	echo "Choose your OS (eg: linux or osx) without capital letters, same as example, and press ENTER :"
	read os

	if [ "$os" == "linux" ]
	then
	
# Choose which audio device you want to record writing the number (eg: 1 or 0 or other number) when asked for. The script will adapt the command accorded to your system.

	echo "Choose the audio device you want to record (eg: 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing 
[arecord -l] in your shell :"
	read lindevice
	
	elif [ "$os" == "osx" ]
	then

	echo "Choose the audio device you want to record (eg: 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing
[ffmpeg -f avfoundation -list_devices true -i \"\"] :"

	read osxdevice

	else
	
	echo "Your system is neither linux nor osx so this program won't work for now. Please try it with one of these os"
	
	exit 1
	fi

# Choose the path where you want to record audio writing the path when asked for.

	echo "Choose the path where you want to record audio and press ENTER :"
	read path

# Choose the name you want for your audio file writing the name when asked for.

	echo "Choose the name of your audio file and press ENTER :"
	read name

# This part will adapt the audio record command accorded to the informations you provided.

	if [ "$os" == "linux" ] && [ -n $path ] && [ -n $name ];
	then
	ffmpeg -f alsa -i hw:$lindevice -c:a aac -qp 0 -preset ultrafast $path/$name.aac
	echo "audio stream successfully recorded"

	elif [ "$os" == "osx" ] && [ -n $path ] && [ -n $name ];
	then
	ffmpeg -f avfoundation -i ":$osxdevice" -c:a aac -qp 0 -preset ultrafast $path/$name.aac
	echo "audio stream successfully recorded"
	
	fi
 
 exit 0

