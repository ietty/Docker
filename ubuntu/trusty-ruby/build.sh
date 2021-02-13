name=`basename ${PWD}`
tag=latest

registry=ietty
docker build -t ${registry}/${name}:${tag} .
docker login
docker push ${registry}/${name}:${tag}

