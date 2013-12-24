# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps from universe
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list

# Base softwre install
RUN apt-get -y update
RUN apt-get -y install dialog curl wget man vim nano openssh-server python-software-properties build-essential rsync libssl-dev

# ppas
RUN apt-add-repository -y ppa:git-core/ppa
RUN apt-add-repository -y ppa:nginx/stable
#mongo ppa
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' >  /etc/apt/sources.list.d/mongodb.list

RUN apt-get -y update
RUN apt-get -y install git nginx mongodb-10gen

# extra packages
RUN apt-get -y install emacs

#
# Install parse CLI
#
RUN curl -s https://www.parse.com/downloads/cloud_code/installer.sh | /bin/bash

# Create a user
RUN adduser codio --disabled-password

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
ADD ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./etc/mongodb.conf /etc/mongodb.conf
ADD ./etc/default/mongodb /etc/default/mongodb
ADD ./etc/default/gitconfig /etc/gitconfig

RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start

# Clean unwanted software
RUN apt-get -y purge python-software-properties
RUN apt-get -y autoremove

# environment variables
ENV HOME /home/codio

CMD ["/sbin/init"]