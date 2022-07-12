FROM jupyterhub/jupyterhub:latest

RUN pip install jupyterlab oauthenticator dockerspawner sudospawner fargatespawner

ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PYTHONUNBUFFERED=TRUE \
    PYTHONDONTWRITEBYTECODE=TRUE \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    VISIBLE=now 

RUN useradd -m -s /bin/bash docker && \
    usermod -aG users docker && \
    usermod -aG users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh

RUN useradd -m -s /bin/bash takemi.ohama && \
    usermod -aG users takemi.ohama

COPY jupyterhub_config.py /etc/jupyter/jupyterhub_config.py

CMD ["jupyterhub","-f","/etc/jupyter/jupyterhub_config.py"]