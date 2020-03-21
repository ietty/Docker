#!/bin/bash

if [ $# != 2 ]; then
  echo "require 2 parameters. exit.."
  exit 1
fi

cd .

docker build -t $1:$2 .
