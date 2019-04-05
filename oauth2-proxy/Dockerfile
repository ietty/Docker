FROM golang:1.11
LABEL MAINTAINER=takemi.ohama@gmail.com

ENV OAUTH2_PROXY_VERSION v3.1.0

ADD https://github.com/pusher/oauth2_proxy/releases/download/$OAUTH2_PROXY_VERSION/oauth2_proxy-$OAUTH2_PROXY_VERSION.linux-amd64.go1.11.tar.gz /tmp
RUN tar -xf /tmp/oauth2_proxy-$OAUTH2_PROXY_VERSION.linux-amd64.go1.11.tar.gz -C ./bin --strip-components=1 && rm /tmp/*.tar.gz
RUN mv ./bin/oauth2_proxy-linux-amd64 ./bin/oauth2_proxy

EXPOSE 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
