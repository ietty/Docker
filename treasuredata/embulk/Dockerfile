FROM ubuntu:focal

LABEL MAINTAINER=takemi.ohama<takemi.ohama@gmail.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && \
    apt-get install -y vim tzdata wget mysql-client ssh libreadline-dev curl git \
    ca-certificates sudo locales language-pack-ja-base language-pack-ja \
    g++ make libmysqlclient-dev ruby ruby-dev python3-pip lftp openjdk-8-jdk nkf \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i -e "s/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"  
ENV LANG=ja_JP.UTF-8 

RUN pip3 install awscli && \
    echo "complete -C aws_completer aws" >> /etc/profile

RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh

RUN mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN wget -q "https://github.com/embulk/embulk/releases/download/v0.10.1/embulk-0.10.1.jar" -O /usr/local/bin/embulk
RUN chmod +x /usr/local/bin/embulk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jdk/bin/java 

RUN embulk gem install embulk-input-http embulk-input-mysql embulk-input-google_analytics \
    embulk-input-google_spreadsheets embulk-input-redash \
    embulk-output-bigquery embulk-output-mysql embulk-output-s3 embulk-output-elasticsearch \
    embulk-output-gcs embulk-output-google_spreadsheets embulk-output-elasticsearch5 embulk-output-redis \
    embulk-filter-column embulk-filter-ruby_proc embulk-filter-row embulk-filter-add_time \
    embulk-filter-mysql embulk-parser-jsonl embulk-formatter-jsonl embulk-filter-unpivot \
    embulk-filter-rearrange embulk-filter-concat 
    
