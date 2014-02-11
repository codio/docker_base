#!/bin/bash

sudo docker build -t -rm=true codio/base base/
sudo docker build -t -rm=true codio/base_rpc rpc/
cd home && sudo ./build.sh
