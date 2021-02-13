From centos:7

MAINTAINER "kenji.uejima" <kenji.uejima@ietty.co.jp>

RUN yum -y update && yum -y upgrade && \
    yum -y install epel-release && \
    yum -y install npm sudo git openssl openssl-devel python-pip

RUN npm cache clean && \
    npm install n -g && \
    n latest && \
    npm update -g npm && \
    yum erase -y nodejs npm && yum -y clean all

RUN pip install awscli
RUN rm -rf ~/.cache/pip

# docker client install
ENV VER="17.03.0-ce"
RUN curl -fsSL https://get.docker.com/builds/Linux/x86_64/docker-${VER}.tgz \
    | tar -xz -C /usr/bin --strip=1 docker/docker

RUN adduser docker && \
    usermod -G wheel,users docker && \
    usermod -G users root && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN sed -i -e "s/Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers

RUN bash -lc "npm install hubot yo generator-hubot coffee-script forever -g"

USER docker
WORKDIR /home/docker

EXPOSE 8080

CMD ["tail","-f","/dev/null"]
