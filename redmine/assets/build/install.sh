#!/bin/bash
set -e

# 一時的に利用するパッケージ
BUILD_DEPENDENCIES="libcurl4-openssl-dev libssl-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev \
                    libpq-dev libxslt1-dev libffi-dev libyaml-dev libsqlite3-dev"

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ${BUILD_DEPENDENCIES}

# ユーザ作成
adduser --disabled-login --gecos 'redmine' ${REDMINE_USER}
passwd -d ${REDMINE_USER}

exec_as_redmine() {
  sudo -HEu ${REDMINE_USER} "$@"
}

# redmineインストール
exec_as_redmine mkdir -p ${REDMINE_INSTALL_DIR}

echo "Downloading Redmine ${REDMINE_VERSION}..."
exec_as_redmine wget "http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" -O /tmp/redmine-${REDMINE_VERSION}.tar.gz

echo "Extracting..."
exec_as_redmine tar -zxf /tmp/redmine-${REDMINE_VERSION}.tar.gz --strip=1 -C ${REDMINE_INSTALL_DIR}

exec_as_redmine rm -rf /tmp/redmine-${REDMINE_VERSION}.tar.gz

# dalli -> memcachedのクライアントgem
(
  echo '# add for redmine/redmine'
  echo 'gem "unicorn", "~> 5.4", "!=5.5.0"';
  echo 'gem "dalli", "~> 2.7.0"';
  echo '# pry'
  echo 'gem "pry-rails"';
  echo 'gem "pry-doc"';
  echo 'gem "rb-readline"';
) >> ${REDMINE_INSTALL_DIR}/Gemfile

# 先にdatabase.yml作っておかないとbundle installで落ちる
exec_as_redmine cp ${REDMINE_INSTALL_DIR}/config/database.yml.example ${REDMINE_INSTALL_DIR}/config/database.yml

# gem投入
GEM_CACHE_DIR="${REDMINE_BUILD_ASSETS_DIR}/cache"
cd ${REDMINE_INSTALL_DIR}

if [[ -d ${GEM_CACHE_DIR} ]]; then
  cp -a ${GEM_CACHE_DIR} ${REDMINE_INSTALL_DIR}/vendor/cache
  chown -R ${REDMINE_USER}: ${REDMINE_INSTALL_DIR}/vendor/cache
fi
exec_as_redmine bundle config set path "${REDMINE_INSTALL_DIR}/vendor/bundle"
exec_as_redmine bundle install -j$(nproc)
exec_as_redmine mkdir -p ${REDMINE_INSTALL_DIR}/tmp ${REDMINE_INSTALL_DIR}/tmp/pdf ${REDMINE_INSTALL_DIR}/tmp/pids ${REDMINE_INSTALL_DIR}/tmp/sockets

# 同期系
rm -rf ${REDMINE_INSTALL_DIR}/public/plugin_assets
exec_as_redmine ln -sf ${REDMINE_DATA_DIR}/tmp/plugin_assets ${REDMINE_INSTALL_DIR}/public/plugin_assets

rm -rf ${REDMINE_INSTALL_DIR}/tmp/thumbnails
exec_as_redmine ln -sf ${REDMINE_DATA_DIR}/tmp/thumbnails ${REDMINE_INSTALL_DIR}/tmp/thumbnails

rm -rf ${REDMINE_INSTALL_DIR}/log
exec_as_redmine ln -sf ${REDMINE_LOG_DIR}/redmine ${REDMINE_INSTALL_DIR}/log

# ビルドの依存関係を解消して削除
apt-get purge -y --auto-remove ${BUILD_DEPENDENCIES}
rm -rf /var/lib/apt/lists/*