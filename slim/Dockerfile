FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    git sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers 

USER docker
WORKDIR /home/docker

RUN git config --global credential.helper store
