# Python3 Data Modules #
Branch to use `xauth` and its related tools to show Python plots

## xauth with XSOCK and X11Forwarding
On Mar 18, 2018
- Added a file [xautn.init.sh](./xauth.init.sh) to handle two different situations
  - using XSOCK: when the docker host on a systen with X-Win and you want your graphs rendered
    to that DISPLAY. In this case, you will find a socket file under the folder /tmp/.X11-unix/X<number>
    where <number> is your current display_number
  - using X11Forwarding and the docker host is on a remote server. This is often when you run
    `ssh -Y host` to access host and the terminal has DISPLAY like '<host_ip>:11', (`11` is just 
    an example display number) you want the graphs to be rendered in the local desktop/server

## Created a 'xauth' branch
On Mar 16, 2018
- Added two branches to the current code:
  - xauth: based on tkdev library and xauth, need X-support and DISPLAY
  - jupyter: based on Jupyter node and no tkdev library and xauth are required - Editing handled on web.
  - master branch is a mixed of two, since each has cons and pros.
- xauth branch:
  - need package: tkdev + xauth
  - `xauth add` insert into the ~/.xauthrc file to retrieve X credential info on each login
  - image xc_python3.slim is about 545 MB

## Added xauth for matplotlib ##
On Mar 9, 2016
- Added xauth to make matplotlib work properly through the container
- xauth can be run on command directive (docker-compose.yml) or in the server_xc_python.sh to add into .xauth.rc and invoke through .bash_aliases


