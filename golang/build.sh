name=`basename ${PWD}`
tag=1.15.0

registry=ietty
docker build -t ${registry}/${name}:${tag} .
docker login
docker push ${registry}/${name}:${tag}

registry=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t ${registry}/${name}:${tag} .
aws ecr get-login-password | docker login --username AWS --password-stdin https://${registry}
docker push ${registry}/${name}:${tag}
