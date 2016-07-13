#!/bin/bash

# [CC licence Attribution - no commercial usage - Share alike 4.0 International http://creativecommons.org/licenses/by-nc-sa/4.0/] [07.07.2016]
# Contributors: [Alexandre Racine] <alexandre.racine1@gmail.com> | [Igor Milhit] <igor@milhit.ch>

# Enter the path to the folder which contains the video previously recorded.

	echo "Write the path to folder containing the audio and video files previously recorded and press ENTER :"
	read -e path

# For the original mp4 file in the folder, cut at the right time slots and rename wit "_cut" at the end.
# Then convert the "*_cut" file in .mov and .webm files.
	
	for name in "${path%}"*.mp4; do
	ffmpeg -i "$name" -ss 00:00:02 -t 00:00:11 -async 1 -strict -2 "${name%.mp4}"_cut.mp4;
	done
	for name in "${path%}"*_cut.mp4; do
	ffmpeg -i "$name" -c:v libxvid -qscale:v 3 -async 1 -strict -2 "${name%.mp4}".mov;
	done
	for name in "${path%}"*_cut.mp4; do
	ffmpeg -i "$name" -c:v libvpx -crf 18 -c:a libvorbis -b:v 0 -async 1 -strict -2 "${name%.mp4}".webm;
	done

	echo "Video successfully cut and converted"

# Rename your file as you want (e.g. final)

	echo "Rename your file as you want (e.g. final) and press ENTER :"
	read name
	if [ -n $name ];
	then
	mv "${path%}"*_cut.mp4 "${path%}"${name}.mp4
	mv "${path%}"*_cut.webm "${path%}"${name}.webm
	mv "${path%}"*_cut.mov "${path%}"${name}.mov
	fi
	
exit 0
