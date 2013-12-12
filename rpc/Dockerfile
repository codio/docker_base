# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps for node
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list

# Base softwre install
RUN apt-get -y update
RUN apt-get -y install dialog curl wget man vim nano python-software-properties build-essential rsync

# ppas
RUN apt-add-repository -y ppa:git-core/ppa
RUN apt-add-repository -y ppa:chris-lea/node.js
RUN apt-get -y update
RUN apt-get -y install git nodejs ruby2.0 ruby2.0-dev mercurial

# Create a user
RUN adduser codio --disabled-password

RUN npm install -g bower@1.2.7
RUN npm install -g jitsu@0.13.3
RUN npm install -g snr@0.2.2
RUN npm install -g less@1.4.0
RUN gem install --no-rdoc --no-ri sass

# Clean unwanted software
RUN apt-get -y purge python-software-properties
RUN apt-get -y autoremove
ENV HOME /home/codio