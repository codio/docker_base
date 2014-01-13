#!/bin/bash

sudo docker build -t base base/
sudo docker build -t base_rpc rpc/
cd home && sudo ./build.sh
