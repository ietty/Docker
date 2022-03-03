FROM ietty/python38:latest

USER root


RUN pip install pandas-gbq google-cloud-bigquery-datatransfer autopep8
RUN rm -f /usr/bin/python3 && \
    ln -s /var/lib/conda/bin/python3 /usr/bin/python3  

USER docker
WORKDIR /home/docker
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PYTHONPATH=/var/lib/conda/

