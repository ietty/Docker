FROM ubuntu:focal

LABEL MAINTENER shintaro.tanaka<shintaro.tanaka@ietty.co.jp>

ENV TERM=xterm \
    TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV RUBY_VERSION=2.7.2 \
    REDMINE_VERSION=4.2.9 \
    REDMINE_HOME="/home/redmine"

# package install
RUN apt-get update -y && \
    apt-get install -y git curl wget sudo vim ca-certificates gnupg \
    zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev \
    mysql-client-8.0 default-libmysqlclient-dev imagemagick cvs \
    gsfonts ghostscript make gcc \
    && rm -rf /var/lib/apt/lists/*

# ruby install
RUN git clone --depth=1 https://github.com/rbenv/ruby-build && PREFIX=/usr/local ./ruby-build/install.sh && rm -rf ruby-build
RUN ruby-build ${RUBY_VERSION} /usr/local

#作業用ユーザ作成
RUN useradd -m -s /bin/bash redmine && \
    usermod -aG users redmine && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

# redmineインストール
RUN wget "http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" -O /tmp/redmine-${REDMINE_VERSION}.tar.gz
RUN ["/bin/bash", "-c", "tar -zxvf /tmp/redmine-${REDMINE_VERSION}.tar.gz --strip=1 -C ${REDMINE_HOME}"]
RUN rm -rf /tmp/redmine-${REDMINE_VERSION}.tar.gz

USER redmine
WORKDIR ${REDMINE_HOME}

CMD ["tail","-f","/dev/null"]
