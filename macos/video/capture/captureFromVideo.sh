function captureInterval(){
  # $1: video file
  # $2: screenshot count
  # $3: output directory

  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <video file> <screenshot count> <output directory>"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    return 1
  fi

  # check screenshot count is an integer
  if ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "Screenshot count must be an integer"
    return 1
  fi

  takenTime=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $1)
  interval=$(echo "$takenTime / $2" | bc)

  # If there is no output directory, create one
  if [ ! -d "$3" ]; then
    mkdir -p $3
  fi

  for ((i=0; i<$2; i++)); do
    frameTime=$(echo "$interval * $i" | bc)
    second=$(echo "$frameTime % 60" | bc)
    minute=$(echo "$frameTime / 60 % 60" | bc)
    hour=$(echo "$frameTime / 3600 % 24" | bc)
    fileName="$3/$hour:$minute:$second.jpg"

    ffmpeg -hide_banner -loglevel error -ss $frameTime -i $1 -qscale:v 2 -pix_fmt yuvj422p -vframes 1 $fileName
  done
}