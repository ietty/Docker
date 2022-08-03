#!/bin/bash
registry=ietty
name=redmine
private_ecr=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
tag=$1

docker build -t ${registry}/${name}:${tag} .
docker run -it --rm ${registry}/${name} bash

function pushDockerHub(){
    docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest
    docker login
    docker push ${registry}/${name}:${tag}
    echo "pushed: ${registry}/${name}:${tag}"
}

function pushPrivateECR(){
    aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
    docker tag ${registry}/${name}:${tag} ${private_ecr}/redmine:latest
    docker push ${private_ecr}/redmine:latest
}

# pushDockerHub
pushPrivateECR
