# DOCKER-VERSION 0.5.3
FROM ubuntu:12.04
MAINTAINER Codio "info@codio.com"

# fix deps from universe
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" > /etc/apt/sources.list.d/universe.list

# Base software install
RUN echo 'base software and libraries' && \
    apt-get -y update && \
    apt-get -y install dialog curl wget man vim nano openssh-server python-software-properties build-essential rsync libssl1.0.0 libssl-dev libpcre3 libpcre3-dev libxml2 libxml2-dev openssl libcurl4-openssl-dev postgresql-server-dev-9.1 libreadline-dev s3cmd libevent1-dev libevent-1.4-2 libncurses5-dev autotools-dev automake pkg-config zlib1g-dev liblzma-dev libxslt-dev libgmp3c2 libgmp3-dev libgl1-mesa-dev libglc-dev freeglut3-dev libedit-dev libglw1-mesa libglw1-mesa-dev unzip zsh zsh-lovers bzip2 p7zip-full libnss3 libicu48 libicu-dev libmhash-dev libmhash2 libmcrypt-dev libmcrypt4 gettext libgettextpo-dev libgettextpo0 libfreetype6 libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8  libgd2-xpm-dev libgd-tools libxpm4 libbz2-dev libreadline-dev libc-client2007e-dev libssh2-1-dev python-dev emacs libffi-dev libglib2.0-dev gfortran gfortran-multilib libmad0-dev sshpass xvfb x11vnc tk-dev xfonts-\* && \
    echo 'extra repo'&& \
    apt-add-repository -y ppa:git-core/ppa&& \
    apt-add-repository -y ppa:webupd8team/java&& \
    apt-get -y update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get -y install oracle-java7-installer git mercurial subversion && \
    echo 'locales'&& \
    cp /usr/share/i18n/SUPPORTED  /var/lib/locales/supported.d/local && \
    dpkg-reconfigure locales && \
    echo "LANG=en_US.UTF-8" > /etc/default/locale && \
    rm /etc/motd && \
    rm /etc/legal && \
    rm /etc/init/plymouth* /etc/init/mountall* && \
    dpkg-divert --remove /sbin/initctl && rm /sbin/initctl && mv /sbin/initctl.distrib /sbin/initctl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a user
RUN adduser codio --disabled-password --uid 1100

ADD ./init/codio.conf /etc/init/codio.conf
ADD ./codio-start /usr/sbin/codio-start
ADD ./codio-startup /usr/sbin/codio-startup
ADD ./etc/default/gitconfig /etc/gitconfig
ADD ./etc/box /etc/box
ADD ./etc/rc.xml /etc/xdg/openbox/rc.xml

RUN chown root:root /usr/sbin/codio-start && chmod 700 /usr/sbin/codio-start && chmod +x /usr/sbin/codio-startup

RUN apt-add-repository -y ppa:ubuntu-toolchain-r/test && apt-get -y update && apt-get -y install gcc-4.8 g++-4.8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50


RUN apt-get install -y telnet net-tools iputils-ping traceroute gobjc gobjc-4.8 gnustep gnustep-make gnustep-common gnustep-devel gobjc++-4.8 gobjc++-4.6

# RPC ---- start
RUN apt-add-repository -y ppa:chris-lea/node.js
RUN add-apt-repository -y ppa:brightbox/ruby-ng-experimental
RUN apt-get -y update
RUN apt-get -y install git nodejs ruby2.0 ruby2.0-dev mercurial

RUN npm install -g bower
RUN npm install -g jitsu
RUN npm install -g git://github.com/codio/snr.git
RUN npm install -g less@1.7.1
RUN gem install --no-rdoc --no-ri sass
RUN curl -s https://www.parse.com/downloads/cloud_code/installer.sh | /bin/bash

RUN apt-get -y autoremove
RUN mkdir /usr/share/rpc
# environment variables
ENV PATH /usr/share/rpc:$PATH

# RPC ---- end

# environment variables
ENV HOME /home/codio
RUN dpkg-divert --add --rename --divert /bin/su.codio /bin/su && dpkg-divert --add --rename --divert /usr/bin/sudo.codio /usr/bin/sudo && dpkg-divert --add --rename --divert /usr/bin/apt-get.codio /usr/bin/apt-get && dpkg-divert --add --rename --divert /usr/bin/apt-cache.codio /usr/bin/apt-cache

ADD ./fake-apt /usr/bin/apt-get
ADD ./fake-apt /usr/bin/apt-cache
ADD ./fake-apt /usr/bin/aptitude

ADD ./fake-sudo /usr/bin/sudo
ADD ./fake-sudo /bin/su

ADD ./etc/ld.conf /etc/ld.so.conf.d/codio_part.sconf

RUN chmod +x /usr/bin/apt-get /usr/bin/apt-cache /usr/bin/aptitude /usr/bin/sudo /bin/su

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN echo "AUTOPARTS_NO_AUTOUPDATE=1" >> /etc/environment
RUN echo "export CODIO_HOSTNAME=\`cat /etc/hostname\`" > /etc/profile.d/codio.sh &&  echo "export CODIO_BOX_DOMAIN=\$CODIO_HOSTNAME.codio.io" >> /etc/profile.d/codio.sh && chmod +x /etc/profile.d/codio.sh

CMD ["/sbin/init"]