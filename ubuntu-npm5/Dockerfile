From ubuntu:xenial

MAINTAINER "takemi.ohama" <takemi.ohama@ietty.co.jp>

RUN apt-get upgrade -y && apt-get update && apt-get install -y apt-utils
RUN apt-get install -y vim wget curl tzdata git ca-certificates sudo locales 
RUN apt-get install -y language-pack-ja-base language-pack-ja 
RUN apt-get install -y nodejs npm

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable

#npmとnodeを最新版に更新
RUN npm cache clean
RUN npm install --no-progress -g n  
RUN n 7.10.1 
RUN apt-get purge -y nodejs npm
RUN npm install --no-progress -g yarn typings typescript @angular/cli 
RUN yarn global add npm@5.3.0

RUN sed -i -e "s/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

RUN useradd -m -s /bin/bash docker && \
    usermod -G users docker && \
    usermod -G users root && \
    echo '%users ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /home/docker/.ssh && chown docker.docker /home/docker/.ssh


RUN echo 'export DISPLAY=:99' >> /etc/profilei && \
    echo 'export CHROME_BIN=/usr/bin/google-chrome-stable' >> /etc/profile && \
    echo 'export PATH=/usr/local/bin:$PATH' >> /etc/profile && \ 
    echo 'export PATH=/usr/local/bin:$PATH' >> /root/.bashrc 

#/optはvolumesで利用するので便宜的に移動
#RUN mv /opt/google /var/lib && \
#    rm -f /usr/bin/google-chrome-stable && \
#    ln -s /var/lib/google/chrome/google-chrome /usr/bin/google-chrome-stable

USER docker
WORKDIR /home/docker


ENV DISPLAY=:99
ENV CHROME_BIN=/usr/bin/google-chrome-stable

EXPOSE 3000 3001 1080

CMD ["tail","-f","/dev/null"]
