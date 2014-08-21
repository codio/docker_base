set -e

if [[ $# -ne 2 ]]; then
    echo "illegal number of parameters, please pass base image version and version of versal image to upload. Ex ./build.sh 3 9"
    exit 1
fi

VERSION=$2
BASE_HOME_VERSION=$1
TMP=/tmp/versal-build

#create tmp build dir
echo Creating tmp directory
if [ -d "${TMP}" ]; then
    sudo rm -rf ${TMP}
fi

mkdir -p ${TMP}

echo Downloading base image
BASE_FILE_NAME=base-home-v${BASE_HOME_VERSION}.sqsh
# get image
s3cmd get s3://codio-base-home-images/${BASE_FILE_NAME}  ${TMP}/${BASE_FILE_NAME}

echo Mount base image
BASE_HOME=${TMP}/base-home-build
sudo mkdir -p ${BASE_HOME}
sudo mount ${TMP}/${BASE_FILE_NAME} ${BASE_HOME} -t squashfs -o loop

VERSAL_BASE_HOME="${TMP}/base-home-tmp-versal"
VERSAL_BASE_HOME_DIFF=${VERSAL_BASE_HOME}-diff
RUN="docker run --rm -w /home/codio -v ${VERSAL_BASE_HOME}:/home/codio:rw codio/base "

echo create versal base home folders
mkdir -p ${VERSAL_BASE_HOME}
mkdir -p ${VERSAL_BASE_HOME_DIFF}
sudo chown 1100 ${VERSAL_BASE_HOME}
sudo chown 1100 ${VERSAL_BASE_HOME_DIFF}
sudo unionfs -o cow -o allow_other ${VERSAL_BASE_HOME_DIFF}=RW:${BASE_HOME}=RO ${VERSAL_BASE_HOME}

sudo cp install.sh ${VERSAL_BASE_HOME}/

echo Run install
$RUN su.codio -l codio -c "/bin/bash /home/codio/install.sh"

sudo rm ${VERSAL_BASE_HOME}/install.sh
echo 'making image'
#
VERSAL_HOME_FILE=base-home-versal-sdk-v${VERSION}.sqsh
VERSAL_HOME_IMAGE=$TMP/${VERSAL_HOME_FILE}
mksquashfs ${VERSAL_BASE_HOME} ${VERSAL_HOME_IMAGE} -e .unionfs

sudo umount ${VERSAL_BASE_HOME}
sudo umount ${TMP}/base-home-build

echo uploading
s3cmd put --acl-public --guess-mime-type ${VERSAL_HOME_IMAGE} s3://codio-base-home-images/${VERSAL_HOME_FILE}

echo Cleaning up
sudo rm -rf ${TMP}