docker_base
===========

Base docker images for codio backend


Draft documentation:

## Build base Image
``` bash
sudo docker build -t base .
```

## Container create
2 folders for mount should be used

* project files folder - dir with project working copy
* project home folder - home folder for user data store

check "Disk quota" section to see action for set quota

## Docker start command example
``` bash
mkdir -p <project_home_dir>/workspace
sudo docker run -v <project_home_dir>:/home/codio:rw -v <project_files_dir>:/home/codio/workspace:rw -d base:latest /sbin/init
```
better create workspace folder in base image

## Startup services
By default only ssh will be started, to start other services file /usr/sbin/codio-start should be mounted to file system. file must have 700 rights and root as owner.


## SSH connection
listen on 22 port, map it to host machine to provide user access to ssh from outside

## CPU && memory quota
see docker desc

## Disk quota
``` bash
echo <id>:<project_path> >> /etc/projects
echo <project_uniq_name>:<id> >> /etc/projid
xfs_quota -x -c 'project -s <project_uniq_name>' <fs_root>
xfs_quota -x -c 'limit -p bhard=<limit_ex_5m> <project_uniq_name>' <fs_root>
```

## user home
use aufs
``` bash
sudo mount -t aufs -o dirs=<user_home_dir>:<base_home_dir> none <result_home_dir>
```

## docker startup script
sudo mount -t aufs -o dirs=<user_home_dir>:<base_home_dir> none <result_home_dir>
sudo docker run -v <project_home_dir>:/home/codio:rw -v <project_files_dir>:/home/codio/workspace:rw -d base:latest /sbin/init