FROM golang:1.15

LABEL maintainer="takemi.ohama@gmail.com"

RUN go get github.com/jinzhu/gorm github.com/jinzhu/gorm/dialects/mysql \
           github.com/joho/godotenv googlemaps.github.io/maps github.com/pkg/errors \
           github.com/aws/aws-sdk-go github.com/guregu/dynamo

#for VSCode
RUN go get github.com/uudashr/gopkgs/v2/cmd/gopkgs github.com/sqs/goreturns \
           golang.org/x/tools/cmd/gorename github.com/ramya-rao-a/go-outline \
           github.com/go-delve/delve/cmd/dlv github.com/mdempsky/gocode \
           github.com/rogpeppe/godef


