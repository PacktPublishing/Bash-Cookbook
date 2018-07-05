#! /bin/bash
folder=~/Desktop/abc
cdate=$(date +"%Y-%m-%d-%H:%M")
inotifywait -m -q -e create -r --format '%:e %w%f' $folder | while read file
do
	mv ~/Desktop/abc/output.txt ~/Desktop/Old_abc/${cdate}-output.txt
done
