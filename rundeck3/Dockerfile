FROM rundeck/rundeck:3.0.6  

LABEL MAINTAINER=takemi.ohama<takemi.ohama@gmail.com>

USER root

RUN apt-get update && apt-get install -y language-pack-ja vim git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"  
RUN echo "rundeck ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/rundeck

USER rundeck
WORKDIR /home/rundeck
RUN echo "export LANG=ja_JP.UTF-8" >> /home/rundeck/.profile
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
RUN source /etc/default/locale
