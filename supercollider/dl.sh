#!/bin/sh

files=$(cat db.yaml | grep url | cut -c 8-1000)
names=$(cat db.yaml | grep -v '  ' | sed "s/:/ /g")

mkdir -p music
cat $names
# for i in ${!files[@]}; do
#     echo $i
#     youtube-dl -x --audio-format wav ${files[$i]} -o "music/${names[$i]}.%(ext)s"
# done
