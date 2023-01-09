#!/bin/bash
registry=ietty
name=redmine-new
private_ecr=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
tag=latest

docker build --no-cache -t ${registry}/${name}:${tag} .
docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest

function pushPrivateECR(){
    aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:latest
    docker push ${private_ecr}/${name}:latest
    echo "pushed: ${private_ecr}/${name}:${tag}"
}

pushPrivateECR
