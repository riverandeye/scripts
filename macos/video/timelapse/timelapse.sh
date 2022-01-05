function checkDevice(){
  ffmpeg -hide_banner -f avfoundation -list_devices true -i ""
}

function timelapse(){
  if [ $# -eq 0 ]
  then
    echo "Usage : $0 <output_destination>"
    return 1
  fi
  dest=$1

  now=$(date +%Y-%m-%d_%H-%M)
  ffmpeg -framerate 1 -f avfoundation -i 1 -r 30 -vf "settb=\(1/120\),setpts=N/TB/120" -vcodec libx264 -crf 0 -preset ultrafast -threads 0 $dest/$now.mp4
}

function runTimelapseInBackground(){
  touch /tmp/stop.timelapse
  </tmp/stop.timelapse timelapse ~/timelapse >/dev/null 2>>~/timelapse/Capture.log &!
}

function stopTimelapse(){
  echo 'q' > /tmp/stop.timelapse
  rm -rf /tmp/stop.timelapse
}