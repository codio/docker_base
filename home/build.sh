#!/bin/bash
set -e
BASE_HOME="/mnt/data/base-home"
RUN="docker run -rm=true -u codio -w /home/codio -v ${BASE_HOME}:/home/codio:rw codio/base"

mkdir -p ${BASE_HOME}
find ${BASE_HOME} -mindepth 1 -delete
chown 1100 ${BASE_HOME}

$RUN touch /home/codio/.profile
sudo cp .bash_profile ${BASE_HOME}
sudo chown 1100 ${BASE_HOME}/.bash_profile

chmod +x install.sh
cp install.sh ${BASE_HOME}/

$RUN ./install.sh

rm ${BASE_HOME}/install.sh

$RUN mkdir /home/codio/workspace
