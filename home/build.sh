#!/bin/bash
set -e
BASE_HOME="/tmp/base-home-tmp"
RUN="docker run -rm=true -w /home/codio -v ${BASE_HOME}:/home/codio:rw codio/base "

if [ -d "${BASE_HOME}" ]; then
    rm -rf ${BASE_HOME}
fi
mkdir -p ${BASE_HOME}
chown 1100 ${BASE_HOME}

touch ${BASE_HOME}/.profile && chown 1100 ${BASE_HOME}/.profile
sudo cp .bash_profile ${BASE_HOME}
sudo chown 1100 ${BASE_HOME}/.bash_profile

chmod +x install.sh
cp install.sh ${BASE_HOME}/

$RUN su -l codio -c "/bin/bash ./install.sh"

rm ${BASE_HOME}/install.sh

mkdir ${BASE_HOME}/workspace && chown 1100 ${BASE_HOME}/workspace
mksquashfs ${BASE_HOME} base-home.sqsh

