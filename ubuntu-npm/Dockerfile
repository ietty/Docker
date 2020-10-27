FROM ubuntu:focal

LABEL MAINTAINER takemi.ohama@ietty.co.jp

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get upgrade -y && apt-get update && apt-get install -y apt-utils
RUN apt-get install -y vim wget curl tzdata git ca-certificates sudo locales 
RUN apt-get install -y language-pack-ja-base language-pack-ja 
RUN apt-get install -y nodejs npm

#npmとnodeを最新版に更新
RUN npm install --no-progress -g n  
RUN n 12.19.0
RUN npm install --no-progress -g yarn typings typescript @angular/cli 
RUN yarn global add npm

RUN sed -i -e "s/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh


RUN echo 'export DISPLAY=:99' >> /etc/profilei && \
    echo 'export CHROME_BIN=/usr/bin/google-chrome-stable' >> /etc/profile && \
    echo 'export PATH=/usr/local/bin:$PATH' >> /etc/profile && \ 
    echo 'export PATH=/usr/local/bin:$PATH' >> /root/.bashrc 

USER docker
WORKDIR /home/docker

CMD ["tail","-f","/dev/null"]
