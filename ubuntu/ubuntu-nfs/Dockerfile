FROM ubuntu:latest

LABEL MAINTAINER=takemi.ohama<takemi.ohama@gmail.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y nfs-common rsync \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

