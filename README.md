docker_base
===========

Base docker images for codio backend


Draft documentation:

## Container create
2 folders for mount should be used

* project files folder - dir with project working copy
* project home folder - home folder for user data store

## Docker start command exmpale
``` bash
mkdir -p <project_home_dir>/workspace
sudo docker run -v <project_home_dir>:/home/codio:rw -v <project_files_dir>:/home/codio/workspace:rw -d base:latest /sbin/init
```

## SSH connection
хз пока как сделать