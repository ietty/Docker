FROM tensorflow/tensorflow:2.4.1-jupyter

LABEL MAINTAINER takemi.ohama<takemi.ohama@gmail.com>

RUN pip install pandas mysql-connector-python pymysql \
        pandas-gbq nest-asyncio jupyterlab gensim \
        lightgbm catboost imbalasnced-learn bash_kernel \
        jupyter_contrib_nbextensions environment_kernels


RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh

RUN echo "export VISIBLE=now" >> /etc/profile

USER docker
WORKDIR /homr/docker

RUN python -m bash_kernel.install & \
  jupyter contrib nbextension install --user & \
  jupyter nbextension enable codefolding/main & \
  jupyter contrib nbextensions migrate & \
  jupyter labextension install @yunabe/lgo_extension & \
  jupyter nbextension enable --py widgetsnbextension --sys-prefix

