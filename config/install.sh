#!/bin/sh

# This is still a test, I didn't remove install's in dl_music.py

if [ $(uname -s) = "Linux" ]
then
	sudo apt-get -y install python3 python3-yaml python3-pip ffmpeg
else
	brew install python3
	pip3 install --upgrade pip3
	sudo -H pip3 install pyyaml
	brew install ffmpeg
fi
sudo -H pip3 install --upgrade youtube-dl
