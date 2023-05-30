FROM ietty/python310:latest

USER docker

RUN mamba install -y \
    pandas-gbq \
    jupyter \
    jupyterlab \
    jupyterhub

RUN mamba install -y \
    scikit-learn \
    gensim \
    emoji \
    jaconv 

RUN mamba install -y \
    autopep8 \
    line_profiler \
    memory_profiler  \
    && mamba clean --all -f -y

RUN mkdir -p /home/docker/jupyter

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    mecab libmecab-dev mecab-ipadic-utf8 make xz-utils patch file \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV OPT_ADD=mecab-ipadic-neologd
RUN mkdir -p /opt/${OPT_ADD} \
    && chown docker.users /opt/${OPT_ADD} \
    && chmod g+s /opt/${OPT_ADD}
ENV OPT_ADD=

USER docker

RUN pip install \
  mecab-python3 \
  && pip cache purge

WORKDIR /opt
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git 

WORKDIR /opt/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -y -p /opt/dic/mecab-ipadic-neologd

#mecab -d /opt/dic/mecab-ipadic-neologd
#mecab = MeCab.Tagger('-d /opt/dic/mecab-ipadic-neologd')

WORKDIR /home/docker/jupyter
CMD jupyter lab --ip='*' --no-browser --notebook-dir=/home/docker/jupyter
