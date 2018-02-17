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
import yaml

from yaml import load, dump
from termcolor import colored
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

for key in data.keys():
    tmp = key + ".wav"
    print colored(key, 'yellow')
    if tmp in dict:
        print colored("allready in my jukebox baby !", 'green')
    else:
        print colored("add music", 'blue')
        os.system("youtube-dl --quiet -x --audio-quality 0 --audio-format 'wav' \
        "+data[key]['url']+" -o music/"+key+".%\(ext\)s")
