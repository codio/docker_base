docker_rpc
==========

Docker container for run RPC commands

Don't have openssh in it, commands should be executes as they are with user directory mounts, check docker_base description


## Build
``` bash
docker build -t codio/base_rpc .
```

## Usage exmaple
``` bash
docker run -u codio -w="/home/codio" -i -t codio/base_rpc:latest bower install lodash
```

Home directory is pointed to /home/codio
