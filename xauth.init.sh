##!/usr/bin/bash
: <<'DOC'
Xicheng Jia Spring 2018 @ Valley Stream

Ideally, this script should be put in the ~/.bashrc file of the host server.
this is important when accessing through `ssh -X host` or `ssh -Y host`, since 
every ssh session opens a new DISPLAY and thus different cookie. Saving this info
in container's ~/.bashrc file at build time does not solve this issue.
To move this to your host's ~/.bashrc file, make sure to change the $BASE_DIR 
to your project folder containing this `xauth.init.sh` file 

Prerequisites:
(1) /etc/ssh/sshd_config    adjusted the following:
 X11UseLocalhost no
(2) firewalld, need to add the following rule:
<rule family="ipv4">
  <destination address="172.17.0.0/16"/>
  <port protocol="tcp" port="6010-6020" />
  <accept/>
</rule>

Reference links: 
[1] https://stackoverflow.com/questions/48235040/run-x-application-in-a-docker-container-reliably-on-a-server-connected-via-ssh-w
[2] https://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container
[3] http://studioware.com/wikislax/index.php?title=X11_over_the_network

DOC

# if DISPLAY is using XSOCK, then use XSOCK
# else container :display based on the docker0 IP
if [[ $DISPLAY =~ ^: ]]; then
  DISPLAY0=$DISPLAY
else
  docker0_ip=172.17.0.1
  DISPLAY0=$docker0_ip:${DISPLAY#*:}
fi

# set up the .Xauthority file
XAUTH_FILE=home/.Xauthority 
touch $XAUTH_FILE && chmod 700 $XAUTH_FILE

# Add the DISPLAY cookie into the XAUTHORITY file
# the sed 's/^..../ffff/' is to set the authentication family to 'FamilyWild' so that
# the host name can be ignored. 
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH_FILE nmerge -

# this .xauthrc file will be source'd by the container shell
BASE_DIR=.
xauthrc_file=$BASE_DIR/home/.xauthrc
echo "
export DISPLAY=$DISPLAY0
">$xauthrc_file
