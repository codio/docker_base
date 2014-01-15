#!/bin/bash
set -e
BASE_HOME="/mnt/data/base-home"
RUN="docker run -rm -u codio -w /home/codio -v ${BASE_HOME}:/home/codio:rw -i -t base"

find ${BASE_HOME}/* -delete
mkdir -p ${BASE_HOME}
chown 1100 ${BASE_HOME}

docker build -t base ../base/
$RUN touch /home/codio/.profile
cp .bash_profile ${BASE_HOME}
chown 1100 ${BASE_HOME}/.bash_profile

chmod +x install.sh
cp install.sh ${BASE_HOME}/

$RUN ./install.sh
$RUN mkdir -p /home/codio/var/log/nginx /home/codio/var/lib/mongodb /home/codio/var/log/mongodb /home/codio/etc/nginx/sites-enabled
cp -r etc ${BASE_HOME}/

rm ${BASE_HOME}/install.sh

$RUN mkdir /home/codio/workspace

#docker rmi base_tmp