#!/bin/bash
registry=ietty
name=redmine-new
tag=latest

docker build -t ${registry}/${name}:${tag} .
docker run -it --rm ${registry}/${name} bash
