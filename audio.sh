#!/bin/bash

# [CC licence Attribution - no commercial usage - Share alike 4.0 International http://creativecommons.org/licenses/by-nc-sa/4.0/] [07.07.2016]
# Contributors: [Alexandre Racine] <alexandre.racine1@gmail.com> | [Igor Milhit] <igor@milhit.ch>

# This analyses your system to check your OS.
	
	os=$(uname -s)
	
# If your OS is Linux then...

	if [ "$os" == "Linux" ]
	then
	
# Choose which audio device you want to record writing the number (eg: 1 or 0 or other number) when asked for. The script will adapt the command accorded to your system.
# To find the number related to your prefered audio device please type "arecord -l" in another terminal prompt.

	echo "Choose the audio device you want to record (eg: 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing 
[arecord -l] in your shell :"
	read lindevice
	
# If your system is OS X then...

	elif [ "$os" == "Darwin" ]
	then

# Do the same but the command to find your prefered device is ffmpeg -f avfoundation -list_devices true -i ""

	echo "Choose the audio device you want to record (eg: 1 or 0 or other number) and press ENTER. You can look which number it is according to your system writing
[ffmpeg -f avfoundation -list_devices true -i \"\"] :"

	read osxdevice

# If your system is neither Linux nor OS X then the script will end here.

	else
	
	echo "Your system is neither linux nor osx so this program won't work for now. Please try it with one of these os"
	
	exit 1
	fi

# Choose the path where you want to record audio writing it when asked for.

	echo "Choose the path where you want to record audio and press ENTER :"
	read -e path

# Choose the name you want for your audio file writing it when asked for.

	echo "Choose the name of your audio file and press ENTER :"
	read name

# This part will adapt the audio record command accorded to the informations you provided.

	if [ "$os" == "Linux" ] && [ -n $path ] && [ -n $name ];
	then
	ffmpeg -f alsa -i hw:$lindevice -c:a aac $path$name.aac
	echo "audio stream successfully recorded"

	elif [ "$os" == "Darwin" ] && [ -n $path ] && [ -n $name ];
	then
	ffmpeg -f avfoundation -i ":$osxdevice" -c:a aac $path$name.aac
	echo "audio stream successfully recorded"
	
	fi

# You must already have a video file recorded in the same folder. This command will merge it with audio file just recorded.
# Then it renames the file with "_all" at the end.

	for name in "${path%}"*.mp4; do
          ffmpeg -i "$name" -i "${path%}"*.aac -strict experimental "${name%.mp4}"_all.mp4;
        done

        echo "successfully merged with video file"

 
 exit 0

