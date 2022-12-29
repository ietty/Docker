#!/bin/bash
set -e

# ユーザ作成
adduser --disabled-login --gecos 'redmine' ${REDMINE_USER}
passwd -d ${REDMINE_USER}

exec_as_redmine() {
  sudo -HEu ${REDMINE_USER} "$@"
}

# redmineインストール
exec_as_redmine mkdir -p ${REDMINE_HOME}

echo "Downloading Redmine ${REDMINE_VERSION}..."
exec_as_redmine wget "http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" -O /tmp/redmine-${REDMINE_VERSION}.tar.gz

echo "Extracting..."
exec_as_redmine tar -zxf /tmp/redmine-${REDMINE_VERSION}.tar.gz --strip=1 -C ${REDMINE_HOME}
exec_as_redmine rm -rf /tmp/redmine-${REDMINE_VERSION}.tar.gz

exec_as_redmine cp ${REDMINE_HOME}/config/database.yml.example ${REDMINE_HOME}/config/database.yml

apt-get purge -y --auto-remove ${BUILD_DEPENDENCIES}
rm -rf /var/lib/apt/lists/*
