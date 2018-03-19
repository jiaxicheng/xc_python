# Python3 Data Modules #
Branch based on Jupyter notebook for Python GUI displays.

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

