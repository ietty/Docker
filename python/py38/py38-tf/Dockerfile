FROM ietty/python38:latest

USER root

RUN conda install --quiet --yes \
    'readline' \
    'autopep8' \
    'line_profiler' \
    'scikit-learn' \
    'scipy' \
    'lightgbm' \
    'featuretools' \
    && conda build purge-all

RUN conda install --quiet --yes -c anaconda \
    'tensorflow=2.2.0' \
    && conda build purge-all

USER docker
WORKDIR /home/docker

