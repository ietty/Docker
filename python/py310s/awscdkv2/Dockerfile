FROM ietty/python310:latest

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n && n latest
RUN npm install -g npm && npm -g update
RUN npm install -g \
    aws-cdk aws-cdk-lib typescript \
    && npm cache clean --force

USER docker
WORKDIR /home/docker

RUN mamba install -y python-dotenv autopep8 pytest 
RUN pip install aws-cdk-lib constructs


