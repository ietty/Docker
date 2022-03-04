FROM ietty/python38:latest

USER root

RUN conda install --quiet --yes \
    'readline' \
    'autopep8' \
    'line_profiler' \
    'jinja2' \
    && conda build purge-all

RUN pip install BTrees

USER docker
WORKDIR /home/docker

