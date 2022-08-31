name=`basename ${PWD}`
tag=`date +%Y%m%d`01

registry=ietty

docker build -t ${registry}/${name}:${tag} .

function pushDockerHub(){
    docker tag ${registry}/${name}:${tag} ${registry}/${name}:latest
    docker login
    docker push ${registry}/${name}:${tag}
    docker push ${registry}/${name}:latest
    echo "pushed: ${registry}/${name}:${tag}"

}

pushDockerHub

