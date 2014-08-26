#!/bin/bash

set -e

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
IMAGE=codio/base

docker build -t ${IMAGE} $SCRIPTPATH/base
docker push ${IMAGE}