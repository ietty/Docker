FROM golang:1.8
MAINTAINER takemi.ohama@gmail.com

ENV REFRESHED_AT 2017-08-21
ENV OAUTH2_PROXY_VERSION 2.2

ADD https://github.com/weargoggles/oauth2_proxy/releases/download/v2.2-websocket/oauth2_proxy-2.2.0.linux-amd64.go1.8.tar.gz /tmp
RUN tar -xf /tmp/oauth2_proxy-2.2.0.linux-amd64.go1.8.tar.gz -C ./bin --strip-components=1 && rm /tmp/*.tar.gz

EXPOSE 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
