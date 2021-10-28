#!/bin/bash

docker build -t ietty/ubuntu-ruby-2.5 .
docker run -it --rm ietty/ubuntu-ruby-2.5 bash
docker login
docker push ietty/ubuntu-ruby-2.5:latest
