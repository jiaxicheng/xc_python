#!/usr/bin/env bash
: <<'DOC'
Xicheng Jia Spring 2018 @ Valley Stream

Ideally, this script should also be put in the ~/.bashrc file of the host server.
When accessing through `ssh -X host` or `ssh -Y host`, the DISPLAY and magic cookie
will vary on every ssh session. Saving this info at container's build time will have 
a problem. To solve this problem, the following 2 lines of bash code can be appended 
to your ~/.bashrc on the host server so that the new session info can be updated into 
the container's shell accordingly:

PROJECT_ROOT=~/my_projects/xc_python/master
[[ -f $PROJECT_ROOT/xauth.init.sh ]] && $PROJECT_ROOT/xauth.init.sh

DISPLAY is in the format:

     <host>:<display-number>

Prerequisites when using XSOCK:
(1) DISPLAY <host> should be EMPTY or the container-ip, since the
    container-ip is dynamic, use `:<display-number>` 
(2) /tmp/.X11-unix should be mounted to the container (writable)

Prerequisites when using X11Forwarding:
(1) DISPLAY <host> should be the docker0 bridge IP
(2) in the file '/etc/ssh/sshd_config', adjusted the following (default is 'yes'):
   X11UseLocalhost no
(3) firewalld, need to add the following rule:
<rule family="ipv4">
  <destination address="172.17.0.0/16"/>
  <port protocol="tcp" port="6010-6020" />
  <accept/>
</rule>

or run the following command (i.e. in Centos7)

sudo firewall-cmd --zone=public --add-rich-rule='
     rule family="ipv4" destination address="172.17.0.0/16" port protocol="tcp" port="6010-6020" accept'

Note: 
* this command assumed DefaultZone=public in the file '/etc/firewalld/firewalld.conf', please
  adjust 'public' to whatever returns from running 'firewall-cmd --get-default-zone'
* this firewall rule could cover at most 10 remote sessions (From Display:10.0 to 20.0) running on the 
  same docker host, adjust the range based on your own needs

Reference links: 
[1] https://stackoverflow.com/questions/48235040/run-x-application-in-a-docker-container-reliably-on-a-server-connected-via-ssh-w
[2] https://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container
[3] http://studioware.com/wikislax/index.php?title=X11_over_the_network

Notes:
* if you received the error "X Error of failed request: BadAccess (attempt to access private resource denied)"
  and you were using `ssh -X` to access the host, try switch to `ssh -Y`

DOC

## get and cd to the project root-folder
PROJECT_ROOT=$(cd ${0%/*}; pwd -P)
cd "$PROJECT_ROOT"

# If DISPLAY is empty, the xauth should be executed at each shell login.
# This happens when the service is started on a docker host w/o X-win
[[ -z $DISPLAY ]] && { echo "no X:display available"; exit; }

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
# the host name can be ignored, see Reference-[2] 
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH_FILE nmerge -

# this .xauthrc file will be source'd by the container shell
xauthrc_file=home/.xauthrc
echo "
export DISPLAY=$DISPLAY0
">$xauthrc_file
