#!/usr/bin/env bash

# pre-defined Action OPTS and regex to match one of the OPTS
OPTS=(status up down ps)
regex=$(IFS=\|;echo "${OPTS[*]}")
STACK_NAME=db-cluster

# usage
USAGE="Usage:

    $0 [-h|-d folder] <$regex> [SERVICE..]
"

# shared folder to save working codes
SHARED=/home/xicheng/my_code/python

# process the command options
while getopts "hd:" opt; do
  case $opt in
    h)
      echo "$USAGE"; exit 0
      ;;
    d)
      SHARED=$2
      ;;
  esac
done
shift $((OPTIND-1))

[[ -d "$SHARED" ]] || { echo "the folder '$SHARED' does not exist"; exit 1; }

# action must be one of the pre-defined OPTS
# export environments when build and run the applications
[[ $1 =~ ^$regex$ ]] || { echo "$USAGE"; exit; }

if [[ $1 =~ ^(up) ]]; then
    # SHARED folder supplied by -d argument or default to '/home/xicheng/my_code/python'
    export SHARED

    # mount point for mysql datadir on top of GlusterFS
    export GFSROOT=/gfs/mysql

    # set username, user_uid and user_gid the same as the owner of the SHARED folder
    export USER=$(stat -c "%U" "$SHARED")
    export USER_UID=$(stat -c "%u" "$SHARED")
    export USER_GID=$(stat -c "%g" "$SHARED")

    # setup container xauth cookie and DISPLAY based on login
    ./xauth.init.sh

    echo "ROOT: $GFSROOT"
fi

# wrapper for docker-compose command with required environments for the services
case $1 in
  up)
    docker stack up -c docker-stack.yml --with-registry-auth "$STACK_NAME"
    ;;
  status)
    if [[ $2 = $"$STACK_NAME" ]]; then
      docker stack ls "${@:3}"
    else
      docker service ls "${@:3}"
    fi
    ;;
  ps)
    if [[ $2 = $"$STACK_NAME" ]]; then
      docker stack ps "${@:2}"
    else
      docker service ps "${@:2}"
    fi
    ;;
  down)
    docker stack rm "$STACK_NAME"
    ;;
  *)
    echo "$USAGE"
    exit 1
    ;;
esac

