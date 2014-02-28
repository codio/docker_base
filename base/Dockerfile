# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps from universe
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list

# Base softwre install
RUN apt-get -y update
RUN apt-get -y install dialog curl wget man vim nano openssh-server python-software-properties build-essential rsync libssl1.0.0 libssl-dev libpcre3 libpcre3-dev libxml2 libxml2-dev openssl libcurl4-openssl-dev postgresql-server-dev-9.1 libreadline-dev s3cmd libevent1-dev libevent-1.4-2 libncurses5-dev autotools-dev automake pkg-config zlib1g-dev liblzma-dev libxslt-dev libgmp3c2 libgmp3-dev libgl1-mesa-dev libglc-dev freeglut3-dev libedit-dev libglw1-mesa libglw1-mesa-dev


# ppas
RUN apt-add-repository -y ppa:git-core/ppa
RUN apt-add-repository -y ppa:webupd8team/java


RUN apt-get -y update
#accept oracle license
RUN  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

RUN apt-get -y install oracle-java7-installer git mercurial subversion

# extra packages
RUN apt-get -y install emacs

# Clean unwanted software
RUN apt-get -y purge python-software-properties
RUN apt-get -y autoremove

# Create a user
RUN adduser codio --disabled-password --uid 1100

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
ADD ./etc/default/gitconfig /etc/gitconfig
ADD ./etc/box /etc/box

RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start

#RUN echo "LC_ALL=C" >> /etc/environment
#work with locales

RUN cp /usr/share/i18n/SUPPORTED  /var/lib/locales/supported.d/local
RUN dpkg-reconfigure locales
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN rm /etc/motd
RUN rm /etc/legal

RUN dpkg-divert --remove /sbin/initctl && rm /sbin/initctl && mv /sbin/initctl.distrib /sbin/initctl

# environment variables
ENV HOME /home/codio
RUN apt-get -y install unzip zsh zsh-lovers bzip2 p7zip-full
RUN rm /etc/init/plymouth* /etc/init/mountall*

RUN apt-get -y install libnss3 libicu48 libicu-dev libmhash-dev libmhash2 libmcrypt-dev libmcrypt4 gettext libgettextpo-dev libgettextpo0 libfreetype6 libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8  libgd2-xpm-dev libgd-tools libxpm4 libbz2-dev libreadline-dev
RUN apt-get -y install libc-client2007e-dev libssh2-1-dev

CMD ["/sbin/init"]