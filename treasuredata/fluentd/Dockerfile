From fluent/fluentd:v1.2.4-debian

MAINTAINER "satoshi.izawa" <satoshi.izawa@ietty.co.jp>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y procps 
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gem install fluent-plugin-s3 -v 1.1.4 --no-document


