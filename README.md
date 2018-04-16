# Python3 Data Modules #
The target of this project is to set up a docker platform to run and test Python3 with several data modules([Project logs](https://github.com/jiaxicheng/xc_python/blob/master/project_logs.md))
* [x] Python data exploration: Pandas
* [x] Python visualization: Matplotlib
* [x] Jupyter notebook
* [x] ipython 
* [x] Redis key-value caching store
* [x] MySQL HA/failover with docker swarm

### Prerequisites: ###
1. Tested OS: Centos 7.4
2. Tested Docker version: 1.13.1 and 18.03
3. [docker-compose](https://docs.docker.com/compose/install/#install-compose) 
4. If running X-graphic is required under ipython or command lines, then 
```
yum install xauth
```

### Installation: ###
1. download the package on `host_server` and run the docker services: ```
git clone https://github.com/jiaxicheng/xc_python
mkdir -p /data/my_code
cd xc_python
./service_xc_python.sh  -d /data/my_code up
```
*Note:* in the python3 container, a user with the same username and uid as the owner of `/data/my_code` on the `host_server` are created, this is to guarantee that user can modify the files both in and out of the container.

#### Using `Jupyter notebook` for testing, do the following: ####
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

#### Using `xauth` for testing, you can run GUI program on the command lines, i.e. ipython. do the following: ####
2. set up the firewall between the `host_server` and the docker bridge0, essential for X-forward to reach docker containers
```
firewall-cmd  --zone=public --add-rich-rule=' rule family="ipv4" destination address="172.17.0.0/16" port protocol="tcp" port="6010-6020" accept
firewall-cmd --reload

# below make it persistent over reboot
firewall-cmd  --zone=public --permanent --add-rich-rule=' rule family="ipv4" destination address="172.17.0.0/16" port protocol="tcp" port="6010-6020" accept

```
   check the file [xauth.init.sh](https://github.com/jiaxicheng/xc_python/blob/master/xauth.init.sh) for more details.

3. set up `sshd` to allow non-localhost X11Forward: vi /etc/ssh/sshd_conf and adjust `X11UseLocalhost` from `yes` to `no` and then run:
```
systemctl reload sshd
```

4. add the following lines into your ~/.bashrc, where PROJECT_ROOT is where the git have saved the project files.
```
PROJECT_ROOT=$HOME/xc_python
[[ -f $PROJECT_ROOT/xauth.init.sh ]] && $PROJECT_ROOT/xauth.init.sh
```

5. logout and then login with the following command:
```
ssh -X <user>@<host_server>
docker exec -it xc_python_python3_1 bash
# under container, run the following test
shared> python ~/gui-test.py
shared> exit
``` 
*Note*: make sure your login user can run the docker, for example, in the group names 'dockerroot' or 'docker'. check the permission of the file `/run/docker.socket`


