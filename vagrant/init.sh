
sudo apt-get update -y
sudo apt-get install -y python-crypto python-pip build-essential libssl-dev
sudo apt-get install -y libffi-dev python-dev bindfs

type docker &>/dev/null || sudo bash -c "wget -qO- https://get.docker.com/ | sh"
type docker-compose &>/dev/null || sudo curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose
type ansible &>/dev/null || sudo bash -c "pip install --upgrade pip && pip install --upgrade ansible"

sudo chmod +x /usr/bin/docker-compose
sudo chmod g+ws /opt
sudo chgrp users /opt
sudo usermod -G docker,users vagrant
sudo hostname devbase

sudo systemctl enable docker
sudo systemctl start docker

git config --global credential.helper store
grep "work/bin" /home/vagrant/.bashrc &>/dev/null || echo 'export PATH=${PATH}:~/work/bin' >> /home/vagrant/.bashrc
