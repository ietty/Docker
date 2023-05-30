FROM golang:1.18.2

LABEL maintainer="takemi.ohama@gmail.com"

RUN go get \
    gorm.io/gorm@latest \
    gorm.io/driver/mysql@latest \
    github.com/joho/godotenv@latest \
    googlemaps.github.io/maps@latest \
    github.com/pkg/errors@latest \
    github.com/aws/aws-sdk-go@latest \
    github.com/guregu/dynamo@latest

#for VSCode
RUN go install \
    github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
    github.com/sqs/goreturns@latest \
    golang.org/x/tools/cmd/gorename@latest \
    github.com/ramya-rao-a/go-outline@latest \
    github.com/go-delve/delve/cmd/dlv@latest \
    github.com/mdempsky/gocode@latest \
    github.com/rogpeppe/godef@latest


