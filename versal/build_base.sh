#!/bin/bash

set -e

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
IMAGE=codio/versal

docker build ${IMAGE} $SCRIPTPATH/base
docker push ${IMAGE}