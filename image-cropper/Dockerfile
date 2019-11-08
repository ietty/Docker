FROM ubuntu:18.10

MAINTAINER takemi.ohama <takemi.ohama@gmail.com>
LABEL com.amazonaws.sagemaker.capabilities.accept-bind-to-port=true

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         nginx \
         python3 \
         python3-pip \
         ca-certificates \
         libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install numpy==1.16.2 scipy==1.2.1 scikit-learn==0.20.2 pandas  \
                 flask gevent gunicorn setuptools opencv-python && \
        (cd /usr/local/lib/python3.6/dist-packages/scipy/.libs; rm *; ln ../../numpy/.libs/* .) && \
        rm -rf /root/.cache
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY program /opt/program
WORKDIR /opt/program