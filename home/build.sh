#!/bin/bash
set -e

RUN="docker run -rm -u codio -w /home/codio -v `pwd`/image:/home/codio:rw -i -t base"

rm -rf ./image
mkdir -p ./image
chown 1000 ./image

docker build -t base ../base/
$RUN touch /home/codio/.profile
chmod +x install.sh
cp install.sh ./image/
$RUN ./install.sh
$RUN mkdir -p /home/codio/var/log/nginx /home/codio/var/lib/mongodb /home/codio/var/log/mongodb /home/codio/etc/nginx/sites-enabled
cp -r etc ./image

rm ./image/install.sh

$RUN mkdir /home/codio/image/workspace

#docker rmi base_tmp