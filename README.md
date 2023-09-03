
# Youtube Transcript for macOS

This script generates a transcript of a YouTube video using the whisper model. The transcript is outputted in various formats, along with the original video and audio files, in a folder named after the video.

## Dependencies

To use this script, you need to install the following dependencies:

- `yt-dlp`
- `ffmpeg`
- `Xcode`
- `xcode-select`

## First Run

On the first run, the script clones `whisper.cpp`, downloads the large model, and compiles `whisper`. Once the model is compiled, the script will use it to transcribe the video.

## Testing

To test the script, simply run `./test.sh`. This will run the script on a sample YouTube video and output the transcript in various formats.

## Usage

To transcribe any YouTube video, run `./main.sh <url-to-youtube-video>`. Replace `<url-to-youtube-video>` with the URL of the YouTube video you want to transcribe. The script will download the video, extract the audio, and use the `whisper` model to transcribe the audio. The transcript will be outputted in various formats, along with the original video and audio files, in a folder named after the video.