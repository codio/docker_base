set -e
VERSION=$2
BASE_HOME=$1

VERSAL_BASE_HOME="/tmp/base-home-tmp-versal"
VERSAL_BASE_HOME_DIFF=${VERSAL_BASE_HOME}-diff
RUN="docker run --rm -w /home/codio -v ${VERSAL_BASE_HOME}:/home/codio:rw codio/base "

if [ -d "${VERSAL_BASE_HOME}" ]; then
    rm -rf ${VERSAL_BASE_HOME}
fi

if [ -d "${VERSAL_BASE_HOME_DIFF}" ]; then
    rm -rf ${VERSAL_BASE_HOME_DIFF}
fi

mkdir -p ${VERSAL_BASE_HOME}
mkdir -p ${VERSAL_BASE_HOME_DIFF}
chown 1100 ${VERSAL_BASE_HOME}
chown 1100 ${VERSAL_BASE_HOME_DIFF}

unionfs -o cow -o allow_other ${VERSAL_BASE_HOME_DIFF}=RW:${BASE_HOME}=RO ${VERSAL_BASE_HOME}

cp install.sh ${VERSAL_BASE_HOME}/

$RUN su.codio -l codio -c "/bin/bash /home/codio/install.sh"

echo 'Start install.sh'
rm ${VERSAL_BASE_HOME}/install.sh
echo 'making image'

mksquashfs ${VERSAL_BASE_HOME} base-home-versal-sdk-v${VERSION}.sqsh -e .unionfs

umount ${VERSAL_BASE_HOME}
rm -rf ${VERSAL_BASE_HOME_DIFF}
rm -rf ${VERSAL_BASE_HOME}