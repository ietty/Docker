FROM centos:latest
MAINTAINER "kenji.uejima" <kenji.uejima@ietty.co.jp>

RUN yum -y update && yum -y upgrade && \
    yum install -y epel-release && \
    yum install -y git sudo nginx php php-fpm php-mysql php-gd php-mcrypt php-xml php-mbstring && \
    yum install -y mariadb mariadb-devel mariadb-libs

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +rx /usr/local/bin/wp

RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN adduser docker && \
    usermod -G wheel,users docker && \
    usermod -G users root && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN echo 'export PATH=/usr/local/bin:$PATH' >> /etc/profile
RUN sed -i -e "s/Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers

VOLUME ["/etc/nginx"]

EXPOSE 80 9000

