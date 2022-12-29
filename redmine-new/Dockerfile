FROM ubuntu:focal

LABEL maintainer shintaro.tanaka<shintaro.tanaka@ietty.co.jp>

ENV RUBY_VERSION=2.6 \
    REDMINE_VERSION=4.2.9 \
    REDMINE_USER="redmine" \
    REDMINE_HOME="/home/redmine" \
    REDMINE_LOG_DIR="/var/log/redmine" \
    REDMINE_ASSETS_DIR="/etc/assets" \
    RAILS_ENV=production

# OS Configuration
RUN locale-gen ja_JP.UTF-8

# Dependent Packages
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    logrotate mysql-client ca-certificates sudo tzdata locales \
    imagemagick git cvs rsync ruby${RUBY_VERSION} openssh-client \
    make patch pkg-config ruby${RUBY_VERSION}-dev libc6-dev zlib1g-dev libxml2-dev \
    libmysqlclient20 libyaml-0-2 libcurl3 libssl1.0.0 uuid-dev xz-utils \
    libxslt1.1 libffi6 zlib1g gsfonts ghostscript \
    wget vim lsof \
  && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
  && gem install --no-document bundler \
  && rm -rf /var/lib/apt/lists/*

#作業用ユーザ作成
RUN useradd -m -s /bin/bash docker && \
    usermod -aG users docker && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY assets/ ${REDMINE_ASSETS_DIR}/
RUN bash ${REDMINE_ASSETS_DIR}/install.sh

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3000/tcp

USER docker
WORKDIR ${REDMINE_HOME}

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["app:init"]