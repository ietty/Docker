FROM ubuntu:xenial

LABEL MAINTAINER takemi.ohama@ietty.co.jp

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get upgrade -y && apt-get update -y && \
    apt-get install -y git curl wget mysql-client libmysqlclient-dev \
    g++ zlib1g-dev libssl-dev libreadline-dev libreadline6-dev libyaml-dev \
    libxml2-dev libaio1 libxslt-dev libqt4-dev imagemagick libffi-dev \
    checkinstall libjpeg-dev aptitude software-properties-common redis-tools \
    autoconf bison build-essential  zlib1g-dev libncurses5-dev \
    libgdbm-dev libdb-dev tzdata sudo unzip

#rbenvとpluginのダウンロード
WORKDIR /usr/local
RUN git config --global credential.helper store && \
    git clone https://github.com/sstephenson/rbenv.git rbenv && \
    mkdir rbenv/shims rbenv/versions rbenv/plugins && \
    groupadd rbenv && chgrp -R rbenv rbenv && chmod -R g+rwxXs rbenv

WORKDIR /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git && \
    git clone https://github.com/ianheggie/rbenv-binstubs.git && \
    git clone https://github.com/rkh/rbenv-update.git && \
    git clone https://github.com/sstephenson/rbenv-default-gems.git
RUN chgrp -R rbenv /usr/local/rbenv/plugins && chmod -R g+rwxs /usr/local/rbenv/plugins

#rbenvの環境設定
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' > /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >>  /etc/profile.d/rbenv.sh && \
    echo 'bundler' >> /usr/local/rbenv/default-gems && \
    echo 'rbenv-rehash' >> /usr/local/rbenv/default-gems

RUN . /etc/profile.d/rbenv.sh && ruby-build/install.sh

ENV RBENV_ROOT "/usr/local/rbenv"
ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"
ENV CONFIGURE_OPTS --disable-install-doc

RUN rbenv install 2.7.2 -v && rbenv rehash && rbenv global 2.7.2
RUN gem uninstall bundler && gem install bundler -v 2.2.30

#作業用ユーザ作成
RUN useradd -m -s /bin/bash docker && \
    usermod -G rbenv,users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

EXPOSE 3000

USER docker
WORKDIR /home/docker
ENV RBENV_ROOT "/usr/local/rbenv"
ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

CMD ["tail","-f","/dev/null"]
