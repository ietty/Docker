From centos:7
MAINTAINER "takemi.ohama" <takemi.ohama@ietty.co.jp>

RUN yum -y update && yum -y upgrade
RUN yum install -y '@Development Tools'
RUN yum install -y epel-release
RUN yum install -y wget subversion git sudo bzip2
RUN yum install -y openssl-devel readline-devel zlib-devel curl-devel \
                    libyaml-devel libffi-devel ImageMagick ImageMagick-devel ipa-pgothic-fonts
RUN yum install -y mariadb mariadb-devel mariadb-libs
RUN yum install -y openssl python-devel python-pip
RUN yum clean all
RUN sed -i -e "s/Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers
RUN pip install awscli
RUN rm -rf ~/.cache/pip

WORKDIR /usr/local
RUN git config --global credential.helper store && \
    git clone https://github.com/sstephenson/rbenv.git rbenv && \
    mkdir rbenv/shims rbenv/versions rbenv/plugins && \
    groupadd rbenv && chgrp -R rbenv rbenv && chmod -R g+rwxXs rbenv

WORKDIR /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git ruby-build
RUN chgrp -R rbenv ruby-build && chmod -R g+rwxs ruby-build

RUN git clone https://github.com/sstephenson/rbenv-default-gems.git rbenv-default-gems
RUN chgrp -R rbenv rbenv-default-gems && chmod -R g+rwxs rbenv-default-gems

RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' > /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >>  /etc/profile.d/rbenv.sh && \
    echo 'bundler' >> /usr/local/rbenv/default-gems && \
    echo 'rbenv-rehash' >> /usr/local/rbenv/default-gems && \
    echo '%rbenv ALL=(ALL) ALL' >> /etc/sudoers

ENV PATH "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
RUN source /etc/profile.d/rbenv.sh && \
    ruby-build/install.sh
ENV CONFIGURE_OPTS --disable-install-doc

RUN su -l root -c 'rbenv install 2.2.2 -v && rbenv rehash && rbenv global 2.2.2'

RUN adduser docker && \
    usermod -G rbenv,wheel,users docker && \
    usermod -G users root && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# タイムゾーンをAsia/Tokyoに変更
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

EXPOSE 3000

USER docker
WORKDIR /home/docker

CMD ["tail","-f","/dev/null"]
