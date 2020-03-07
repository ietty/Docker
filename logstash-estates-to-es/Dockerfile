FROM logstash:7.6.0

ENV RDS_ENDPOINT=${RDS_ENDPOINT} \
    RDS_DATABASE=${RDS_DATABASE} \
    RDS_USERNAME=${RDS_USERNAME} \
    RDS_PASSWORD=${RDS_PASSWORD} \
    ES_ENDPOINT=${ES_ENDPOINT}

RUN rm -f /usr/share/logstash/pipeline/*
#COPY pipeline/main.conf /usr/share/logstash/pipeline/main.conf
COPY mysql-connector-java-8.0.19.jar /usr/share/logstash/mysql-connector-java-8.0.19.jar
