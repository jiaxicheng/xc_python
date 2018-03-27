# Python3 Data Modules #
The target of this project is to set up a docker platform to run and test Python with several data modules:
* [x] ipython 
* [x] Python data modules: pandas + numpy
* [x] Python presentation module: matplotlib
* [x] MySQL database
* [x] Redis key-value caching store
* [x] Jupyter notebook
* [x] GlusterFS
* [x] multi-host and failover test

## Created the stack branch
On Mar 27, 2018
- Added [stack](https://github.com/jiaxicheng/xc_python/tree/stack) branch for the testing environments
  in a docker swarm and gluster cluster

## Split project into two branches ##
On Mar 17, 2018
- Added two branches to the current code:
  - [xauth](https://github.com/jiaxicheng/xc_python/tree/xauth): based on tkdev library and xauth, need X-support and DISPLAY
  - [jupyter](https://github.com/jiaxicheng/xc_python/tree/jupyter): based on Jupyter node and no tkdev library and xauth are required - Editing handled on web.
  - master branch is a mixed of two, since each has cons and pros.


**Note:** when using Jupiter notebook, there is no need to install tkdev and xauth which is only useful running ipython CLI.

## Added Jupiter Notebook ##
On Mar 16, 2018
- Added Jupitor notebook 5.4.0 with listening port: 9999 bind to the host@127.0.0.1
- Added docker-entrypoint.sh (Dockerfile) to start the Jupyter notebook server
- Added ENV (docker-compose.yml) to specify notebook-dir and logs folder at runtime

```
jupyter notebook --ip=0.0.0.0 --port=9999 --no-browser --notebook-dir="$shared" \
                 >>/home/$user/logs/jupyter-notebook.log 2>&1
```

## Added xauth for matplotlib ##
On Mar 9, 2016
- Added xauth to make matplotlib work properly through the container
- xauth can be run on command directive (docker-compose.yml) or in the server_xc_python.sh to add into .xauth.rc and invoke through .bash_aliases


## Minor adjustments ##
On Mar 8, 2016
- Moved all user configuration files to $PWD/home folder (Dockerfile)
- Moved apt-get package list to a file instead of listing all packages on the command line


## Added SQL script to init MySQL docker container ##
On Feb 28, 2018
- Added SQL script (docker-compose.yml) to create regular users databases and grant permissions at container start time
- Added myapp.conf (docker-compose.yml) to /etc/mysql/mysql.conf.d to set up MySQL server
- MySQL container is now xc_mysql:5.7 based on MySQL:5.7 and added a command line: `less` useful for SQL queries with multiple columes


## Added 3 docker containers for the testing suite ##
On Feb 26, 2018
- Created xc_python3.slim with Python3:slim + pandas + numpy + ipython
- Created mysql:latest for MySQL data store
- Added redis:latest for caching store 
- Added a bash script sever_xc_python.sh to retrieve the user uid and gid on the folder containing testing codes, the uid/gid will be used to create a user for the main container to avoid file-permission issues when editing the files on both container's end and host's end.

