FROM golang:latest
LABEL MAINTAINER=takemi.ohama@gmail.com

ENV REFRESHED_AT 2017-08-21
ENV OAUTH2_PROXY_VERSION 2.2

ADD https://github.com/pusher/oauth2_proxy/releases/download/v3.1.0/oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz /tmp
RUN tar -xf /tmp/oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz -C ./bin --strip-components=1 && rm /tmp/*.tar.gz

EXPOSE 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
