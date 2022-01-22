FROM jupyter/tensorflow-notebook:016833b15ceb

LABEL MAINTAINER takemi.ohama@ietty.co.jp

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    wget curl ssh libreadline-dev vim \
    mysql-client \
    language-pack-ja-base language-pack-ja fonts-mplus && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jovyan

RUN update-locale LANGUAGE=ja_JP:ja LANG=ja_JP.UTF-8

RUN groupadd -g 500 ec2-user && \
    useradd -u 500 -g 500 -m -s /bin/bash ec2-user && \
    useradd -u 1001 -g 500 -m -s /bin/bash docker && \
    usermod -G ec2-user jovyan && \
    usermod -G ec2-user docker 

USER $NB_USER
ENV VISIBLE=now
ENV TERM=xterm

# Install Python 3 packages
RUN conda install --quiet --yes \
  'conda-build' \
  'pymysql' \
  'google-auth' \  
  'pydata-google-auth' \
  'pandas-gbq' \
  'boto3' \
  'autopep8' \
  'ptvsd' \
  'xeus-python' \
  && conda build purge-all

RUN conda install --quiet --yes \
  'lightgbm' \
  'catboost' \
  'imbalanced-learn' \
  'featuretools' \
  && conda build purge-all

RUN conda install --quiet --yes \
  'gensim' \
  'tqdm' \
  'sentencepiece' \
  'google-cloud-language' \
  && conda build purge-all

RUN /opt/conda/bin/pip install --upgrade pip
RUN /opt/conda/bin/pip install \
  redis hiredis \
  pybigquery \
  bash_kernel \
  jupyter_contrib_nbextensions \
  environment_kernels \
  jupyterlab_execute_time

RUN python -m bash_kernel.install && \
    jupyter labextension install \
    @jupyterlab/debugger \
    && \
    jupyter contrib nbextension install --user 

ENV JUPYTER_ENABLE_LAB=yes
CMD start-notebook.sh --NotebookApp.token=''
