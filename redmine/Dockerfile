FROM ubuntu:18.04

LABEL maintainer="shintaro.tanaka@ietty.co.jp"

ENV RUBY_VERSION=2.5 \
    REDMINE_VERSION=4.1.1 \
    REDMINE_USER="redmine" \
    REDMINE_HOME="/home/redmine" \
    REDMINE_LOG_DIR="/var/log/redmine" \
    REDMINE_ASSETS_DIR="/etc/assets" \
    REDMINE_CONFIG_DIR="/etc/config" \
    RAILS_ENV=production

ENV REDMINE_INSTALL_DIR="${REDMINE_HOME}/redmine" \
    REDMINE_DATA_DIR="${REDMINE_HOME}/data" \
    REDMINE_BUILD_ASSETS_DIR="${REDMINE_ASSETS_DIR}/build" \
    REDMINE_RUNTIME_ASSETS_DIR="${REDMINE_ASSETS_DIR}/runtime"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    logrotate nginx mysql-client postgresql-client ca-certificates sudo tzdata \
    imagemagick subversion git cvs bzr mercurial darcs rsync ruby${RUBY_VERSION} locales openssh-client \
    gcc g++ make patch pkg-config gettext-base ruby${RUBY_VERSION}-dev libc6-dev zlib1g-dev libxml2-dev \
    libmysqlclient20 libpq5 libyaml-0-2 libcurl3 libssl1.0.0 uuid-dev xz-utils \
    libxslt1.1 libffi6 zlib1g gsfonts ghostscript sqlite3 libsqlite3-dev \
    wget vim lsof ca-certificates openssh-client \
  && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
  && gem install --no-document bundler \
  && rm -rf /var/lib/apt/lists/*

COPY assets/build/ ${REDMINE_BUILD_ASSETS_DIR}/

RUN bash ${REDMINE_BUILD_ASSETS_DIR}/install.sh

COPY assets/runtime/ ${REDMINE_RUNTIME_ASSETS_DIR}/

COPY entrypoint.sh /sbin/entrypoint.sh

COPY VERSION /VERSION

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3000/tcp

WORKDIR ${REDMINE_INSTALL_DIR}

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["app:init"]