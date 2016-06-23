#!/bin/bash

# Enter the path to the folder which contains the audio and video files previously recorded. Audio and video files should be in the same folder.

	echo "Write the path to folder containing the audio and video files previously recorded and press ENTER :"
	read path

# For the audio.aac file cut the file from the time [HH:MM:SS] for a duration of [HH:MM:SS] eg: from second 3 until second 30 put 00:00:03 -t 00:00:27.
# And rename the file with "_cut".
# Watch to have the same duration for the audio & video file to synchronize.

	for name in "${path%}"*.aac; do
	ffmpeg -i "$name" -ss 00:00:01 -t 00:00:10 -c:a copy "${name%.aac}"_cut.aac
	done
	
	echo "Audio successfully cut"

# For every ".mp4" file, cut the video from the time [HH:MM:SS] for a duration of [HH:MM:SS] eg: from second 1 until second 28 put 00:00:01 -t 00:00:27
# And convert in ".webm" and ".mov" files while adding "_cut" in the name.
# Adapt the 2 time values according to your needs.
	
	for name in "${path%}"*.mp4; do
	ffmpeg -i "$name" -ss 00:00:01 -t 00:00:10 -async 1 -strict -2 "${name%.mp4}"_cut.mp4;
	ffmpeg -i "$name" -ss 00:00:01 -t 00:00:10 -c:v libxvid -qscale:v 3 -async 1 -strict -2 "${name%.mp4}"_cut.mov;
	ffmpeg -i "$name" -ss 00:00:01 -t 00:00:10 -c:v libvpx -crf 18 -c:a libvorbis -b:v 0 -async 1 -strict -2 "${name%.mp4}"_cut.webm;
	done

	echo "Video successfully cut and converted"

# Compile the cut audio & video files. Watch to have the audio & video files synchronized with the same duration.
# Rename with "_all" at the end.

	for name in "${path%}"*_cut.mp4; do	
          ffmpeg -i "$name" -i "${path%}"*_cut.aac -strict experimental "${name%.mp4}"_all.mp4;
        done
        for name in "${path%}"*_cut.mov; do
          ffmpeg -i "$name" -i "${path%}"*_cut.aac -c:v libxvid -c:a aac -qscale:v 3 -strict experimental "${name%.mov}"_all.mov;
        done
        for name in "${path%}"*_cut.webm; do
          ffmpeg -i "$name" -i "${path%}"*_cut.aac -c:v libvpx -crf 18 -b:v 0 -c:a libvorbis -strict experimental "${name%.webm}"_all.webm;
        done

	echo "successfully merged and converted"

# Rename your final file as you want (eg: final). This part will automatically rename your file accorded to the input you gave.	

	echo "Rename your file as you want (eg: final) and press ENTER :"
	read name
	if [ -n $name ];
	then
	mv "${path%}"*_all.mp4 "${path%}"${name}.mp4
	mv "${path%}"*_all.webm "${path%}"${name}.webm
	mv "${path%}"*_all.mov "${path%}"${name}.mov
	fi

#Remove all "_cut" files and keep the original audio and video files + the final files.
	
	rm "${path%}"*_cut.*

exit 0
