From centos:7

MAINTAINER "UshioShugo" <ushio.s@gmail.com>


ENV GOROOT=/usr/local/go
ENV GOPATH=/opt/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
ENV GOVERSION=1.7.3

RUN yum -y update && yum -y upgrade && \
    yum -y install epel-release && \
    yum -y install wget git sudo bzip2 tmux gcc openssl

# awscliのインストール
RUN yum -y install python-pip && yum -y clean all
RUN pip install awscli
RUN rm -rf ~/.cache/pip

WORKDIR /tmp
RUN curl https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz | tar -xz
RUN mkdir -p /opt
RUN mv ./go $GOROOT
RUN go version

RUN adduser docker && \
    usermod -G wheel,users docker && \
    usermod -G users root && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p $GOPATH && chown docker.users $GOPATH

RUN echo 'export PATH=/usr/local/bin:$PATH' >> /etc/profile
RUN sed -i -e "s/Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers

USER docker
WORKDIR /home/docker

CMD ["tail","-f","/dev/null"]
