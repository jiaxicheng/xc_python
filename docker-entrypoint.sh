#!/usr/bin/env sh

user=${1:-xicheng}
shared=${2:-/shared}

jupyter notebook --ip=0.0.0.0 --port=9999 --no-browser --notebook-dir="$shared" >>/home/$user/logs/jupyter-notebook.log 2>&1
