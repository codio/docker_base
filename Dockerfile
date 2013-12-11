# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps for node
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list


# Base softwre install
RUN apt-get -y update
RUN apt-get -y install curl wget man vim nano openssh-server python-software-properties build-essential rsync

# ppas
RUN apt-add-repository -y ppa:git-core/ppa
RUN apt-get -y update
RUN apt-get -y install git

# extra packages
#RUN apt-get -y install emacs zsh

# Create a user
RUN adduser codio --disabled-password

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start

# Clean unwanted software
RUN apt-get -y purge python-software-properties

CMD ["/sbin/init"]