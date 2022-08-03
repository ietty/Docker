#!/bin/bash
registry=ietty
name=redmine
private_ecr=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
tag=$1

docker build -t ${registry}/${name}:${tag} .
docker run -it --rm ${registry}/${name} bash
docker push ${registry}/${name}:${tag}

function pushDockerHub(){
    docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest
    docker login
    docker push ${registry}/${name}:${tag}
    echo "pushed: ${registry}/${name}:${tag}"
}

function pushPrivateECR(){
    aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${private_ecr}
    aws ecr create-repository --repository-name ${name}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:${tag}
    docker push ${private_ecr}/${name}:${tag}
    echo "pushed: ${private_ecr}/${name}:${tag}"
}

# pushDockerHub
pushPrivateECR
