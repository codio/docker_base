## build base image for user folder


run
``` bash
./build.sh
````
after build base-home.sqsh file will be available.

to deploy it use:
s3cmd put --acl-public --guess-mime-type base-home.sqsh s3://codio-base-home-images/base-home-v{version_num}.sqsh


mount command
make sure you have squashfs-tools installed (sudo apt-get install squashfs-tools)

sudo mount base-home-v1.sqsh /mnt/data/base-home -t squashfs -o loop

