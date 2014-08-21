#!/bin/bash
set -e

if [[ $# -ne 1 ]]; then
    echo "illegal number of parameters, please pass version for build image to upload. Ex ./build.sh 8"
    exit 1
fi

VERSION=$1
BASE_HOME="/tmp/base-home-tmp"
RUN="docker run --rm -w /home/codio -v ${BASE_HOME}:/home/codio:rw codio/base "

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

$RUN su.codio -l codio -c "/bin/bash ./install.sh"

rm ${BASE_HOME}/install.sh

mkdir ${BASE_HOME}/workspace && chown 1100 ${BASE_HOME}/workspace
mksquashfs ${BASE_HOME} /tmp/base-home.sqsh
VERSAL_HOME_FILE=base-home-v${VERSION}.sqsh
s3cmd put --acl-public --guess-mime-type /tmp/base-home.sqsh s3://codio-base-home-images/${VERSAL_HOME_FILE}


