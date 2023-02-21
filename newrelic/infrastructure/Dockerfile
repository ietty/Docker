FROM ubuntu:jammy

ENV TERM=xterm
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl wget vim unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# newrelic-infra-ecs-installer.sh の実行に必要な情報
RUN aws configure set default.region ap-northeast-1

# newrelic infrastructure
# https://docs.newrelic.com/jp/docs/infrastructure/elastic-container-service-integration/install-ecs-integration/#auto-script-install
ARG YOUR_CLUSTER_NAME
ARG YOUR_LICENSE_KEY
RUN curl -O https://download.newrelic.com/infrastructure_agent/integrations/ecs/newrelic-infra-ecs-installer.sh && \
    chmod +x newrelic-infra-ecs-installer.sh && \
    ./newrelic-infra-ecs-installer.sh -f -c $YOUR_CLUSTER_NAME -l $YOUR_LICENSE_KEY

USER docker
WORKDIR /home/docker

CMD ["tail","-f","/dev/null"]
