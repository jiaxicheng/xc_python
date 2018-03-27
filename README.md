## Multi-host Storages and failover test ##
On March 27, 2018

* Setup docker swarm cluster with 3 servers and mounted the GFS cluster volume mysqldata 
  to each nodes with systemd.mount service: [gfs-mysql.mount](https://github.com/jiaxicheng/system/blob/master/systemd.mount/gfs-mysql.mount)
  - freeport: 192.168.10.57 (Leader)
  - bellmore: 192.168.10.55 (Worker)
  - rockville: 192.168.10.53 (Worker)
* GlusterFS cluster: 
  - cedarhurst: 192.168.20.36
  - hewlett: 192.168.20.37
  - gibson: 192.168.20.38
* Applied docker configs on the server config files for redis and mysql
* Applied the internal registry at lexington:5000 to host the customized images
* Set constraint so that the python container run only on the local server @freeport

