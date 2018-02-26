Create an application including a set of docker containers to test out several Python modules.
- Python:slim on top of the Debian jessie
- Python modules: pandas, scipy
- Redis server
- MySQL server
- On xc_python container, login as the user_id owning the specific hosting folder
  which will be mounted in container. Container must be run under non-root and 
  files can be editted both in and out the container.
