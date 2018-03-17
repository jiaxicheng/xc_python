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

## Split project into two branches ##
On Mar 17, 2018
- Added two branches to the current code:
  - xauth: based on tkdev library and xauth, need X-support and DISPLAY
  - jupyter: based on Jupyter node and no tkdev library and xauth are required - Editing handled on web.
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
- Created the jupyter branch which removed the tkdev and xauth and make the Jupyter notebook
  as the main GUI debugging tools for Python, ipython as the interactive CLI tool for non-graphic 
  codes.

