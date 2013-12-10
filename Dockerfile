# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# Workaround upstart
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN apt-get -y update
RUN apt-get -y install git curl wget man vim nano openssh-server
RUN adduser codio --disabled-password
#RUN su codio -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

# prepare ssh run directory
# RUN mkdir -p /var/run/sshd

CMD /sbin/init