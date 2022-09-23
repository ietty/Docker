FROM ubuntu:focal

LABEL MAINTENER shintaro.tanaka<shintaro.tanaka@ietty.co.jp>

ENV TERM=xterm
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y && \
    apt-get install -y git curl wget sudo vim unzip ca-certificates gnupg lsb-release \
    g++ make zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev \
    libaio1 libxslt-dev libxml2-dev imagemagick libffi-dev libjpeg-dev \
    fonts-ipaexfont-gothic fonts-ipaexfont-mincho \
    mysql-client-8.0 default-libmysqlclient-dev redis-tools \
    && rm -rf /var/lib/apt/lists/*

#作業用ユーザ作成
RUN useradd -m -s /bin/bash docker && \
    usermod -aG users docker && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

    # docker 
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

#rbenvとpluginのダウンロード
WORKDIR /usr/local
RUN git config --global credential.helper store && \
    git clone https://github.com/sstephenson/rbenv.git rbenv && \
    mkdir rbenv/shims rbenv/versions rbenv/plugins && \
    groupadd rbenv && chgrp -R rbenv rbenv && chmod -R g+rwxXs rbenv

# rbenv plugin のinstall
WORKDIR /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git && \
    git clone https://github.com/ianheggie/rbenv-binstubs.git && \
    git clone https://github.com/rkh/rbenv-update.git && \
    git clone https://github.com/sstephenson/rbenv-default-gems.git
RUN chgrp -R rbenv /usr/local/rbenv/plugins && chmod -R g+rwxs /usr/local/rbenv/plugins
RUN usermod -aG rbenv docker

#rbenvの環境設定
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' > /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >>  /etc/profile.d/rbenv.sh && \
    echo 'bundler' >> /usr/local/rbenv/default-gems && \
    echo 'rbenv-rehash' >> /usr/local/rbenv/default-gems
ENV RBENV_ROOT=/usr/local/rbenv
ENV PATH=/usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CONFIGURE_OPTS --disable-install-doc

# ruby
RUN . /etc/profile.d/rbenv.sh && ruby-build/install.sh && \
    rbenv install 3.1.0 -v && rbenv rehash && rbenv global 3.1.0

# bundler
RUN echo "install: --no-document" > /home/docker/.gemrc && \
    gem install bundler -v 2.3.10 && gem install foreman

#npmインストール
RUN apt-get update && apt-get install -y nodejs npm && \
    npm cache verify --force && \
    npm install n -g && \
    npm update -g npm && \
    n 8.5.0 && \
    apt-get purge -y nodejs npm
RUN npm install -g npm-check-updates
RUN apt-get -y clean && rm -rf /var/lib/apt/lists/*

# ImageMagicでPDF許可
RUN sed -i -e 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/' /etc/ImageMagick-6/policy.xml

USER docker
WORKDIR /home/docker

CMD ["tail","-f","/dev/null"]
