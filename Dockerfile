# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# Workaround upstart

RUN apt-get -y update
RUN apt-get -y install git curl wget man vim nano openssh-server
RUN adduser codio --disabled-password
#RUN su codio -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start

CMD ["/sbin/init"]