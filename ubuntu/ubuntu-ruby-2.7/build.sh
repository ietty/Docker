#!/bin/bash

docker build -t ietty/ubuntu-ruby-2.7 .
docker run -it --rm ietty/ubuntu-ruby-2.7 bash
docker login
docker push ietty/ubuntu-ruby-2.7:latest
