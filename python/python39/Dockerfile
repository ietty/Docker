FROM ubuntu:22.04

LABEL MAINTAINER takemi.ohama<takemi.ohama@gmail.com>

USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git vim wget mysql-client ssh libreadline-dev curl \
    ca-certificates sudo unzip locales language-pack-ja-base language-pack-ja \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ARG PYTHON_VERSION=3.9.16
ARG O_USER="docker"
ARG O_UID="1000"
ARG O_GID="1000"
ARG CONDA_DIR=/opt/conda

ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PYTHONUNBUFFERED=TRUE \
    PYTHONDONTWRITEBYTECODE=TRUE \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    VISIBLE=now \
    PATH=${CONDA_DIR}/bin:${PATH}

RUN useradd -m -s /bin/bash docker && \
    usermod -aG users docker && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh && \
    mkdir -p ${CONDA_DIR} && \
    chown -R docker:users ${CONDA_DIR} && \
    find ${CONDA_DIR} -type d -print0 | xargs -0 chmod g+s

USER docker
WORKDIR /home/docker

RUN set -x && \
    miniforge_installer="Mambaforge-Linux-$(uname -m).sh" && \
    wget -q https://github.com/conda-forge/miniforge/releases/latest/download/${miniforge_installer} && \
    /bin/bash "${miniforge_installer}" -f -b -p "${CONDA_DIR}" && \
    rm "${miniforge_installer}" && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    mamba install --quiet --yes python~="${PYTHON_VERSION}" && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "${CONDA_DIR}/conda-meta/pinned" && \
    mamba install --quiet --yes mamba && \
    mamba update --all --quiet --yes && \
    mamba clean --all -f -y

RUN mamba install --quiet --yes \
    'pandas' \
    'boto3' \
    && mamba clean --all -f -y

CMD tail -f /dev/null
