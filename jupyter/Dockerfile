FROM jupyter/scipy-notebook

MAINTAINER "takemi.ohama" <takemi.ohama@ietty.co.jp>

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    wget curl ssh libreadline-dev vim gnupg \
    lsb-release \ 
    libxrender1 \
    mysql-client \
    language-pack-ja-base language-pack-ja fonts-mplus \
    ffmpeg graphviz mecab libmecab-dev mecab-ipadic-utf8

#RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  sudo apt-get update && sudo apt-get install -y google-cloud-sdk

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile && \
    echo "export TERM=xterm" >> /etc/profile && \
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jovyan

RUN update-locale LANGUAGE=ja_JP:ja LANG=ja_JP.UTF-8

USER $NB_USER

# Install Python 3 packages
RUN conda install --quiet --yes \
  'protobuf=3.6.*' \
  'conda-build' \
  'mysql-connector-python' \
  'pymysql' \
  'pydata-google-auth' \
  'pandas-gbq' \
  'jupyterlab' \ 
  'jupyterhub' \ 
  && conda build purge-all

RUN conda install --quiet --yes \
  'gensim' \ 
  'xgboost' \
  'lightgbm' \
  'tensorflow' \
  'seaborn' \
  'swig' \
  'imbalanced-learn' \
  'joblib' \
  'featuretools' \
  'deap' \
  'lime' \
  && conda build purge-all

RUN /opt/conda/bin/pip install --upgrade pip
RUN /opt/conda/bin/pip install redis hiredis pybigquery bash_kernel jupyter_contrib_nbextensions
RUN python -m bash_kernel.install & \
  jupyter contrib nbextension install --user & \
  jupyter nbextension enable codefolding/main & \
  jupyter contrib nbextensions migrate & \
  jupyter nbextension enable --py widgetsnbextension --sys-prefix

