# Python3 Data Modules #
The target of this project is to set up a docker platform to run and test Python with several data modules:
* [x] ipython 
* [x] Python data modules: pandas + numpy
* [x] Python presentation module: matplotlib
* [x] MySQL database
* [x] Redis key-value caching store
* [x] Jupyter notebook
* [X] GlusterFS
* [ ] multi-host and failover test


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


