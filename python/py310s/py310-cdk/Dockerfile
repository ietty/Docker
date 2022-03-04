FROM ietty/python310:latest

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n && \
    n latest

RUN npm install -g aws-cdk 

USER docker
WORKDIR /home/docker

