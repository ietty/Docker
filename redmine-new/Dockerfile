FROM ubuntu:focal

LABEL MAINTENER shintaro.tanaka<shintaro.tanaka@ietty.co.jp>

ENV TERM=xterm \
    TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV RUBY_VERSION=2.6 \
    REDMINE_VERSION=4.2.9 \
    REDMINE_USER="redmine" \
    REDMINE_HOME="/home/redmine" \
    REDMINE_LOG_DIR="/var/log/redmine" \
    REDMINE_ASSETS_DIR="/etc/assets" \
    RAILS_ENV=production

# OS Configuration
RUN locale-gen ja_JP.UTF-8

RUN apt-get update -y && \
    apt-get install -y git curl wget sudo vim ca-certificates gnupg \
    zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev \
    mysql-client-8.0 default-libmysqlclient-dev imagemagick cvs \
    ruby${RUBY_VERSION} ruby${RUBY_VERSION}-dev gsfonts ghostscript \
    && rm -rf /var/lib/apt/lists/*

#作業用ユーザ作成
RUN useradd -m -s /bin/bash docker && \
    usermod -aG users docker && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# redmineインストール
RUN mkdir -p ${REDMINE_HOME} \
    wget "http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" -O /tmp/redmine-${REDMINE_VERSION}.tar.gz \
    tar -zxf /tmp/redmine-${REDMINE_VERSION}.tar.gz --strip=1 -C ${REDMINE_HOME} \
    rm -rf /tmp/redmine-${REDMINE_VERSION}.tar.gz

USER docker
WORKDIR ${REDMINE_HOME}

CMD ["tail","-f","/dev/null"]
