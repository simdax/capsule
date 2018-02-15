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

#!/usr/bin/env python

import yaml
import os

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
        #print(filename)

for key in data.keys():
    tmp = key + ".wav"
    print(key)
    if tmp in dict:
        print("allready in my jukebox baby !")
    else:
        print("add music")
        if os.system("which ffmpeg"):
            print("installing ffmpeg")
            os.system("sudo apt-get install ffmpeg")
        if os.system("which youtube-dl"):
            print("installing youtube-dl")
            os.system("sudo pip install --upgrade youtube_dl")
        os.system("youtube-dl -x "+data[key]['url']+" -o music/"+key+".opus")
        os.system("ffmpeg -i music/"+key+".opus music/"+tmp+"")
        os.system("rm music/"+key+".opus")
