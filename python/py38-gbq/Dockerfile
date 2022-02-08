FROM ietty/python38:latest

USER root


RUN pip install pandas-gbq google-cloud-bigquery-datatransfer

USER docker
WORKDIR /home/docker
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE

