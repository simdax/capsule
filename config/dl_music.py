# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#       hello les naz !                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#                                                   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#                                                      #+#    #+#              #
#                                                     ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/env python3

# Apparently it work's with python so maybe no need to install python3

import os
os.system('pip3 install --upgrade pip')
os.system('sudo -H pip3 install pyyaml')
import yaml

os.system('mkdir -p music')
from yaml import load, dump
with open("bd.yml", 'r') as stream:
    try:
        from yaml import CLoader as Loader, CDumper as Dumper
        data = load(stream, Loader=Loader)
    except ImportError:
        from yaml import Loader, Dumper

dict = {}
for dirname, dirnames, filenames in os.walk('./music'):
    for filename in filenames:
        dict[filename] = filename

if os.system("which ffmpeg"):
    print("installing ffmpeg")
    os.system("sudo apt-get install ffmpeg")
if os.system("which youtube-dl"):
    print("installing youtube-dl")
    os.system("sudo pip install --upgrade youtube_dl")
for key in data.keys():
    tmp = key + ".wav"
    print(key)
    if tmp in dict:
        print("allready in my jukebox baby !")
    else:
        print("add music")
        os.system("youtube-dl --quiet -x --audio-quality 0 --audio-format 'wav' \
        "+data[key]['url']+" -o music/"+key+".%\(ext\)s")
