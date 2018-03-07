#!/bin/bash

files=$(cat db.yaml | grep url | cut -c 8-1000)
names=$(cat db.yaml | grep -v '  ' | sed "s/:/ /g")

mkdir -p music
i=1
for file in $files; do
   youtube-dl -x --audio-format wav $file
   name=$(echo $names | cut -d " " -f $i).wav
   mv *.wav music/$name
   ((i++))
done
