FROM ubuntu:focal

LABEL "shintaro.tanaka" <shintaro.tanaka@ietty.co.jp>

ENV TERM=xterm
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get upgrade -y && apt-get update -y && \
    apt-get install -y git curl wget tmux \
    g++ zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev \
    libaio1 libxslt-dev libxml2-dev qtdeclarative5-dev imagemagick libffi-dev \
    checkinstall libjpeg-dev aptitude software-properties-common redis-tools \
    fonts-ipaexfont-gothic fonts-ipaexfont-mincho fonts-ubuntu-font-family-console \
    libldap2-dev libidn11-dev sudo

#mysqlクライアント
RUN apt-get install -y mysql-server-8.0 mysql-client-8.0 default-libmysqlclient-dev

#C++とphantomjsのインストール
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get install -y g++-9 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 20

WORKDIR /usr/local/share/
RUN curl -sSL -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar jxvf phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs && \
    ln -sf /usr/share/zoneinfo/Japan /etc/localtime

#rbenvとpluginのダウンロード
WORKDIR /usr/local
RUN git config --global credential.helper store && \
    git clone https://github.com/sstephenson/rbenv.git rbenv && \
    mkdir rbenv/shims rbenv/versions rbenv/plugins && \
    groupadd rbenv && chgrp -R rbenv rbenv && chmod -R g+rwxXs rbenv

#作業用ユーザ作成
RUN useradd -m -s /bin/bash docker && \
    usermod -G rbenv,users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

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
ENV CONFIGURE_OPTS --disable-install-doc
RUN su -l root -c 'rbenv install 3.1.0 -v && rbenv rehash && rbenv global 3.1.0'

#npmインストール
RUN apt-get install -y nodejs npm && \
    npm cache verify --force && \
    npm install n -g && \
    npm update -g npm && \
    n 8.5.0 && \
    apt-get purge -y nodejs npm
RUN npm install -g npm-check-updates
RUN apt-get -y clean

#gem関連
RUN printf "install: --no-document\ninstall: --no-document\n" > /home/docker/.gemrc && \
    bash -lc 'gem update --system && gem install bundler -v 2.3.10 && gem install foreman'

#redis

EXPOSE 3000

USER docker
WORKDIR /home/docker


CMD ["tail","-f","/dev/null"]
