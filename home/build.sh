#!/bin/bash

RUN="sudo docker run -u codio -w /home/codio -v `pwd`/image:/home/codio:rw -i -t base"

rm -rf ./image
mkdir -p ./image

sudo docker build -t base ../base/
$RUN touch /home/codio/.profile
cp install.sh ./image/
$RUN ./install.sh
$RUN mkdir -p /home/codio/var/log/nginx /home/codio/var/lib/mongodb /home/codio/var/log/mongodb /home/codio/etc/nginx/sites-enabled
cp -r etc ./image

rm ./image/install.sh

mkdir ./image/workspace

#docker rmi base_tmp