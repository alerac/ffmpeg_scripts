# ffmpeg_scripts

Some basic scripts to automatize the tutorial creation workflow with ffmpeg. For all those who want to create tutorials with a free and powerful software through command line tool.

# History

In a previous version there was separate scripts for Linux and Mac OSX. In this new version, variables which contain input asked to users are able to adapt the ffmpeg commands according to user's operating system. To do this, these scripts will ask you to enter as input your OS, path and filename you want for you project. Read carefully what your shell is asking you. A dedicated folder should be created to avoid creating problems with other media files you could have on your computer.

## Scripts construction

Assuming the recording of your screen and audio at the same time could demand a lot of ressources to your CPU, this workflow is built to aim at reducing this demand by splitting the process of recording audio and video.

1. Run the `audio.sh` script and press `q` when you want to stop recording  
2. Run the `video.sh` script while listening to the audio and press `q` when you want to stop recording. 
3. Adapt the time to your needs and run the `cut.sh` script  
	3.1. It will automatically cut the audio and video files according to the time you specified.  
	3.2. It will convert in ".webm" and ".mov" to stream on the web. Due to issues between some browsers and some formats  
	3.2. Then it will merge the audio and video files  
	3.3. Finally it will ask you to give a name to your final file  

Watch to have the audio and video files at the same duration to be well synchronized in the final file. Normally the final duration of the two files should be the same.

## Comments

The scripts are full of comments describing what they do and what you have to do. Please read them and ask me if it is not clear.
