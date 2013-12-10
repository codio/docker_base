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

## Docker start command exmpale
``` bash
mkdir -p <project_home_dir>/workspace
sudo docker run -v <project_home_dir>:/home/codio:rw -v <project_files_dir>:/home/codio/workspace:rw -d base:latest /sbin/init
```

## Startup services
By default only ssh will be started, to start other services file /usr/sbin/codio-start should be mounted to file system. file must have 700 rights and root as owner.


## SSH connection
listen on 22 port, map it to host machine to provide user access to ssh from outside