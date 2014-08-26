#!/bin/bash

set -e

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
IMAGE="codio/versal_rpc"

echo building ${IMAGE} from ${SCRIPTPATH}/rpc
docker build -t ${IMAGE} ${SCRIPTPATH}/rpc
docker push ${IMAGE}