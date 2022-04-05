#!/bin/bash
registry=ietty
name=redmine
tag=latest

docker build -t ${registry}/${name} .
docker run -it --rm ${registry}/${name} bash
docker push ${registry}/${name}:${tag}
