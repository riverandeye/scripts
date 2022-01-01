function m4a2mp3() {
  ffmpeg -i "$1" -codec:a libmp3lame -qscale:a 1 "$2"
}