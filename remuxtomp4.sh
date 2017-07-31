#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: remuxtomp4.sh [filename]"
    exit 1
fi

input="$1"
output="${input%.*}.mp4"

ffmpeg -i "$input" -acodec copy -vcodec copy "$output"

echo "Wrote $output"