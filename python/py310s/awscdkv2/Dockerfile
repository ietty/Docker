FROM ietty/python310:latest

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    nodejs npm unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n && n latest
RUN npm install -g npm && npm -g update
RUN npm install -g \
    aws-cdk aws-cdk-lib typescript \
    && npm cache clean --force

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# ssm manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm -f session-manager-plugin.deb

USER docker
WORKDIR /home/docker

RUN mamba install -y python-dotenv autopep8 pytest 
RUN pip install aws-cdk-lib constructs cdk-remote-stack pyyaml

RUN git config --global credential.helper store
