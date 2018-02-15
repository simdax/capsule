#! /bin/sh

mkdir -p sounds
for sound in $(cat sounds.db)
	do youtube-dl -x --audio-format wav $sound -o "sounds/%(title)s.%(ext)s"
done
