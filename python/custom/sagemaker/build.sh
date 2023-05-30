name=`basename ${PWD}`
tag=`date +%Y%m%d`01

registry=ietty

#docker build --no-cache -t ${registry}/${name}:${tag} .
docker build -t ${registry}/${name}:${tag} .
docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest

function pushDockerHub(){
    docker login
    docker push ${registry}/${name}:${tag}
    docker push ${registry}/${name}:latest
    echo "pushed: ${registry}/${name}:${tag}"
}

function pushPrivateECR(){
    aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
    aws ecr create-repository --repository-name ${name}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:${tag}
    docker tag ${registry}/${name}:${tag} ${private_ecr}/${name}:latest
    docker push ${private_ecr}/${name}:${tag}
    docker push ${private_ecr}/${name}:latest
    echo "pushed: ${private_ecr}/${name}:${tag}"
}


pushDockerHub

private_ecr=888777505088.dkr.ecr.ap-northeast-1.amazonaws.com
pushPrivateECR
