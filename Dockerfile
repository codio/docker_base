# DOCKER-VERSION 0.5.3
FROM ubuntu
MAINTAINER Codio "info@codio.com"

# Workaround upstart
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" > /etc/apt/sources.list.d/universe.list

RUN apt-get -y update
RUN apt-get -y install git curl wget man vim nano openssh-server
RUN adduser codio --disabled-password
#RUN su codio -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

