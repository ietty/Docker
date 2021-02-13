FROM ubuntu:focal

LABEL MAINTAINER takemi.ohama<takemi.ohama@gmail.com>

EXPOSE 22

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && \
    apt-get install -y git vim wget mysql-client ssh libreadline-dev curl \
    ca-certificates sudo unzip locales language-pack-ja-base language-pack-ja \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-locale LANGUAGE=ja_JP:ja LANG=ja_JP.UTF-8

# Configure environment
ENV CONDA_DIR /var/lib/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV LC_ALL ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8

RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh

RUN echo "export VISIBLE=now" >> /etc/profile

RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    ln -s $CONDA_DIR/bin/conda /usr/bin/conda 
RUN conda install --quiet --yes conda conda-build && \
    conda config --system --add channels conda-forge && \
    conda build purge-all

RUN conda install --quiet --yes \
    'pandas' \
    'sqlalchemy' \
    'pymysql' \
    'requests' \
    'boto3' \
    && conda build purge-all

USER docker
WORKDIR /home/docker

