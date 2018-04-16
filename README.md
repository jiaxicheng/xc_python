# Python3 Data Modules #
The target of this project is to set up a docker platform to run and test Python3 with several data modules([Project logs](https://github.com/jiaxicheng/xc_python/blob/master/project_logs.md))
* [x] Python module Pandas (data exploration)
* [x] Python module Matplotlib (visualization)
* [x] ipython and Jupyter notebook
* [x] Redis key-value caching store
* [x] MySQL HA/failover with docker swarm

### Containers ###
1. python3: based on the official [python:slim](https://hub.docker.com/_/python/)
   + edit `modules.lst` to add/remove Python modules
   + edit `packages.lst` to add/remove Debian packages
2. mysql: based on the official [mysql:5.7](https://hub.docker.com/_/mysql/)
3. redis: based on the official [redis:4](https://hub.docker.com/_/redis/)

### Prerequisites: ###
1. Tested OS: Centos 7.4, Ubuntu 16.04, 7.10
2. Tested Docker version: 1.13.1 and 18.03
3. Install [docker-compose](https://docs.docker.com/compose/install/#install-compose) 
4. If running X graphics is required under ipython or command lines, then 
```
apt install xauth           # Ubuntu
yum install xauth           # Centos
```
5. Make sure the login *user* can run the docker command, i.e. check the group permission of the socket file and then add *user* into that group (docker, dockerroot)
```
ls -l /var/run/docker.sock
usermod -a -G <docker|dockerroot> <user>
```
6. Other softwares: firewalld, git, curl

### Installation: ###
1. download the package on `host_server` and run the docker services: 
```
git clone https://github.com/jiaxicheng/xc_python
mkdir -p ~/my_code
cd xc_python
./service_xc_python.sh  -d ~/my_code up
```
**Note:** in the python3 container, a user with the same username and uid as the owner of `/data/my_code` on the `host_server` are created, this is to guarantee that user can modify the files both in and out of the container.

---
#### Using Jupyter notebook for testing, do the following: ####
2. from the client-side, set up the ssh-tunnel: 
```
ssh -fNL9999:localhost:9999 <user>@<host_server>
```

3. on the `host_server`, run the following and retrieve the token needed for login
```
docker exec -it xc_python_python3_1 jupyter notebook list
```
4. on the client-side, open the browser with the link 'http://localhost:9999'
      login with the token shown above

---
#### Using xauth for testing (i.e. displaying plots directly with ipython) do the following: ####
2. set up the firewall between the `host_server` and the docker bridge0, essential for X11Forward to reach docker containers
```
sudo firewall-cmd  --zone=public --add-rich-rule=' rule family="ipv4" destination address="172.17.0.0/16" port protocol="tcp" port="6010-6020" accept'

# below make it persistent over reboot
sudo firewall-cmd  --zone=public --permanent --add-rich-rule=' rule family="ipv4" destination address="172.17.0.0/16" port protocol="tcp" port="6010-6020" accept'
```
**Note:**
+ Make sure the above rule is added to the **default zone**(`sudo firewall-cmd --get-default-zone`) even if no interface is attached to this zone.
+ For more details, please check the file [xauth.init.sh](https://github.com/jiaxicheng/xc_python/blob/master/xauth.init.sh).

3. set up `sshd` to allow non-localhost X11Forward: in /etc/ssh/sshd_config: `X11UseLocalhost no`:
```
sudo vi /etc/ssh/sshd_config     
sudo systemctl reload sshd
```

4. add the following lines into your ~/.bashrc, where PROJECT_ROOT is where the git have saved the project files.
```
echo '
# set up DISPLAY for container using xauth
PROJECT_ROOT=$HOME/xc_python
[[ -f $PROJECT_ROOT/xauth.init.sh ]] && $PROJECT_ROOT/xauth.init.sh
' >>~/.bashrc
```

5. logout and then login with the following command:
```
ssh -X <user>@<host_server>
docker exec -it xc_python_python3_1 bash
# under container, run the following test
shared> python ~/gui-test.py
shared> exit
``` 

Done and enjoy!
