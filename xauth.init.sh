##!/usr/bin/bash

# ideally, this script should be put on the .bashrc file of the host server
# this is important when accessing through ssh -X or ssh -Y, since every ssh
# session will open a new DISPLAY and this different cookies.
# saving this in contain .bashrc file ony at build time does not solve this issue.
# To move this to your host's ,bashrc file, make sure to change the $BASE_DIR 
# to reflect the folder of your project.
# REF: https://stackoverflow.com/questions/48235040/run-x-application-in-a-docker-container-reliably-on-a-server-connected-via-ssh-w

BASE_DIR=./
xauthrc_file=$BASE_DIR/home/.xauthrc

XAUTH_FILE=/tmp/.X11-unix/.docker.xauth.$(id -u) 
docker0_ip=172.17.0.1
touch $XAUTH_FILE
#xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH_FILE nmerge -
xauth -f $XAUTH_FILE add $docker0_ip:${DISPLAY#*:} . $(xauth list $DISPLAY | awk '{print $NF}')
chmod 700 $XAUTH_FILE

# this .xauthrc file will be source'd by the container shell
echo "
export DISPLAY=$docker0_ip:${DISPLAY#*:}
export XAUTHORITY=$XAUTH_FILE
">$xauthrc_file

