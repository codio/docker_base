!!!! IMPORTANT do not build the images, update the latest cidui/base instead

# Docker containers image builders

Check the `Readme.md` in the individual folders for more details.


## Base

Base docker image creation for user backend.

## Home

Scripts to create base user home directory. Installs user software.

## rpc

Base image for executing rpc commands

# Image Build

## Codio

Codio folder contains main base images for codio.

### build docker rpc image
run
```
codio/build_rpc.sh
```

the image will be built and automatically uploaded to the docker repository as the latest

###  build base docker image

run:
```
codio/build_base.sh
```

the image will be built and automatically uploaded to the docker repository as the latest

### build home squash image
run:
```
codio/build_home <version>
```

* *version*  is a number increment from the latest built image

the image will be built and automatically uploaded to the s3 codio image repository

## Versal

### docker images

the build process same as for codio images

### home squash build

run
```
versal/build_home.sh <codio_image_version> <versal_image_version>
```

* *codio_image_version* is a number of squash image to build on top of.

* *versal_image_version* is a number of version to upload to s3 repo

the image will be built and automatically uploaded to the s3 codio image repository
