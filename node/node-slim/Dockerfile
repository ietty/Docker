FROM node:slim
RUN apt-get update && apt-get install -y  \
    git procps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV OPT_DIR=/opt

RUN usermod -aG users node && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p ${OPT_DIR} && \
    chown -R node:users ${OPT_DIR} 

USER node
WORKDIR /home/node

