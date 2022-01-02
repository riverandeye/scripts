function doRecursiveSource(){
  # if the first argument is empty, return usage
  if [ -z "$1" ]; then
    echo "Usage: recursive_source.sh <pattern>"
    return 1
  fi

  pattern=$1

  for f in $pattern; do source $f; done
}