function checkDevice(){
  ffmpeg -hide_banner -f avfoundation -list_devices true -i ""
}

function timelapse(){
  if [ $# -eq 0 ]
  then
    echo "Usage : $0 <output_destination>"
    exit 1
  fi
  dest=$1

  now=$(date +%Y-%m-%d_%H-%M)
  ffmpeg -framerate 1 -f avfoundation -i 1 -r 30 -vf "settb=\(1/60\),setpts=N/TB/60" -vcodec libx264 -crf 0 -preset ultrafast -threads 0 $dest/$now.mp4
}

timelapse $1