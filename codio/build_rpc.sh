#!/bin/bash

set -e

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
IMAGE=codio/base_rpc

docker build -t ${IMAGE} $SCRIPTPATH/rpc
docker push ${IMAGE}