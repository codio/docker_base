#!/bin/bash

sudo docker build -t -rm=true base base/
sudo docker build -t -rm=true base_rpc rpc/
cd home && sudo ./build.sh
