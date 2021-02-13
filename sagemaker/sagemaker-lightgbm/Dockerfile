FROM tensorflow/tensorflow:2.4.1-jupyter

LABEL maintainer="takemi.ohama"

RUN apt update && apt install -y \
    mysql-client sudo vim wget  \
    fonts-ipafont locales language-pack-ja-base language-pack-ja \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG miniforge_installer="Miniforge3-4.9.2-5-Linux-x86_64.sh"
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN wget --quiet "https://github.com/conda-forge/miniforge/releases/download/4.9.2-5/${miniforge_installer}" && \
    /bin/bash "${miniforge_installer}" -f -b -p $CONDA_DIR && \
    rm "${miniforge_installer}" && \
    echo "conda 4.9.2" >> $CONDA_DIR/conda-meta/pinned && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true 

RUN conda install -y \
    xeus-python notebook=6 jupyterlab=3 ptvsd nodejs 

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
RUN jupyter labextension install @jupyterlab/debugger

USER docker
ENV SHELL=/bin/bash
ENV VISIBLE=now
ENV PYTHONPATH=/home/docker/AmazonSageMaker-sagemaker1/mllib/pylib
