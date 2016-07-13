# ffmpeg_scripts

Some basic scripts to automatize the tutorial creation workflow with ffmpeg. For all those who want to create tutorials with a free and powerful software through command line tool.

# History

In a previous version there was separate scripts for Linux and Mac OSX. In this new version, variables which contain input asked to users are able to adapt the ffmpeg commands according to user's operating system. To do this, these scripts will analyse your OS to determine if your are running Linux or OS X. Then they will ask you to enter your prefered path where to record and filenames you want for you project. They also will ask you some informations to enter about your audio and video devices accorded to the needs of ffmpeg commands. Read carefully what your shell is asking you. 

A dedicated folder should be created to avoid creating problems with other media files you could have on your computer.

## Scripts construction

Assuming the recording of your screen and audio at the same time could demand a lot of ressources to your CPU, this workflow integrates two main ways of recording a video. 

The folder "1" is built to record a video in one time (audio and video at the same time) and then cut the video at the time slots you need. Then the "cut.sh" script will also convert the original .mp4 file in two other formats (.webm and .mov) to assure you video is well played in every browser du to issues related to patents with some browsers.

The folder "2" is built to avoid demanding to much ressources to your CPU by splitting the process of recording audio and video. In brief :

1. Run the `video.sh` script and press `q` when you want to stop recording  
2. Run the `audio.sh` script while watching the video and press `q` when you want to stop recording.  
	2.1  It will record the audio then it will merge the audio and video files.
3. Adapt the time slots to your needs and run the `cut.sh` script  
	3.1. It will automatically cut your original .mp4 merged video file accorded to the time slots you need.  
	3.2. It will convert the file in both ".webm" and ".mov" to stream on the web. Due to issues between some browsers and some formats  
	3.3. Finally it will ask you to give a name to your final file  

Watch to have the audio and video files at the same duration to be well synchronized in the final file. Normally the final duration of the two files should be the same.

## Comments

The scripts are full of comments describing what they do and what you have to do. Please read them and ask me if it is not clear.
