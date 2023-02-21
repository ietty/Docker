#!/bin/bash

name=ubuntu-newrelic-infrastructure
tag=`date +%Y%m%d`01

registry=ietty
private_ecr=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com

# cluster
# arn:aws:ecs:ap-northeast-1:888777505088:cluster/production-ecs
# arn:aws:ecs:ap-northeast-1:888777505088:cluster/staging-ecs
YOUR_CLUSTER_NAME=$1
YOUR_LICENSE_KEY=$2
if [ -z "$YOUR_CLUSTER_NAME" ]; then
    echo "no args YOUR_CLUSTER_NAME"
    exit
fi
if [ -z "$YOUR_LICENSE_KEY" ]; then
    echo "no args YOUR_LICENSE_KEY"
    exit
fi
echo YOUR_CLUSTER_NAME=$YOUR_CLUSTER_NAME
echo YOUR_LICENSE_KEY=$YOUR_LICENSE_KEY

echo ${registry}/${name}:${tag}
docker build \
    --no-cache \
    -t ${registry}/${name}:${tag} . \
    --build-arg YOUR_CLUSTER_NAME=$YOUR_CLUSTER_NAME \
    --build-arg YOUR_LICENSE_KEY=$YOUR_LICENSE_KEY
docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest

function pushPrivateECR(){
    aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${private_ecr}
    aws ecr create-repository --repository-name ${name}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:${tag}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:latest
    docker push ${private_ecr}/${name}:${tag}
    docker push ${private_ecr}/${name}:latest
    echo "pushed: ${private_ecr}/${name}:${tag}"
}


pushPrivateECR
