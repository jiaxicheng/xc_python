#!/usr/bin/env bash

USAGE="Usage:

    $0 [-h|-d folder] <build|start|build-run|stop> [SERVICE..]
"

SHARED=/home/xicheng/my_code/python
while getopts "hd" opt; do
  case $opt in
    h)
      echo "$USAGE"; exit 0
      ;;
    d)
      SHARED=$2
      [[ -d "$SHARED" ]] || { echo "the folder $SHARED does not exist"; exit 1; }
      ;;
  esac
done
shift $((OPTIND-1))

export SHARED
export USER=$(stat -c "%U" "$SHARED")
export USER_UID=$(stat -c "%u" "$SHARED")
export USER_GID=$(stat -c "%g" "$SHARED")

case $1 in
  start)
    docker-compose up -d "${@:2}"
    ;;
  build-run)
    docker-compose up -d --build "${@:2}"
    ;;
  build)
    docker-compose build --force-rm "${@:2}"
    ;;
  stop)
    docker-compose down --remove-orphans
    ;;
  *)
    echo "$USAGE"
    exit 1
    ;;
esac

