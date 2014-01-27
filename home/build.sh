#!/bin/bash
set -e
BASE_HOME="/mnt/data/base-home"
RUN="docker run -rm=true -u codio -w /home/codio -v ${BASE_HOME}:/home/codio:rw -i -t base"

mkdir -p ${BASE_HOME}
find ${BASE_HOME} -mindepth 1 -delete
chown 1100 ${BASE_HOME}

#docker build -t base ../base/
$RUN touch /home/codio/.profile
cp .bash_profile ${BASE_HOME}
chown 1100 ${BASE_HOME}/.bash_profile

chmod +x install.sh
cp install.sh ${BASE_HOME}/

$RUN ./install.sh

rm ${BASE_HOME}/install.sh

$RUN mkdir /home/codio/workspace

#docker rmi base_tmp