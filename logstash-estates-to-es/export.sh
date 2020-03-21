#!/bin/bash

cd `dirname $0`

setenv-from-file () {
  if [ $# -eq 1 ]; then
    echo "set environment variables from [$1]"

    while read line
    do
      export "$line"
    done < "$1"
  fi
}

setenv-from-file $1

#echo $RDS_ENDPOINT
#echo $RDS_DATABASE
#echo $RDS_USERNAME
#echo $RDS_PASSWORD
#echo $ES_ENDPOINT
