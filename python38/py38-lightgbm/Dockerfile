FROM ietty/python38:latest

USER root

RUN conda install --quiet --yes \
    'lightgbm' \
    'imbalanced-learn' \
    'catboost' \
    && conda build purge-all

RUN conda install --quiet --yes \
    'readline' \
    'autopep8' \
    'line_profiler' \
    'memory_profiler' \
    && conda build purge-all

USER docker
WORKDIR /home/docker
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE

