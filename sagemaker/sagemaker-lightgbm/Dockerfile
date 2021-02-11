FROM tensorflow/tensorflow:2.4.1-jupyter

LABEL maintainer="takemi.ohama"

RUN apt update && apt install -y \
    mysql-client sudo vim wget  \
    fonts-ipafont locales language-pack-ja-base language-pack-ja \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install  \
    'sagemaker' \
    'sagemaker-experiments' \
    'sagemaker-studio-image-build' \
    'smdebug' \
    'lightgbm' \
    'catboost' \
    'imbalanced-learn' \
    'autopep8' \
    'line_profiler' \
    'memory_profiler' \
    'ipykernel' \
    'boto3' \
    'SQLAlchemy' \
    'pymysql' \
    'jupyterlab'

RUN useradd -u 1000 -g 100 -m -s /bin/bash docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.users /home/docker/.ssh

RUN python -m ipykernel install --sys-prefix

USER docker
ENV SHELL=/bin/bash
ENV VISIBLE=now
