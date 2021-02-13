FROM jordan/rundeck:3.0.6

LABEL MAINTAINER=takemi.ohama<takemi.ohama@gmail.com>

RUN apt-get update && \
    apt-get install -y locales task-japanese vim wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "rundeck ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/rundeck
RUN sed -i -e "s/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"  
RUN alias ll='ls -la'

RUN echo "export LANG=ja_JP.UTF-8" >> /root/.bashrc
RUN echo "export LANG=ja_JP.UTF-8" >> /etc/profile
RUN echo "export LANG=ja_JP.UTF-8" >> /etc/rundeck/profile
RUN echo "export PYTHONPATH=/var/rundeck" >> /etc/profile
RUN echo "export PYTHONPATH=/var/rundeck" >> /etc/rundeck/profile

