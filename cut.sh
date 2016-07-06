#!/bin/bash

# [CC licence Attribution - no commercial usage - Share alike 4.0 International http://creativecommons.org/licenses/by-nc-sa/4.0/] [07.07.2016]
# Contributors: [Alexandre Racine] <alexandre.racine1@gmail.com> | [Igor Milhit] <igor@milhit.ch>

# Enter the path to the folder which contains the audio and video files previously recorded. Audio and video files should be in the same folder.

	echo "Write the path to folder containing the audio and video files previously recorded and press ENTER :"
	read -e path

# For the merged mp4 file in the folder, cut at the right time slots and rename wit "_cut" at the end.
# Then convert in .mov and .webm files
	
	for name in "${path%}"*_all.mp4; do
	ffmpeg -i "$name" -ss 00:00:02 -t 00:00:32 -async 1 -strict -2 "${name%.mp4}"_cut.mp4;
	done
	for name in "${path%}"*_all.mp4; do
	ffmpeg -i "$name" -ss 00:00:02 -t 00:00:32 -c:v libxvid -qscale:v 3 -async 1 -strict -2 "${name%.mp4}"_cut.mov;
	done
	for name in "${path%}"*_all.mp4; do
	ffmpeg -i "$name" -ss 00:00:02 -t 00:00:32 -c:v libvpx -crf 18 -c:a libvorbis -b:v 0 -async 1 -strict -2 "${name%.mp4}"_cut.webm;
	done

	echo "Video successfully cut and converted"

# Rename your file as you want (eg: final)

	echo "Rename your file as you want (eg: final) and press ENTER :"
	read name
	if [ -n $name ];
	then
	mv "${path%}"*_cut.mp4 "${path%}"${name}.mp4
	mv "${path%}"*_cut.webm "${path%}"${name}.webm
	mv "${path%}"*_cut.mov "${path%}"${name}.mov
	fi

#Remove files with "_all" and keep the original audio and video files + the final files.
	
	rm "${path%}"*_all*
exit 0
