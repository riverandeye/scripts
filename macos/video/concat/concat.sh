function createConcatFileList() {
  absolute_path=$(cd "$(dirname "$1")"; pwd)
  
  if [[ ! -d $absolute_path ]]; then
    echo "ERROR: $absolute_path does not exist"
    return 1
  fi
  
  for file in $absolute_path/*.$2; do
    echo "file '$file'"
  done
}

function concatVideoFromFileList() {
  # if first argument and second argument is empty, return usage
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: concatVideoFromFileList <file_list> <output_file>"
    return 1
  fi

  file_list=$1
  output_file=$2

  ffmpeg -f concat -safe 0 -i $file_list -c copy $output_file.mp4
}