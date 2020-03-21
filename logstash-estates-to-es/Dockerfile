FROM logstash:7.6.1

#ARG RDS_ENDPOINT
#ARG RDS_DATABASE
#ARG RDS_USERNAME
#ARG RDS_PASSWORD
#ARG ES_ENDPOINT

#ENV RDS_ENDPOINT=${RDS_ENDPOINT} \
#    RDS_DATABASE=${RDS_DATABASE} \
#    RDS_USERNAME=${RDS_USERNAME} \
#    RDS_PASSWORD=${RDS_PASSWORD} \
#    ES_ENDPOINT=${ES_ENDPOINT}

RUN rm -f /usr/share/logstash/pipeline/*
#COPY pipeline /usr/share/logstash/pipeline
#COPY pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY mysql-connector-java-8.0.19.jar /usr/share/logstash/mysql-connector-java-8.0.19.jar

COPY export.sh /tmp/export.sh
COPY .env.example /tmp/.env
