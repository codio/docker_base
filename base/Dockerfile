# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps from universe
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list

# Base softwre install
RUN apt-get -y update
RUN apt-get -y install dialog curl wget man vim nano openssh-server python-software-properties build-essential rsync libssl1.0.0 libssl-dev libpcre3 libpcre3-dev libxml2 libxml2-dev openssl

# ppas
RUN apt-add-repository -y ppa:git-core/ppa


RUN apt-get -y update
RUN apt-get -y install git

# extra packages
RUN apt-get -y install emacs

# Create a user
RUN adduser codio --disabled-password --uid 1100

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
ADD ./etc/default/gitconfig /etc/gitconfig

RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start

# Clean unwanted software
RUN apt-get -y purge python-software-properties
RUN apt-get -y autoremove

# custom software
RUN apt-get -y install mercurial subversion

RUN echo "LC_ALL=C" >> /etc/environment

# environment variables
ENV HOME /home/codio

CMD ["/sbin/init"]