FROM logstash:7.6.1

COPY mysql-connector-java-8.0.19.jar /usr/share/logstash/mysql-connector-java-8.0.19.jar

### adjust for Multiple Pipeline ###
RUN rm -f /usr/share/logstash/pipeline/*
#COPY pipeline /usr/share/logstash/pipeline
#COPY pipelines.yml /usr/share/logstash/config/pipelines.yml

### adjust for `entrypoint` ###
#COPY export.sh /tmp/export.sh
#COPY .env.example /tmp/.env
