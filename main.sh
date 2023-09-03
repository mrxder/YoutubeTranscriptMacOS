#!/bin/bash

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp is not installed. Please install it"
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is not installed. Please install it: https://ffmpeg.org/download.html"
    exit 1
fi

# Install whisper if it is not installed
./install_whisper.sh

if [ $# -ne 1 ]; then
    echo "Missing youtube link argument."
    exit 1
fi

video_url=$1

# Get the video title using yt-dlp
video_title=$(yt-dlp --get-title "$video_url")

# Replace spaces and special characters in the title with underscores
cleaned_title=$(echo "$video_title" | tr ' ' '_' | tr -d '[:punct:]')

# Download audio using yt-dlp and convert to WAV using ffmpeg
yt-dlp "$video_url" -f mp4 -o "temp_video.mp4"
ffmpeg -i "temp_video.mp4" -vn -acodec pcm_s16le -ar 16000 -ac 2 "temp_audio.wav"

# Clean up temporary files
mv "temp_video.mp4" "$cleaned_title.mp4"

callDir=$(pwd)

cd whisper.cpp
./main -m models/ggml-large.bin -l auto -t 10 -otxt -ovtt -olrc ../temp_audio.wav

cd $callDir

mv temp_audio.wav "$cleaned_title.wav"
mv temp_audio.wav.txt "$cleaned_title.txt"
mv temp_audio.wav.vtt "$cleaned_title.vtt"
mv temp_audio.wav.lrc "$cleaned_title.lrc"

mkdir -p "$cleaned_title"
mv "$cleaned_title.wav" "$cleaned_title"
mv "$cleaned_title.txt" "$cleaned_title"
mv "$cleaned_title.vtt" "$cleaned_title"
mv "$cleaned_title.lrc" "$cleaned_title"
mv "$cleaned_title.mp4" "$cleaned_title"